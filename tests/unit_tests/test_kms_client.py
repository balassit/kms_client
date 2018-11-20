import os
import unittest
from unittest.mock import MagicMock, patch


class test_kms_client(unittest.TestCase):
    def setUp(self):
        os.environ["environment"] = "local"


if __name__ == "__main__":
    unittest.main()
