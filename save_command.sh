#!/bin/bash

param1="$1"	#comment.
param2="$2"	#option list number to save.
date=`date`	#date information.
num_of_list=`cat ~/.bash_history | wc -l`	#The number of cmd history lists.
num=$((num_of_list - param2))			#list number to save.
num2=$((num_of_list - 1))                       #list number to save.(no option)
cmd=`sed -n ${num}p ~/.bash_history`		#list of command.
cmd2=`sed -n ${num2}p ~/.bash_history`          #list of command.(no option)

file_for_save=~/data_folder/cmd_hist.txt	 		#file to save the command.

#===============================
#comment out saving or deleting.
#===============================

if [ "$1" = "d" ]; then
	echo "....delete the previous histor"
fi

if [ "$1" != "d" -a \( "$#" = 1 -o "$#" = 0 \) ]; then
	echo "....saved the commnad....$ $cmd2"
fi

if [ "$1" != "d" -a "$#" = 2 ]; then
	echo "....saved the command....$ $cmd"
fi

#==================================
#creating file and saving commands.
#==================================


if [ ! -f "$file_for_save" ]; then		#create file for saving cmd.
	touch ~/data_folder/cmd_hist.txt
fi

if [ $# = 2 ]; then
	echo "#[$date]  >>>$param1" >> ~/data_folder/cmd_hist.txt
	echo "\$ $cmd" >> ~/data_folder/cmd_hist.txt
fi

if [ "$#" = 1 -a "$1" != "d" ]; then
	echo "#[$date]  >>>$param1" >> ~/data_folder/cmd_hist.txt
	echo "\$ $cmd2" >> ~/data_folder/cmd_hist.txt
fi


if [ -z "$param1" ]; then
	echo "#[$date]  >>>$param1" >> ~/data_folder/cmd_hist.txt
	echo "\$ $cmd2" >> ~/data_folder/cmd_hist.txt
fi

if [ "$1" = "d" ]; then				#delete the previous history.
	sed -i -e '$d' ~/data_folder/cmd_hist.txt 
	sed -i -e '$d' ~/data_folder/cmd_hist.txt
fi

#=======================================================
#excute with one operation by setting the alias command.
#=======================================================


#alias cm-s='history -a;save_command.sh'	#save commnad.
#alias cm-w='cat ~/data_folder/cmd_hist.txt'     		#watch the saved command.
#alias cm-w-l='cat ~/data_folder/cmd_hist.txt | less'		#open command history file with less.
#alias cm-w-v='vim ~/data_folder/cmd_hist.txt'		#open command history file with vim.	
#      cm-s d                                   #delete the previous history.
