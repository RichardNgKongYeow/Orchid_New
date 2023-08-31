import hashlib

def namehash(name):
    if name == '':
        return b'\0' * 32
    else:
        label, _, remainder = name.partition('.')
        return hashlib.sha3_256(namehash(remainder) + hashlib.sha3_256(label.encode()).digest()).digest()

name = "orchid.sgqr123"
hashed_name = namehash(name)
print(hashed_name.hex())