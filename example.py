from kms_client.retrieve_keys import KMSClient

client = KMSClient("role-name", "us-east-1")
print(client.get_client_credentials("bucket-name", "file-path-to-apikey.json"))
