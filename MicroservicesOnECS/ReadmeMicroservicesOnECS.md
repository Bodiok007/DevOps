1. Lets assume we have next network structure with related route tables: 
- VPC
- 2 public network
- 2 private network
- Internet Gateway
- NAT Gateway

2. Create security group and allow ports in range 32768-65535 as they will be allocated dynamically for ECS tasks. Also port 80 for load balancer.
3. Create target group for port 8082. This port is exposed by microservice container.
4. Create Application Load Balancer.
5. Create cluster with autoscaling for min 2 EC2 Linux instances and max 5 when cpu usage more then 70%. 
6. Create task definision for EC2 instances and default network mode. Set container from repo and configure port 8082. For host 0 - dynamic assigning.
7. Create Service for Cluster with 2 tasks and Application Load Balancer created on step 4.
8. Lanch app by DNS name of Load Balancer.
