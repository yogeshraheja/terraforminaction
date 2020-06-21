resource "aws_instance" "k8s-master" {
        ami             =       "ami-030ff268bd7b4e8b5"
        availability_zone = "us-east-1c"
        instance_type   =       var.master_instance_type
        key_name                =       "thinknyxconf"
        count = var.master_instance_count

        tags = {
                Name            =       "k8s-master"
                company         =       "Ericsson"
                type            =       "masternode"
        }

}
resource "aws_eip" "eip_master" {
        instance   = "${element(aws_instance.k8s-master.*.id,count.index)}"
        count = "${var.master_instance_count}"
        vpc = true
        depends_on = [aws_instance.k8s-master]
        provisioner "local-exec" {
              command = "echo ${self.public_ip} >> ${path.module}/master_ips.txt"
        }
}

