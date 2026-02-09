####### variable region

variable "aws_region" {
type = string
}
######### variable ami_id

variable "ami_id" {
    type = string
}

########## variable instance_id
variable "instance_id" {
 type = string
}

######## variable key name
variable "key_name" {
type = string
}

###### variable instance count

variable "instance_count" {
    type= string"
}

##### variable "vpc_cidr" {
    type = string
    default ="10.0.0.0/16"
}

