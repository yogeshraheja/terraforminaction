variable "master_instance_type" {
        default = "t2.medium"
}

variable "master_instance_count" {
        default = 2
}

variable "node_instance_type" {
        default = "t2.micro"
}

variable "node_instance_count" {
        default = 3
}

variable "name" {
        default = "k8s-cluster-test"
}
variable "ami_name" {
        default = "ami-030ff268bd7b4e8b5"
}
variable "instance_key" {
        default = "thinknyxconf"
}

