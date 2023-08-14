import sys
import json
from eth_account import Account
from eth_account.signers.local import LocalAccount
from eth_account.messages import encode_defunct
from web3 import Web3

# Replace with your actual private key
p_key= "0x83485dec5e7172920d22e6945311aba8a78c33b7428ec06a064fa9d0a69661ce"  # Your private key here

# Create an Account object from the private key
account: LocalAccount = Account.from_key(p_key)

data = {
    "Welcome": "Hello World",
    "secret": "247"
}

def sign_message(_message):
    # Convert JSON dictionary to a string
    data_string = json.dumps(data)
    
    # Hash the message
    message_hash = Web3.keccak(text=data_string).hex()

    # Encode the message using EIP191 encoding
    message_to_sign = encode_defunct(text=message_hash)

    # Sign the provided message
    signature = account.sign_message(message_to_sign)
    
    ec_recover_args = (d_string, msg_hash, msg_to_sign, msghash, v, r, s) = (
    data_string,
    message_hash,
    message_to_sign,
    Web3.to_hex(signature.messageHash),
    signature.v,
    to_32byte_hex(signature.r),
    to_32byte_hex(signature.s),
)
    
    # # The signature includes the v, r, and s components
    # v = signature['v']
    # r = signature['r']
    # s = signature['s']
    
    print(ec_recover_args)
    
def to_32byte_hex(val):
  return Web3.to_hex(Web3.to_bytes(val).rjust(32, b'\0'))





# Fetch the message from the command line argument
message = sys.argv[0]
sign_message(message)
