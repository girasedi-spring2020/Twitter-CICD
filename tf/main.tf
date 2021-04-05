provider "aws" {
	region = "us-east-1"
	shared_credentials_file = "~/.aws/credentials"
	profile                 = "divya"
}


module "app_ecs_cluster" {
  source = "infrablocks/ecs-cluster/aws"
  version = "3.4.0"
  region = "us-east-1"
  vpc_id           = "${var.vpc_id}"
  subnet_ids       = ["${var.subnet-a}","${var.subnet-b}"]
  		
  cluster_name        = "flask-react-cluster"
  cluster_instance_ssh_public_key_path = "${var.ssh-key-path}"
  cluster_instance_type = "t2.small"
  component = "my"
  deployment_identifier = "cluster"
  cluster_minimum_size = 2
  cluster_maximum_size = 2
  cluster_desired_capacity = 2

  security_groups = ["${var.cluster-security-group}"]
  include_default_ingress_rule = "no"
  include_default_egress_rule = "no"
}

resource "aws_ecs_service" "fe" {
	name            = "flask-react-fe-service"
	cluster         =  module.app_ecs_cluster.cluster_arn
	iam_role 		= "${var.iam_role}"
	task_definition = "${var.fe-task-definition}"
	desired_count   = 1
	ordered_placement_strategy {
    	type  = "spread"
    	field = "instanceId"
  }
	  load_balancer {
	    target_group_arn = "${var.fe-target-group}"
	    container_name   = "fe"
	    container_port   = 80
	  }
}

resource "aws_ecs_service" "be" {
	name            = "flask-react-be-service"
	cluster         = module.app_ecs_cluster.cluster_arn
	iam_role 		= "${var.iam_role}"
	task_definition = "${var.be-task-definition}"
	desired_count   = 1
	ordered_placement_strategy {
    	type  = "spread"
    	field = "instanceId"
  }
	  load_balancer {
	    target_group_arn = "${var.be-target-group}"
	    container_name   = "be"
	    container_port   = 5000
	  }
}

output "instance_ip_addr" {
  value = module.app_ecs_cluster.cluster_arn
}