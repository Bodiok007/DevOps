# Ansible

## Structure

1. There are 3 playbooks:
   -  `setup-db-playbook.yml` - to setup mysql
   -  `setup-web-playbook.yml` - to setup nginx
   -  `setup-full-playbook.yml` - to setup mysql and nginx

1. There are 4 roles:
   - `install_soft` - to update and install new packages
   - `user_config` - to add ssh key and update user configuration
   - `web_server` - for nginx
   - `mysql_server` - for mysql

1. Resources file:
   - `inventory.ini` - keeps information about hosts, users and keys
  
## Workflow

1. Update variables in file [roles/user_config/vars/main.yml](roles/user_config/vars/main.yml):
   - `key: ""` - set your public ssh key content

2. Update variables in file [roles/mysql_server/vars/main.yml](roles/mysql_server/vars/main.yml):
   - `mysql_root_password: "your_root_password"` - set your root password
   - `mysql_user: "your_username"` - set your user name
   - `mysql_user_password: "your_user_password"` - set your user password
   - `mysql_database: "ansible"` - set your db name
  
3. Update information about hosts in in [inventory.ini](inventory.ini):
   - `54.146.65.212` - set IP
   - `ansible_ssh_user=ubuntu` - set user
   - `ansible_ssh_private_key_file=DevOps-key.pem` - set private ssh key public part of which is already present on remote host

4.   Put already existed on remote machine ssh key to root folder with name as in [inventory.ini](inventory.ini) (currenlty DevOps-key.pem, but you can change it to whatever you need)

5. Run Web playbook:
```
ansible-playbook -i inventory.ini --diff -vvv setup-web-playbook.yml
```

6. Run Db playbook:
```
ansible-playbook -i inventory.ini --diff -vvv setup-db-playbook.yml
```

7. Run full playbook:
```
ansible-playbook -i inventory.ini --diff -vvv setup-full-playbook.yml
```
