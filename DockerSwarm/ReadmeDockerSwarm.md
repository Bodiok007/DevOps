1. Create AWS infrustructure by using [cloudformation-infrastructure-template.yaml](https://github.com/Bodiok007/DevOps/blob/develop/DockerSwarm/cloudformation-infrastructure-template.yaml).

Infrastructure contains 3 intances:
  - `devopsPublicEC2Instance` - will be used as Manager Node
  - `devopsPublicEC2Instance2` - will be used as Worker Node
  - `devopsPublicEC2Instance3` - will be used as Worker Node

2. Login to `devopsPublicEC2Instance` by ssh.

Will look like: `ssh -i "DevOps-key.pem" ubuntu@100.24.72.98`, where:
  - `"DevOps-key.pem"` - ssh key
  - `ubuntu@100.24.72.98` - remote machine, `ubuntu` is user, `100.24.72.98` is public IP of remote machine

3. Create and execute script file to install docker:
  - `nano install_docker.sh`
  - copy data from [install_docker.sh](https://github.com/Bodiok007/DevOps/blob/develop/DockerSwarm/install_docker.sh) and save
  - `sh install_docker.sh`

4. Init docker swarm: `sudo docker swarm init`.

This will show command to join other Nodes, sth like: `sudo docker swarm join --token SWMTKN-1-06g97dyujt1n11znizsiryqo3chkcpaov7wac8p3tq0j9q9yf5-758mjo9dpvxp2hjlw15jtmmq4 10.0.1.117:2377`.

Join command must be executed on Node which is going to be Worker.

5. Repeat Step 2. and 3. for `devopsPublicEC2Instance2` and `devopsPublicEC2Instance3`. Then join them to Manager Node by command provided in Step 4.

Template: `sudo docker swarm join --token <token> <ip>:2377`.

6. Create docker compose file on `devopsPublicEC2Instance`:
  - `nano docker-compose.yaml`
  - copy data from [docker-compose.yaml](https://github.com/Bodiok007/DevOps/blob/develop/DockerSwarm/docker-compose.yaml) and save

7. Create secrets on `devopsPublicEC2Instance`:

```
mkdir secrets
echo "wordpress" > secrets/database-name
echo "wppassword" > secrets/database-password
echo "mysecretpassword" > secrets/database-password-root
echo "wpuser" > secrets/database-user

```

7. Deploy multi-service application defined in a Docker Compose file to a Docker Swarm cluster: `sudo docker stack deploy --compose-file docker-compose.yaml swarmServices`

9. Open visualizer of Nodes on port 5000:

![alt text](https://github.com/Bodiok007/DevOps/blob/develop/DockerSwarm/Screenshots/SwarmVisualizer.png?raw=true)
