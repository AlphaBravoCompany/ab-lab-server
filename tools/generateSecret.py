#!/usr/bin/env python3

import bcrypt
import random
import string
import sys

def generatePassword():
    chars = string.ascii_uppercase + string.ascii_lowercase + string.digits
    size = random.randint(30, 30)
    return ''.join(random.choice(chars) for x in range(size))

def generateHash(password):
    hashed = bcrypt.hashpw(password, bcrypt.gensalt())
    if bcrypt.checkpw(password, hashed):
        return hashed
    else:
        print(f"Issue generating the bcrypt hash. Please try again.")

def printHelp():
    print(f"\n---\nUsage:\n")
    print(f"{sys.argv[0]} password\t\t\t - Generates a unique 30 character password.")
    print(f"{sys.argv[0]} hash <password>\t\t - Converts a password to bcrypt hash.")
    exit()


if __name__ == '__main__':

    if len(sys.argv)<2:
        printHelp()

    if sys.argv[1] == "password":
        if len(sys.argv) == 2:
            print(generatePassword())
        else:
            print(f"\n---\nError:\nToo many variables passed. Try again.")
            printHelp()
    
    elif sys.argv[1] == "hash":
        if len(sys.argv)<3:
            print(f"\n---\nError:\nPlease be sure to include a password.  Try again.")
            printHelp()
        else:
            if len(sys.argv[2])<30:
                print(f"\n---\nError:\nPlease use a password that is at least 30 characters.")
                printHelp()
            else:
                getPassword = sys.argv[2]
                getHash = generateHash(getPassword.encode('utf-8'))
                decodeHash = getHash.decode('utf-8')
                print(decodeHash)
    else:
        printHelp()