' 开机启动wsl的sshd的方法：
' win+R打开运行窗口，输入shell:startup，将本脚本放入打开的目录中
' 打开wsl，以root创建可执行脚本/etc/init.wsl，其中加入一行service sshd $1，保存
Set ws = WScript.CreateObject("WScript.Shell")
ws.run "wsl -d CentOS7 -u root /etc/init.wsl start", vbhide