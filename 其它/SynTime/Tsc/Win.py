#https://www.cnblogs.com/ding5688/p/10978265.html
#install ntplib
#easy_install ntplib   or  pip install ntplib

import os
import time
import ntplib
c = ntplib.NTPClient()
response = c.request('182.92.12.11')
ts = response.tx_time
_date = time.strftime('%Y-%m-%d',time.localtime(ts)) 
_time = time.strftime('%X',time.localtime(ts))
os.system('date {} && time {}'.format(_date,_time))