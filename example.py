from kms_client.retrieve_keys import KMS_Client

client = KMS_Client("role-name", "us-east-1")
print(client.get_client_credentials("bucket-name", "file-path-to-apikey.json"))
