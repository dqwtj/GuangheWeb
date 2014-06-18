import pymongo
import datetime

connection = pymongo.Connection('42.120.11.41',27017)
db = connection.wechat_fans_development
codes = db.codes

fp = open("code10000-10.txt","r")
lines = fp.readlines()
for line in lines:
	tmp = line.strip().split('\t')
	code = {"code":tmp[0], "song":tmp[1], "created_at": datetime.datetime.utcnow()}
	print code
	codes.insert(code)