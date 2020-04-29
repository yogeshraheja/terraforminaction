provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  ami = "${var.ami}"
  availability_zone = "us-east-1a"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "DevOpsInActionTesttwo"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "${var.user}"
      password    = "${var.password}"
#      host        = "${aws_instance.myserver.public_ip}"
      host        = "${self.public_ip}"
    }

    inline = [
      "sudo yum -y install httpd",
      "sudo echo '<h1>Hello and welcome to DevOps in Action Conference</h1>' > /var/www/html/index.html",
      "sudo systemctl start httpd"
    ]
  }
}

resource "aws_ebs_volume" "devopsinactionebs" {
  availability_zone = "us-east-1a"
  size              = 10

  tags = {
    Name = "myserverebs"
  }
}

resource "aws_volume_attachment" "myserverebsattch" {
  device_name = "/dev/sdf"
  volume_id = "${aws_ebs_volume.myserverebs.id}"
  instance_id = "${aws_instance.myserver.id}"
}

output "myserverdetails" {
  value = "${aws_instance.myserver.public_ip} and ${aws_ebs_volume.myserverebs.id}"
}
