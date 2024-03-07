project_vpc                 = "my-project-vpc"
vpc_cidr_block              = "10.100.0.0/16"
public_subnet_1_cidr_block  = "10.100.16.0/24"
public_subnet_2_cidr_block  = "10.100.17.0/24"
private_subnet_1_cidr_block = "10.100.18.0/24"
private_subnet_2_cidr_block = "10.100.19.0/24"
availability_zone_1         = "us-west-2a"
availability_zone_2         = "us-west-2b"


db_name             = "db_team3"
db_username         = "admin"
db_engine_version   = "8.0.35"
engine              = "mysql"
skip_final_snapshot = true


#############BASTION###################
#############BASTION###################
#############BASTION###################
#############BASTION###################
#############BASTION###################


#vpc_id      = aws_vpc.project_vpc.id        #"vpc-0d522b96b0ea6cda2"  #<-- i dont know vpc_id yet      # sample VPC will need to change to one created in VPC module
my_ip       = "174.51.122.44/32"      #<-vss ip            #max added "162.10.95.93/32" # Your public IP address
bastion_ami = "ami-052c9ea013e6e3567" #<--us west-2 ami                # max ami---> - i think its east-1 "ami-0440d3b780d96b29d" # The AMI ID for the Bastion host
key_name    = "frontend"              #<--vss created key name         #--> key from max"linuxkey"  
#subnet_id = module.project_vpc.private_subnet_ids          #subnet_id   = "subnet-022a46627797d20d9" #<---i not sure yet .   same as VPC, will ned to be used one created in VPC module
instance_type = "t2.micro"


#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################

# ######ASG Vars#####
frontend_ami       = "ami-0243460fd3766e58e"
backend_ami        = "ami-0d618991e2c0f4d09"
secrets_permission = "arn:aws:iam::657126973073:role/mini_project"
frontend_asg_name  = "mini_project_frontend_asg"
backend_asg_name   = "mini_project_backend_asg"
#mini_project_frontend_asg

####ALB###
alb_name                           = "reviews-alb"
frontend_target_port               = "80"
backend_target_port                = "8080"
frontend_domain                    = "reviews.easydevops.click"
backend_domain                     = "reviews-api.easydevops.click"
s3_maintenance_page_hosted_zone_id = "Z3BJ6K6RIION7M"
frontend_dns_address = "reviews.easydevops.click"
#route53_domain_name = "easydevops.click"

/*  S3  */
bucket = "elenabv.click2"

/*  CloudWatch  */

emails = ["elenabv2023@gmail.com"]

# values for IAM module variables
# Variables needed for IAM user creation 
ID = ["931548186713", # Victoria
      "010433285772", # Elena
      "471112548632", # Mustafa
      "273620247470", # Adel
      "341505015036", # Michael
      "318434306848", # Madina
      "122104449212", # Mokhi
      "339713183355", # Sergei
      "678780095603"] # Erik

policies = [ "AdministratorAccess" ] # can add more policies and it will generate arn's automatically

role = "mini_project" # name of the role to create

time_limit = 43199