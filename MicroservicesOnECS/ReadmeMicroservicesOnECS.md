1. Lets assume we have next network structure with related route tables: 
- VPC
- 2 public network
- 2 private network
- Internet Gateway
- NAT Gateway

2. Create security group and allow ports in range 32768-65535 as they will be allocated dynamically for ECS tasks. Also port 80 for load balancer.
![alt text](https://github.com/Bodiok007/DevOps/blob/develop/MicroservicesOnECS/Screenshots/SecurityGroup.png?raw=true)

3. Create target group for port 8082. This port is exposed by microservice container.
![alt text](https://github.com/Bodiok007/DevOps/blob/develop/MicroservicesOnECS/Screenshots/TargetGroup.png?raw=true)
  
4. Create Application Load Balancer.
![alt text](https://github.com/Bodiok007/DevOps/blob/develop/MicroservicesOnECS/Screenshots/LoadBalancer.png?raw=true)

5. Create cluster with autoscaling for min 2 EC2 Linux instances and max 5 when cpu usage more then 70%.
![alt text](https://github.com/Bodiok007/DevOps/blob/develop/MicroservicesOnECS/Screenshots/Cluster.png?raw=true)

6. Create task definision for EC2 instances and default network mode. Set container from repo and configure port 8082. For host 0 - dynamic assigning.
![alt text](https://github.com/Bodiok007/DevOps/blob/develop/MicroservicesOnECS/Screenshots/TaskDefinition.png?raw=true)

7. Create Service for Cluster with 2 tasks and Application Load Balancer created on step 4.
![alt text](https://github.com/Bodiok007/DevOps/blob/develop/MicroservicesOnECS/Screenshots/WorkingServiceWithTasks.png?raw=true)
   
13. Lanch app by DNS name of Load Balancer.
![alt text](https://github.com/Bodiok007/DevOps/blob/develop/MicroservicesOnECS/Screenshots/RunningApp.png?raw=true)
