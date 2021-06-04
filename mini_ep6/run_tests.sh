#!/bin/zsh
# Nome: Giovana Vieira de Morais
# NUSP: 11921908

n=10
delay=100000 # 100ms

while :
do
	echo "testing delay = $delay";

	executavel="ss_$delay"
	if [ ! -e $executavel ]; then
		echo "\tcompiling $executavel";
		gcc -DDELAY=$delay sleepSort.c -o $executavel;
	fi

	echo "\trunning"
	cmd_output=$(python3 corretude.py $executavel $n 2>&1);
	echo $cmd_output;

	if [ $cmd_output = "delay works!" ]
	then
		break;
	fi

	# incrementa 50ms
	delay=`expr $delay + 50000`;
done

echo "best delay is $delay";
