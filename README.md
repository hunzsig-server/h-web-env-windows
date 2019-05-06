# 完善配置好的一套php/web开发环境，适用于windows平台
> 至于 linux 为什么不配，那是因为 linux 用命令安装本身已经极其方便（推荐CentOS）
### 主体
```
nginx、apache、php
```
#### 开启拓展包含：
```
bz2、gd2、mbstring、xmlrpc
curl、imap、openssl、soap、sockets
odbc、mysqli、pgsql
pdo_mysql、pdo_odbc、pdo_pgsql、pdo_sqlite
opcache( >7.1默认开启)
```
#### 额外拓展包含：
```
igbinary、redis、lzf、pdo_sqlsrv、sqlsrv、mongodb、amqp
```

#### 建议clone到 **D:/Web**，改动最少
> git clone git@github.com:hunzsig/h-web-env-windows.git D:/Web/h-web-env-windows
