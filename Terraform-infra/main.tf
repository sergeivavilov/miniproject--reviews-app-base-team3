
module "project_vpc" {
  source                      = "./modules/Networking"
  project_vpc                 = var.project_vpc
  vpc_cidr_block              = var.vpc_cidr_block
  public_subnet_1_cidr_block  = var.public_subnet_1_cidr_block
  public_subnet_2_cidr_block  = var.public_subnet_2_cidr_block
  private_subnet_1_cidr_block = var.private_subnet_1_cidr_block
  private_subnet_2_cidr_block = var.private_subnet_2_cidr_block
  availability_zone_1         = var.availability_zone_1
  availability_zone_2         = var.availability_zone_2

}
resource "aws_s3_bucket" "mini_project_23d" {
  # (resource arguments)
}


module "project_rds" {
  source               = "./modules/RDS"
  vpc_id               = module.project_vpc.vpc_id
  private_subnet_ids   = module.project_vpc.private_subnet_ids
  db_name              = var.db_name
  db_username          = var.db_username
  db_allocated_storage = var.db_allocated_storage
  db_storage_type      = var.db_storage_type
  db_instance_class    = var.db_instance_class
  db_engine_version    = var.db_engine_version
  engine               = var.engine
  skip_final_snapshot  = var.skip_final_snapshot
  backend_sg           = module.project_bastion.sg_to_pass_to_db #"sg-019fc0141fecaeed2"
  back_sg = module.project_asg.backend_asg_sg_id

}


##################
#############BASTION###################
#############BASTION###################
#############BASTION###################
#############BASTION###################

# Calling module instead of creating resources from this file
module "project_bastion" {
  source             = "./modules/Bastion"
  bastion_allowed_ip = var.my_ip
  vpc_id             = module.project_vpc.vpc_id
  bastion_ami        = var.bastion_ami
  key_name           = var.key_name
  subnet_id          = module.project_vpc.public_subnet_ids[0]
  my_ip              = var.my_ip
  instance_type      = var.instance_type

}

#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################
#############^^^^^^^^^BASTION^^^^^^###################



######ASG#####
module "project_asg" {
  source             = "./modules/ASG"
  frontend_ami       = var.frontend_ami
  frontend_tg_arn    = module.alb.alb_frontend_target_group
  backend_tg_arn     = module.alb.alb_backend_target_group
  subnets            = module.project_vpc.public_subnet_ids
  backend_ami        = var.backend_ami
  secrets_permission = var.secrets_permission
  vpc_id             = module.project_vpc.vpc_id
  frontend_asg_name = var.frontend_asg_name
  backend_asg_name = var.backend_asg_name
  alb_sg = module.alb.alb_sg_id
  }

module "alb" {
  source                             = "./modules/ALB"
  alb_name                           = var.alb_name
  vpc_id                             = module.project_vpc.vpc_id
  subnet_ids                         = module.project_vpc.public_subnet_ids
  frontend_target_port               = var.frontend_target_port
  backend_target_port                = var.backend_target_port
  frontend_domain                    = var.frontend_domain
  backend_domain                     = var.backend_domain
  s3_maintenance_page_endpoint       = module.s3.s3_endpoint
  s3_maintenance_page_hosted_zone_id = var.s3_maintenance_page_hosted_zone_id # https://docs.aws.amazon.com/general/latest/gr/s3.html#s3_website_region_endpoints
  route53_zone_id                    = "Z045187128D45LCL6OVRC"
  frontend_autoscaling_group_name = module.project_asg.asg_name_frontend
  backend_autoscaling_group_name = module.project_asg.asg_name_backend
  frontend_dns = var.frontend_dns_address
}
# data "aws_region" "current" {}
# data "aws_route53_zone" "selected" {
#   name         = var.route53_domain_name
#   private_zone = false
# }

/*  S3  */

module "s3" {
  source            = "./modules/S3"
  bucket            = var.bucket
  source_path       = "./modules/S3/webpage/index.html"
  source_image_path = "./modules/S3/webpage/main.jpg"
  # depends_on        = [module.alb]
}

/*  CloudWatch  */

# module "aws_cloudwatch_dashboard" {
#   source          = "./modules/CloudWatch"
#   rds_instance_id = module.rds.rds_instance_id
#   alb_name        = module.alb.alb_name
#   asg_name        = module.project_asg.asg_name
#   emails          = var.emails

# }


# this block calls IAM module and creates roles for accounts specified in ID variable with policies from policies variable
module "role" {
  source = "./modules/IAM"
  allowed_accounts = var.ID
  policy_names = var.policies
  role_name = var.role
  duration_of_a_role = var.time_limit
}