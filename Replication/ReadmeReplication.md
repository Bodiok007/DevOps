Lets assume there are two servers: Master and Replica with installed MySql.

1. Create user on Master with only replication permission:
```
CREATE USER 'replica_user'@'%' IDENTIFIED WITH mysql_native_password BY 'pass123Port#';
GRANT REPLICATION SLAVE ON *.* to 'replica_user'@'%';
FLUSH PRIVILEGES;
```

2. Open MySQL configuration file on Master:
```
sudo nano /etc/mysql/my.cnf
```

3. Add next configuration to the end of file to enable replication support:
```
[mysqld]
bind-address = 0.0.0.0
server-id=1
log-bin=mysql-bin
```

4. Restart MySQL server:
```
sudo systemctl restart mysql
```

5. Check status:
```
SHOW MASTER STATUS;
```
![CheckMasterStatus](https://github.com/Bodiok007/DevOps/blob/develop/Replication/Screenshots/CheckMasterStatus.png?raw=true)

6. Apply dump on Master from: [DbDump](https://github.com/Bodiok007/DevOps/blob/develop/MySQLDump/MySQLDump%20Ver%208.0.35-0ubuntu0.22.04.1%20for%20Linux%20on%20x86_64%20((Ubuntu)).sql)

7. Create new dump for `devops` database:
```
sudo mysqldump devops > devops.sql;
```

8. Open MySQL configuration file on Replica by command from Step 2. and next: 
```
[mysqld]
server-id=2
```

10. Restart MySQL server:
```
sudo systemctl restart mysql
```

11. Create database `devops` on Replica by command:
```
CREATE DATABASE devops;
```

12. Apply dump on Replica:
```
sudo mysql devops < dump.sql
```

13. Connect to Master:
```
CHANGE MASTER TO MASTER_HOST='192.168.56.12', MASTER_USER='replica_user', MASTER_PASSWORD='pass137Port#', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=157;
```

`MASTER_LOG_FILE` and `MASTER_LOG_POS` can be taken from output of command from Step 5.

14. Start replication process on Replica:
```
START SLAVE;
```

15. Check status of replication:
```
SHOW SLAVE STATUS\G;
```
![ReplicaStatus](https://github.com/Bodiok007/DevOps/blob/develop/Replication/Screenshots/ReplicaStatus.png?raw=true)

16. On Master insert new record to Employee table and check on Replica if it is available:
```
INSERT INTO `Employee` VALUES (11,'New','Emp','Project Manager','new.emp@example.com');
```

17. On Replica check if record is inserted:
```
SELECT * FROM Employee;
```
![ReplicaRecord](https://github.com/Bodiok007/DevOps/blob/develop/Replication/Screenshots/ReplicaRecord.png?raw=true)

## Possible issues

If you face error like:
```
Last_SQL_Error: Coordinator stopped because there were error(s) in the worker(s). The
most recent failure being: Worker 1 failed executing transaction 'ANONYMOUS' at source log mysql-bin.
000001, end_log_pos 447. See error log and/or performance schema.replication applier status by worker
table for more details about this failure or others, if any.
```

try to execute next commands:
```
STOP SLAVE SQL_THREAD;
SET GLOBAL sql_slave_skip_counter = 1;
START SLAVE SQL_THREAD;
```
