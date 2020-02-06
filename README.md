# 本项目仅用于个人学习、交流。
<br/>
## 项目介绍
收件系统是一个基于SSM框架的文件收取系统，项目采用SSM框架以及JSP开发，提供文件的上传、下载以及对文件的管理等功能。
<br/>
(本项目是仿造"快速创建收件夹"项目，如若侵权联系删除。)

### 项目技术栈
#### 后端技术栈
1. Spirng
2. SpringMVC
3. Mybatis
4. MySQL
5. ...

#### 前端技术栈
1. Bootstrap
2. Layui
3. JQuery
4. ...

### 项目效果图
对于发件者，无需注册，只需进入收件人发布的链接上传文件即可。此页面供收件人登陆、注册。

![image](http://github.com/DjbBobo/ReceiveFilePro/raw/master/images/1.png)

登陆成功后，可以查看所创建的收件夹。收件人可对每个收件夹进行编辑、修改收件时间、截止收件、删除收件夹、获取收件页面链接等操作。

![image](http://github.com/DjbBobo/ReceiveFilePro/raw/master/images/2.png)

进入收件夹，可以查看所收取的文件信息，可对其进行删除、下载、打包。

![image](http://github.com/DjbBobo/ReceiveFilePro/raw/master/images/3.png)

收件人可以创建、编辑收件页面，设置相应的文件命名规则，截止收件日期，所属模块等等。

![image](http://github.com/DjbBobo/ReceiveFilePro/raw/master/images/4.png)

此页面为收件人所成功创建后的界面，供发件人填写相应信息、上传文件。

![image](http://github.com/DjbBobo/ReceiveFilePro/raw/master/images/5.png)

### 项目部署相关说明
本项目所接收的文件，均存储到C盘的upload文件夹，如需修改，编辑service.impl包下的FileServiceImpl以及FolderServiceImpl文件中的的path变量。
MySQL配置信息:resources/db.properties。
### 待完善功能
1. 邮件发送。
2. 手机端扫描二维码后，无法实现文件上传。
3. 实现多文件上传。
4. 调用百度云API将文件同步到百度云。
5. ...





