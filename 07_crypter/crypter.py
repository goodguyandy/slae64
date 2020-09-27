#!/usr/bin/python3

import pyDes 
import argparse


#advanced crypter's settings

#Initialization vector 
IV=None 
MODE = pyDes.ECB 
PAD_MODE = pyDes.PAD_PKCS5





def clean_input(payload):
    bad_chars= ["0x", "." , "," , "db", "\\x"]
    for b in bad_chars:
        if b in payload:
            payload = payload.replace(b, "")
    return payload 




if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('payload', action='store', type=str, help="payload data")
    parser.add_argument('password', action='store', type=str, help="password to encrypt/decript")
    parser.add_argument('-d', action="store_true", help="if set, decrypt with the password set with -p")

    args = parser.parse_args()
    myDes = pyDes.des(str.encode(args.password), MODE, padmode=PAD_MODE, IV=IV)
    if args.d == True:
        d = myDes.decrypt(bytes.fromhex(args.payload), padmode=PAD_MODE)
        print("bytes: ")
        print(d)
    else:
        payload = clean_input(args.payload)
        print("----crypted-----")
        c = myDes.encrypt(payload)
        print("bytes:")
        print(c)

        print("hex:")
        print(c.hex())

        print("----decrypted-----")
        print("decrypted bytes")
        print(myDes.decrypt(c))
        
        

