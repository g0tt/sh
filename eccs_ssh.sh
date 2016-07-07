#!/bin/bash
if [ $# = 0 ]; then
  read -p "Username: " uid
  read -sp "Password: " pass
elif [ $# = 1 ]; then
  uid=$1
  read -sp "Password: " pass
elif [ $# -gt 1 ]; then
  uid=$1
  pass=$2
fi

o=`curl -F "userID=$uid" -F "passWD=$pass" -F "type=file" -F "file=@${HOME}/.ssh/id_rsa.pub" https://secure.ecc.u-tokyo.ac.jp/eccs/keyUpload.cgi`
case "$o" in
  *ログインできるように*)
    echo 公開鍵のアップロードに成功しました
    echo 接続先は以下から選択してください:
    echo *ssh0-01.ecc.u-tokyo.ac.jp / 192.51.223.234
    echo *ssh0-02.ecc.u-tokyo.ac.jp / 192.51.223.235
    echo *ssh0-03.ecc.u-tokyo.ac.jp / 192.51.223.236
    echo ex: ssh $uid@ssh0-01.ecc.u-tokyo.ac.jp
    echo ex: scp -r $uid@ssh0-01.ecc.u-tokyo.ac.jp:~/Desktop/foo.txt '~/'
  ;;
  *)
    echo 公開鍵のアップロードに失敗しました
  ;;
esac
