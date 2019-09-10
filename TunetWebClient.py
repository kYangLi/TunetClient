#!/home/alex/Program/Anaconda3.5/bin/python
#

import requests
import time 
import os
import json
import getpass
import hashlib
import getopt
import sys

class TunetWebClient:
  def __init__(self, url, post_data):
    self.url = url
    self.post_data = post_data
    self.respond = ''

  def post_request(self):
    respond = requests.post(url = self.url, data = self.post_data)
    self.respond = respond

  def print_respond(self):
    print('[responds] ', self.respond)
    if self.respond.status_code == 200:
      print('[done] POST Request Send!')
    elif self.respond.status_code == 404:
      print('[error] Server Not Found...')
    else:
      print("[error] Unknown State!!!")

class TunetConfigData:
  def __init__(self, config_file_path, default_url):
    self.__kDefaultLoginURL = default_url[0]
    self.__kDefaultLogoutURL = default_url[1]
    self.__kDefaultLogcheckURL = default_url[2]
    self.__kDefaultRedirectIndex = '1'
    self.key_list = ['login_url' ,
                     'logout_url',
                     'logcheck_url',
                     'username'  ,
                     'password'  ,
                     'ac_id'      ]
    self.path = config_file_path
    self.conf_data_is_valued = {'login_url'    : False, 
                                'logout_url'   : False,
                                'logcheck_url' : False, 
                                'username'     : False, 
                                'password'     : False, 
                                'ac_id'        : False }
    self.conf_data = {}
    self.login_post_data = {}
    self.logout_post_data = {}

  def file_check(self):
    if not os.path.exists(self.path):
      print("Creating configration file: ", self.path)
      with open(self.path, "w+") as fcp:
        pass
      del fcp
    else:
      print("[info] Using configure file: ", self.path)

  def value_valid(self, key):
    return (key in self.conf_data.keys()) and \
           (self.conf_data[key] != '')

  def read(self):
    with open(self.path, "r") as jfrp:  # Json File Read Pointer
      self.conf_data = json.load(jfrp)
    for key in self.key_list:
      if self.value_valid(key):
        self.conf_data_is_valued[key] = True
  
  def assignment(self):
    # Login URL
    if not self.conf_data_is_valued['login_url']:
      print("[require] 'login_url' has not been set...")
      print("[do] Set to default value: ", self.__kDefaultLoginURL)
      self.conf_data['login_url'] = self.__kDefaultLoginURL
      self.conf_data_is_valued['login_url'] = True
    # Logout URL
    if not self.conf_data_is_valued['logout_url']:
      print("[require] 'logout_url' has not been set...")
      print("[do] Set to default value: ", self.__kDefaultLogoutURL)
      self.conf_data['logout_url'] = self.__kDefaultLogoutURL
      self.conf_data_is_valued['logout_url'] = True
    # Logcheck URL
    if not self.conf_data_is_valued['logcheck_url']:
      print("[require] 'logcheck_url' has not been set...")
      print("[do] Set to default value: ", self.__kDefaultLogcheckURL)
      self.conf_data['logcheck_url'] = self.__kDefaultLogcheckURL
      self.conf_data_is_valued['logcheck_url'] = True
    # User Name
    if not self.conf_data_is_valued['username']:
      print("[require] 'username' has not been set...")
      print("[input] Please input your USER NAME.")
      self.conf_data['username'] = input('> ').replace(' ','')
      self.conf_data_is_valued['username'] = True
    # Password
    if not self.conf_data_is_valued['password']:
      print("[require] 'password' has not been set...")
      print("[input] Please input your PASSWORD.")
      print("[info] The PASSWORD you input will be translate into MD5 code,")
      print("[info]   which is more safe for saving in configration file.")
      raw_passwd = getpass.getpass('> ')
      md5_passwd = hashlib.md5(raw_passwd.encode()).hexdigest()
      del raw_passwd
      self.conf_data['password'] = '{MD5_HEX}' + md5_passwd
      self.conf_data_is_valued['password'] = True
    # Redirect Index
    if not self.conf_data_is_valued['ac_id']:
      print("[require] 'ac_id' has not been set...")
      print("[do] Set to default value: ", self.__kDefaultRedirectIndex)
      self.conf_data['ac_id'] = self.__kDefaultRedirectIndex
      self.conf_data_is_valued['ac_id'] = True

  def write(self):
    with open(self.path, "w") as jfwp:  # Json File Write Pointer
      json.dump(obj=self.conf_data, fp=jfwp, sort_keys=True, indent=2)
  
  def gen_login_post_data(self):
    self.login_post_data['action'] = 'login'
    self.login_post_data['username'] = self.conf_data['username']
    self.login_post_data['password'] = self.conf_data['password']
    self.login_post_data['ac_id'] = self.conf_data['ac_id']
  
  def gen_logout_post_data(self):
    self.logout_post_data['action'] = 'logout'
    self.logout_post_data['username'] = self.conf_data['username']
    self.logout_post_data['ac_id'] = self.conf_data['ac_id']

def set_config_data(config_file, default_url, signal_flag):
  config_data = TunetConfigData(config_file, default_url)
  config_data.file_check()
  if os.path.getsize(config_data.path) != 0: 
    config_data.read()
  need_init = False
  for key in config_data.conf_data_is_valued:
    if not config_data.conf_data_is_valued[key]:
      need_init = True
      break
  if need_init:
    config_data.assignment()
    config_data.write()
  if signal_flag == 'O':
    log_url = config_data.conf_data['login_url']
    logcheck_url = config_data.conf_data['logcheck_url']
    config_data.gen_login_post_data()
    post_data = config_data.login_post_data
  else:
    log_url = config_data.conf_data['logout_url']
    logcheck_url = ''
    config_data.gen_logout_post_data()
    post_data = config_data.logout_post_data
  # return 
  return log_url, logcheck_url, post_data
      
def connect_tunet(config_file, default_url):
  print("[do] Read the configration file...")
  login_url, logcheck_url, login_post_data = \
    set_config_data(config_file, default_url , 'O')
  print("[do] Connecting to the TUNET...")
  print('[info] Using API: ', login_url)
  login_web = TunetWebClient(login_url, login_post_data)
  login_web.post_request()
  login_web.print_respond()
  print('[do] Checking the connection...')
  logcheck_web = TunetWebClient(logcheck_url, 'NULL')
  logcheck_web.post_request()
  check_respond = logcheck_web.respond.content.decode('UTF-8')
  if check_respond != '':
    data_usage = int(check_respond.split(',')[6]) / 10**9
    kFreeData = 25 
    RMBperGB = 2
    network_fee = 0.00 
    if data_usage > kFreeData:
      network_fee = (data_usage - kFreeData) * RMBperGB
    print('[respond] Data Usage: %.2f/25.00 (GB)' %(data_usage))
    print('[respond] %.2f RMB was payed to TUNET \(▔＾▔)/' %(network_fee))
  else:
    print('[respond] Data Usage: Unkonwn.')
    print('[tips] It is ok if you are connected with ipv6 channel.')
    print('[tips] For ipv6 is free, the server will not record its usage.')
    print('[tips] Otherwise, you might need to check the internet connection.')
    
    

def disconnect_tunet(config_file, default_url):
  print("[do] Read the configration file...")
  logout_url, useless_value, logout_post_data = \
    set_config_data(config_file, default_url , 'X')
  del useless_value
  print("[do] Disconnecting from TUNET...")
  print('[info] Using API: ', logout_url)
  logout_web = TunetWebClient(logout_url, logout_post_data)
  logout_web.post_request()
  logout_web.print_respond()
  total_wait_time = 5
  for current_time in range(total_wait_time):
    remaining_time = total_wait_time - current_time
    print("[info] Please wait %ds unit the server responds..." \
          %(remaining_time), end="\r")
    time.sleep(1)
  print("[info] Please wait 0s unit the server responds...  ")
  print("[done] Disconnected!")


def read_in_options(argv):
  try:
    opts, args = getopt.getopt(argv, "s:f:i:",
                               ["signal=", "file==", "ipv=="])
  except getopt.GetoptError:
    print('tunet.py -s <O/X>. -f <file.conf> -i 4/6')
    print('"O" for connect, "X" for disconnect.')
    sys.exit(2)
  del args
  signal_flag = ''
  config_file = ''
  ip_version = '4'
  for opt, arg in opts:
    if opt == '-h':
      print('tunet.py -s O/X. -f <file.conf> -i 4/6')
      print('"O" for connect, "X" for disconnect.')
      sys.exit()
    elif opt in ("-s", "--signal"):
      signal_flag = arg
    elif opt in ("-f", "--file"):
      config_file = arg
    elif opt in ("-i", "--ipv"):
      ip_version = arg
  # Return the options
  return ip_version, config_file, signal_flag

def main(argv):
  ## Constant Setting
  kIpv4ConfigFile = './tunet_ipv4.conf.josn'
  kIpv6ConfigFile = './tunet_ipv6.conf.josn'
  kIpv4LoginURL = 'http://auth4.tsinghua.edu.cn/srun_portal_pc.php'
  kIpv4LogoutURL = 'http://auth4.tsinghua.edu.cn/srun_portal_pc.php'
  kIpv4LogcheckURL = 'http://auth4.tsinghua.edu.cn/rad_user_info.php'
  kIpv6LoginURL = 'http://auth6.tsinghua.edu.cn/srun_portal_pc.php'
  kIpv6LogoutURL = 'http://auth6.tsinghua.edu.cn/srun_portal_pc.php'
  kIpv6LogcheckURL = 'http://auth6.tsinghua.edu.cn/rad_user_info.php'

  ## Read the command line input
  ip_version, config_file, signal_flag = read_in_options(argv)
  ## Connection to Web Client
  if ip_version == '6':
    if config_file == '':
      config_file = kIpv6ConfigFile
    default_url = [kIpv6LoginURL, kIpv6LogoutURL, kIpv6LogcheckURL]
  else:
    if config_file == '':
      config_file = kIpv4ConfigFile
    default_url = [kIpv4LoginURL, kIpv4LogoutURL, kIpv4LogcheckURL]
  if signal_flag == 'X':
    disconnect_tunet(config_file, default_url)
  else:
    connect_tunet(config_file, default_url)

if __name__ == '__main__':
  main(sys.argv[1:])
