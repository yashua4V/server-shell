#!/bin/bash
basecode='0123456789qwertyuiopasdfghjklzxcvbnmABCDEFGHIJKLMNOPQRSTUVWXYZ()!@#$%^&*_+:<>?'
for i in {1..30}
    do
    random_num=$[$RANDOM%78]
    pice_code=${basecode:$random_num:1}
    pass_word=$pass_word$pice_code
done
random_num=$[$RANDOM%52]
baseword=qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM
pick_word=${baseword:$random_num:1}
random_num2=$[$RANDOM%52]
pick_word2=${baseword:$random_num2:1}
echo ${pick_word}${pass_word}${pick_word2}
