' 开机启动wsl的sshd的方法：
' win+R打开运行窗口，输入shell:startup，将本脚本放入打开的目录中
' 打开wsl，以root创建可执行脚本/etc/init.wsl，其中加入一行/etc/init.d/ssh $1，保存
' 打开wsl，以root编辑/etc/sudoers，其中加入一行%sudo ALL=NOPASSWD: /etc/init.wsl，保存
Set ws = WScript.CreateObject("WScript.Shell")
ws.run "C:\Ubuntu18.04\ubuntu1804.exe run sudo /etc/init.wsl start", vbhide