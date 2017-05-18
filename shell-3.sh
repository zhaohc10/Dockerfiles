# to see which process is listening on which port.
lsof -i :8000
sudo netstat -peant | grep ":8000 "



# 文件表达式

# 以下表达式被用来计算文件状态：

# 表达式	如果为真
# file1 -ef file2	file1 和 file2 拥有相同的索引号（通过硬链接两个文件名指向相同的文件）。
# file1 -nt file2	file1新于 file2。
# file1 -ot file2	file1早于 file2。
# -b file	file 存在并且是一个块（设备）文件。
# -c file	file 存在并且是一个字符（设备）文件。
# -d file	file 存在并且是一个目录。
# -e file	file 存在。
# -f file	file 存在并且是一个普通文件。
# -g file	file 存在并且设置了组 ID。
# -G file	file 存在并且由有效组 ID 拥有。
# -k file	file 存在并且设置了它的“sticky bit”。
# -L file	file 存在并且是一个符号链接。
# -O file	file 存在并且由有效用户 ID 拥有。
# -p file	file 存在并且是一个命名管道。
# -r file	file 存在并且可读（有效用户有可读权限）。
# -s file	file 存在且其长度大于零。
# -S file	file 存在且是一个网络 socket。
# -t fd	fd 是一个定向到终端／从终端定向的文件描述符 。 这可以被用来决定是否重定向了标准输入／输出错误。
# -u file	file 存在并且设置了 setuid 位。
# -w file	file 存在并且可写（有效用户拥有可写权限）。
# -x file	file 存在并且可执行（有效用户有执行／搜索权限）。



# 字符串表达式

# 以下表达式用来计算字符串：

# 表达式	如果为真...
# string	string 不为 null。
# -n string	字符串 string 的长度大于零。
# -z string	字符串 string 的长度为零。
# string1 = string2

# string1 == string2
