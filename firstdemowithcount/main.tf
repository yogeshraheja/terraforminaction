provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myawsserver" {
  ami = "ami-030ff268bd7b4e8b5"
  instance_type = "t2.micro"
  count = "1"

  tags = {
    Name = "DevOpsInAction"
    company = "Ericsson"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ${path.module}/server_ips.txt"
    }
}
