#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import random
import string

count = 10000
dict = {}
while (len(dict) < count):
	salt = ''.join(random.sample(string.ascii_letters + string.digits, 8))
	if (dict.has_key(salt)): break
	dict[salt] = len(dict) % 10
for key in dict:
	print("%s\t%i" % (key, dict[key]))