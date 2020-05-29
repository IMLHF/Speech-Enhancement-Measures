# ./toserver.sh room@15123 pc_RealIRM_RelativeLossAFD500

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Need a destination."
  exit -1
fi
site=${1#*@}
user=${1%@*}
rm _data _log -rf
rm *__pycache__* -rf
rm */__pycache__* -rf
# mv exp ../
# # scp -r -P 15044 ./* xxxx@speaker.is99kdf.xyz:~/lhf/work/irm_test/extract_tfrecord
# scp -r -P 15043 ./* xx@speaker.is99kdf.xyz:~/work/speech_en_test/c001_se

# mv ../exp ./

if [ "$site" == "p40" ]; then
  echo "To $user@$site:/home/zhangwenbo5/lihongfeng/$2"
  rsync -avh -e "ssh -p 22 -o ProxyCommand='ssh -p 8695 zhangwenbo5@120.92.114.84 -W %h:%p'" --exclude-from='.gitignore' ./* zhangwenbo5@ksai-P40-2:/home/zhangwenbo5/lihongfeng/$2
elif [ "$site" == "v100-3" ]; then
  echo "To $user@$site:/home/zhangwenbo5/lihongfeng/$2"
  rsync -avh -e "ssh -p 22 -o ProxyCommand='ssh -p 8695 zhangwenbo5@120.92.114.84 -W %h:%p'" --exclude-from='.gitignore' ./* zhangwenbo5@ksai-v100-3:/home/zhangwenbo5/lihongfeng/$2
elif [ "$site" == "15123" ] || [ "$site" == "15041" ] || [ "$site" == "15043" ]; then
  echo "To $user@$site:~/worklhf/$2"
  rsync -avh -e 'ssh -p '$site --exclude-from='.gitignore' ./* $user@speaker.is99kdf.xyz:~/worklhf/$2
fi
# -a ：递归到目录，即复制所有文件和子目录。另外，打开归档模式和所有其他选项（相当于 -rlptgoD）
# -v ：详细输出
# -e ssh ：使用 ssh 作为远程 shell，这样所有的东西都被加密
# --exclude='*.out' ：排除匹配模式的文件，例如 *.out 或 *.c 等。

# scp -r -P 15043 xx@speaker.is99kdf.xyz:/home/xx/work/paper_se_test/pc001_se/exp/rnn_speech_enhancement/nnet_C001/nnet_iter15* ./
# scp -P 15223 xx@speaker.is99kdf.xyz:/fast/worklhf/paper_se_test/C_UNIGRU_RealPSM_RelativeLossAFD100/exp/rnn_speech_enhancement/nnet_C_UNIGRU_RealPSM_RelativeLossAFD100/nnet_iter25* ./
