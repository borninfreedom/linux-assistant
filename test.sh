#!/bin/bash
CD="cd"
LS="ls"
RM="rm"
CP="cp"
FIND="find"
GREP="grep"
OTHERS="others"
 
## 自定义函数1，不传递参数
cdFunction()
{
	##2，信息对话框
	zenity --info --width 300 --height 200 --text="用法：cd (参数)，进入到某个目录中,cd ..是返回到上一级目录，cd ../..是返回到上上一级目录，cd（回车） 进入用户主目录,cd ～进入用户主目录，cd -返回进入此目录之前所在的目录，cd !$把上个命令的参数作为cd参数使用。"
}
lsFunction()
{
	zenity --info --width 300 --height 200 --text="用法：ls (选项) （参数）,选项-l，所有输出信息用单列格式输出，不输出为多列，选项-t，用文件和目录的更改时间排序，参数一般为文件或者目录。"	
}
rmFunction()
{
	zenity --info --width 300 --height 200 --text="用法：rm (选项) （参数）,选项-f，即使原档案属性设为唯读，也可以删除，无需逐一询问，选项-r，将目录及以下之档案逐一删除。"	
}
cpFunction()
{
	zenity --info --width 300 --height 200 --text="用法：cp (选项) （参数）,选项-a，这个选项通常在复制目录时使用，它保留链接、文件属性，并复制目录下的所有内容，选项-r，若给出的源文件是一个目录文件，此时将复制该目录下所有的子目录和文件。"	
}
## 自定义函数2，传递参数
checkFunction()
{
	declare i
	if [ $1 == 1 ]
	then
		echo $2
	else
		tmp=$2
		for((i=0;i<$1;i++))
		do
			str=${tmp%%|*}
			tmp=${tmp#*|}
			echo $str
		done
	fi
}
########## function 1 
while((1))
do
	##1，列表单选框
	select_command=$(zenity --list --radiolist --width 300 --height 400 --text="linux 常见命令" --column="选择" --column="内容列表" TRUE $CD FALSE $LS FALSE $RM FALSE $CP);
	## 处理自定义函数的结果
	if [ "$select_command" == "$CD" ]
	then
		cdFunction
	elif [ "$select_command" == "$LS" ]
	then
		lsFunction
	elif [ "$select_command" == "$RM" ]
	then 
		rmFunction
	elif [ "$select_command" = "$CP" ]
	then 
		cpFunction
	else
		break
	fi
done
########## function 2 
while((1))
do
	##2，列表复选框
	select_option=$(zenity --list --checklist --width 300 --height 400 --text="查找命令" --column="选择" --column="内容列表" FALSE $FIND FALSE $GREP FALSE $LS FALSE $OTHERS);	
	if [ "$select_option" == "$FIND|$GREP|$LS|$OTHERS" ]
	then
		checkFunction 4 $select_option
	elif [ "$select_option" == "$FIND|$GREP|$LS" ] 
	then
		checkFunction 3 $select_option
	elif [ "$select_option" == "$FIND|$GREP|$OTHERS" ] 
	then
		checkFunction 3 $select_option
	elif [ "$select_option" == "$FIND|$LS|$OTHERS" ] 
	then
		checkFunction 3 $select_option
	elif [ "$select_option" == "$GREP|$LS|$OTHERS" ] 
	then
		checkFunction 3 $select_option
	elif [ "$select_option" == "$FIND|$GREP" ]
	then
		checkFunction 2 $select_option
	elif [ "$select_option" == "$FIND|$LS" ]
	then
		checkFunction 2 $select_option
	elif [ "$select_option" == "$FIND|$OTHERS" ]
	then
		checkFunction 2 $select_option
	elif [ "$select_option" == "$GREP|$LS" ]
	then
		checkFunction 2 $select_option
	elif [ "$select_option" == "$GREP|$OTHERS" ]
	then
		checkFunction 2 $select_option
	elif [ "$select_option" == "$LS|$OTHERS" ]
	then
		checkFunction 2 $select_option
	elif [ "$select_option" == "$FIND" ]
	then
		checkFunction 1 $select_option
	elif [ "$select_option" == "$GREP" ]
	then
		checkFunction 1 $select_option
	elif [ "$select_option" == "$LS" ]
	then
		checkFunction 1 $select_option
	elif [ "$select_option" == "$OTHERS" ]
	then
		checkFunction 1 $select_option
	else
		break
	fi
done
exit 0