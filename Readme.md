# kms_client

A python boto3 client to retrieve KMS keys. This project is deployable as a python package.

## Usage

1. Run `pip install kms-client`
2. Import the package using `from kms_client.retrieve_keys import KMS_Client`
3. Initialize the class with `client = KMS_Client()`
4. Call `client.get_client_credentials("bucket", key)` to get client id and client secret
