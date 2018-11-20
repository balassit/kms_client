from base64 import b64decode
import boto3
import json
from kms_client.logger import JsonLogger as log

logger = log(__file__)


class KMSClient:
    def __init__(self, aws_profile="", aws_region=""):
        if not aws_profile and not aws_region:
            self.session = boto3.Session()
        else:
            self.session = boto3.Session(profile_name=aws_profile, region_name=aws_region)

    def get_client_credentials(self, bucket, s3_key_path):
        """
        Args:
            bucket (str): S3 bucket name
            s3_key_path (str): S3 key path
        Returns:
            string tuple of client id and client secret
        """
        s3 = S3(self.session)
        encrypted_token = s3.get_encrypted_file_from_s3(bucket, s3_key_path)
        logger.log("S3 complete")

        kms = KMS(self.session)
        decrypted_token = kms.decrypt(encrypted_token)
        logger.log("Decrypt complete")
        decrypted_json = json.loads(decrypted_token)

        return decrypted_json


class S3:
    def __init__(self, session):
        self.s3 = session.client("s3")

    def get_encrypted_file_from_s3(self, bucket_name, key):
        """
        Gets the content of a S3 file
        Args:
            bucket_name (str): S3 bucket name
            key (str): S3 key path
        Returns:
            S3 file content
        """
        obj = self.s3.get_object(Bucket=bucket_name, Key=key)
        return obj["Body"].read().decode("utf-8")


class KMS:
    def __init__(self, session):
        self.kms = session.client("kms")

    def decrypt(self, token):
        """
        Decrypts an encrypted token using AWS KMS
        Args:
            token (str): an encrypted token from KMS encryption
        Returns:
            a string which is the plaintext decrypted token
        """
        response = self.kms.decrypt(CiphertextBlob=b64decode(token))["Plaintext"]
        return response
