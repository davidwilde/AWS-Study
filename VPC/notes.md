# Virtual Private Cloud

logically isolated virtual network

AWS VPC resembes a traditional network you'd operate in your own datacenter

Has many differenct networking components

Virtual machines EC2 is the most common reason for using a VPC in AWS
Virtual networking cards e.g. ELastic Networking Interfaces


## Core components

### Internet Gateway

A gateway that connects your VPC out to the internet

### Virtual Private Gateway

A gateway that connects your VPC to a private external network

### Route tables

determines where to route traffic within a VPC

### NAT Gateway

Allows private instances (eg Virtual Machines) to connect to services outside the VPC

### Network Access Control Lists (NACLs)

Acts as a **stateless** virtual firewall for compute within a VPC. Operates at the subnet level with allow and deny rules

### Security groups 

Acts as stateful virtual firewall for compute within a VPC operates at the instance level with allow rules

### Public subnets
Subnets allow instances to have public IP addresses

### Private Subnets
Subnets that disallow instances to have public IP addresses

### VPC Endpoints
Privately connect to AWS support services

### VPC Peering
Connecting VPCs to other VPCs


## Key features

- VPCs are region specific. They do not span regions
- You can create up to 5 VPC per region
- Every region comes with a defualt VPC
- You can have 200 subnets per VPC
- Upto 5 IPv4 CIDR Blocks per VPC
- Upto 5 IPv6 CIDR blocks per VPC
- Most components cost nothing
- Somethings cost money e.g NAT gateway
- DNS hostnames


