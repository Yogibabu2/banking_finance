 resource "aws_instance" "production-server" {
 ami = "ami-0f5ee92e2d63afc18"
 instance_type = "t2.micro"
 key_name = "mynewpair"
 availability_zone = "ap-south-1a"
 VPC_security_groups = ["sg-0d7dbd42022748447"]
 connection {
type  = "ssh"
user = "ubuntu"
private_key =file("./mynewpair.pem")
host     =self.public_ip
}
provisioner "remote-exec" {
inline = [
     "echo 'wait to start instance'"]
}
 tags = {
 name = "test-server"
 }
 provisioner "remote-exec" {
 command = " echo ${aws_instance,test-server,public_ip} > inventory "
}
provisioner "remote-exec" {
     "ansible-playbook deploy.yml"
     }
     }
