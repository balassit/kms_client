import os
import unittest
import boto3
import botocore
import mock
from boto3.session import Session
from unittest.mock import MagicMock, patch
from kms_client.retrieve_keys import KMSClient


class FakeResource:
    def Bucket(self, bucket):
        return self

    def get_encrypted_file_from_s3(self, bucket, s3_key_path):
        return self


class FakeSession(Session):
    def resource(self, profile_name="test", region_name="us-east-1"):
        return FakeResource()


@patch("kms_client.retrieve_keys.KMSClient.get_client_credentials", FakeSession)
class TestKmsClient(unittest.TestCase):
    def setUp(self):
        self.client = KMSClient()

    def test_get_client_credentials(self):
        response = self.client.get_client_credentials("bucket-name", "file-path-to-apikey.json")
        self.assertEqual("", "")


if __name__ == "__main__":
    unittest.main()
