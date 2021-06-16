FROM node:10 
WORKDIR /index
COPY package.json /index
RUN npm install
COPY . /index
CMD node index.js
EXPOSE 8888


# command to build a docker image
# docker build -t <name_here> .
# < . > is used here to suggest the current directory we are in
# docker run -it -p 8888:3000 <name_here>
# First Port is Port Exposed by docker 
# Second Port is Port used by our App
# -it is used to run it in an interactive shell
# -p is used to publish a container's port to the host
# you can always look for the commands by flag --help ex: <command_here --help>



# Now instead of deploying it to the localhost if you want to deploy it in the cloud
# PreRequisite: AWS CLI
# aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com
# Search for ECR in services
# Create an ECR Repo <repo_name>
# Upload the docker image we built on ECR by following command
# docker tag hello-world:latest aws_account_id.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest
# Now push the image by following command 
# docker push aws_account_id.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest
# Now navigate to the image URI and copy it somewhere as we'll need it later
# Now search for ECS in services
# Click on create a cluster and after that choose EC2 "<OS_you_are_using> + Networking"
# Click on Next Step and fil out the fields
# Cluster name* 
# Provisioning Model: On Demand (You can choose model acoording to your need {Spot/On-Demand/Reserved})
# Ec2 instance type: t2-micro as it's free (again you can select it according to your need)
# No of instances: 1 or acc to your need
# Leave Ec2 AMI Id as it is
# Root EBS volume as it is
# key pair : again optional
# Now come to Networking
# For VPC select default VPC
# Then Select the First Subnet
# Enable Auto Assign public IP
# Security Group: Use Default Security Group
# Now for Container insance IAM role you can create one or alreay use if you have an existing role
# Now Click on create
# Now after it has created go to task section
# Select Ec2 then click on next step
# Create a Task Definition Name
# Select task role None and Network Mode Default
# Task Memory: 1
# Task CPU: 1 vCPU
# Now click on Add Container
# Write a container Name
# Now paste the Image URI here that we copied
# Now scroll down to port mapping and map the ports and click on add
# Now scroll down to the bottom and click on create
# Now navigate back the Cluster and select Tasks
# under it click on Run a new task
# Select Launch type as Ec2 and leave everything else as it is
# click on run task
# Now navigate to security groups under nerwork and security and click on Security Group ID
# Click on Edit Inbound Rules and click on add rule
# Type: Custom TCP; Protocol: TCP; Port Range: <Port_Exposed>; Source:0.0.0.0/0
# Click on save rules
# Now search for the ec2 instances and under running instances copy the Public DNS of the instance
# paste it on your browser fololowed by the port you exposed
# You're Good to Go

