# Creating CENTOS Server
resource "aws_instance" "k8s-worker" {
        ami             =       "ami-030ff268bd7b4e8b5"
        instance_type   =       var.node_instance_type
        count                   =       var.node_instance_count
        key_name                =       "thinknyxconf"
        depends_on      = [aws_eip.eip_master]

        tags = {
                Name            =       "k8s-worker"
                company         =       "Ericsson"
                type            =       "workernode"
        }

}
resource "aws_eip" "eip_worker" {
        instance   = "${element(aws_instance.k8s-worker.*.id,count.index)}"
        count = "${var.node_instance_count}"
        vpc = true
        depends_on = [aws_instance.k8s-worker]
        provisioner "local-exec" {
              command = "echo ${self.public_ip} >> ${path.module}/worker_ips.txt"
        }

}

