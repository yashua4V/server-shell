#!/bin/bash
for i in `ls *`
do
  score=0
    for ch in ${i//-/ }
    do
        case  $ch in
        before)
          let score+=100;;
        back)
          let score+=200;;
        web)
          let score+=10;;
        m)
          let score+=20;;
        chat)
          let score+=30;;
        bfswoole)
          let score+=40;;
        time)
          let score+=50;;
        test.sh)
          let score+=60;;
        ma)
          let score+=70;;
        esac
    done
  namesh=${i##*-}
  name=${namesh%%.*}
  if [ $name == "test" ]; then
      namesh=${i%%-test*}
      name=${namesh##*-}
  fi
  case $score in
  100)
    echo -e  -e  "\033[32m$i\033[0m 的类型是:\033[33m后端前台代码\033[0m"
    namebase=sy-back-front_desk-sy.sh
    shname=${namebase//sy/$name}
    echo -e  -e "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m\033[31m$shname\033[0m\033[0m 存放路径 \033[31m/hui_py/git/bt/script/back\033[0m"
    echo ''
    echo -e  '#################################';;
  200)
    echo -e  "\033[32m$i\033[0m 的类型是:\033[33m后端后台代码\033[0m"
    namebase=sy-back-background-sy.sh
    shname=${namebase//sy/$name}
    echo -e  "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m$shname\033[0m 存放路径 \033[31m/hui_py/git/bt/script/back\033[0m"
    echo ''
    echo -e  '#################################';;
  110)
    echo -e  "\033[32m$i\033[0m 的类型是:\033[33m前端pc端正式代码\033[0m"
    namebase=sy-befores-pc-sy.sh
    shname=${namebase//sy/$name}
    echo -e  "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m$shname\033[0m 存放路径 \033[31m/hui_py/git/bt/script/befores\033[0m"
    echo ''
    echo -e  '#################################';;
  120)
    echo -e  "\033[32m$i\033[0m 的类型是:\033[33m前端手机正式代码\033[0m"
    namebase=sy-befores-m-sy.sh
    shname=${namebase//sy/$name}
    echo -e  "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m$shname\033[0m 存放路径 \033[31m/hui_py/git/bt/script/befores\033[0m"
    echo ''
    echo -e  '#################################';;
  30)
    echo -e  "\033[32m$i\033[0m 的类型是:\033[33m聊天室代码\033[0m"
    namebase=sy-chat-sy.sh
    shname=${namebase//sy/$name}
    echo -e  "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m$shname\033[0m 存放路径 \033[31m/hui_py/git/bt/script/chat\033[0m"
    echo ''
    echo -e  '#################################';;
  40)
    echo -e  "\033[32m$i\033[0m 的类型是:\033[33m异步任务\033[0m"
    namebase=sy-back-bfswoole-sy.sh
    shname=${namebase//sy/$name}
    echo -e  "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m$shname\033[0m 存放路径 \033[31m/hui_py/git/bt/script/back\033[0m"
    echo ''
    echo -e  '#################################';;
  50)
    echo -e  "\033[32m$i\033[0m 的类型是:\033[33m定时任务\033[0m"
    namebase=sy-chat-time-sy.sh
    shname=${namebase//sy/$name}
    echo -e  "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m$shname\033[0m 存放路径 \033[31m/hui_py/git/bt/script/chat\033[0m"
    echo ''
    echo -e  '#################################';;
  160)
    echo -e  "\033[32m$i\033[0m 的类型是:\033[33m前端测试代码\033[0m"
    namebase=sy-befores-test-sy.sh 
    shname=${namebase//sy/$name}
    echo -e  "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m$shname\033[0m 存放路径 \033[31m/hui_py/git/bt/script/befores\033[0m"
    echo ''
    echo -e  '#################################';;
  170)
    echo -e  -e  "\033[32m$i\033[0m 的类型是:\033[33m后端代理手机版\033[0m"
    namebase=sy-back-front_desk-sy.sh
    shname=${namebase//sy/$name}
    echo -e  -e "拼音简写是:\033[34m$name\033[0m 建议修改脚本名称为\033[31m\033[31m$shname\033[0m\033[0m 存放路径 \033[31m/hui_py/git/bt/script/back\033[0m"
    echo ''
    echo -e  '#################################';;
  *)
    echo -e  "\033[32m$i\033[0m 未分类，请检查是否文件格式错误"
  esac
done
