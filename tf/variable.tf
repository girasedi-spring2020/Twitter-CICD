variable "vpc_id" {
  description = "Value of the VPC"
  type        = string
  default     = "vpc-cd09f2b0"
}

variable "subnet-a" {
  description = "Value of the first subnet"
  type        = string
  default     = "subnet-c3982de2"
}

variable "subnet-b" {
  description = "Value of the second subnet"
  type        = string
  default     = "subnet-03e09f4e"
}

variable "ssh-key-path" {
  description = "Value of the ssh key for cluster instances"
  type        = string
  default     = "/Users/divyavijendragirase/Documents/keypair/aws_ecs.pub"
}

variable "cluster-security-group" {
  description = "Value of the security group"
  type        = string
  default     = "sg-0097b7ed4bf2411b1"
}

variable "iam_role" {
  description = "IAM role arn for cluster to access load balancer/target groups"
  type        = string
  default     = "arn:aws:iam::880254308112:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
}

variable "fe-task-definition" {
  description = "Task definition arn for react service"
  type        = string
  default     = "arn:aws:ecs:us-east-1:880254308112:task-definition/flask-react-fe-td:1"
}

variable "be-task-definition" {
  description = "Task definition arn for python service"
  type        = string
  default     = "arn:aws:ecs:us-east-1:880254308112:task-definition/flask-react-be-td:1"
}

variable "fe-target-group" {
  description = "Target group arn for frontend"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:880254308112:targetgroup/flask-react-fe-tg/f17f8e1f035f29b4"
}

variable "be-target-group" {
  description = "Target group arn for backend"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:880254308112:targetgroup/flask-react-be-tg/e5af0bdb3557865d"
}
