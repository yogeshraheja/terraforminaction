provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myawsserver" {
  ami = "ami-030ff268bd7b4e8b5"
  instance_type = "t2.micro"

  tags = {
    Name = "DevOpsInActionTestOne"
  }
}

output "myawsserver" {
  value = aws_instance.myawsserver.public_ip
}
