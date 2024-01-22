resource "null_resource" "configure-EC2-Machine" {
  # connection block for provisioners to connect to EC2
  connection {
    type        = "ssh"
    host        = aws_eip.bastion-eip.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("private-key/terraform-key.pem")
  }

  provisioner "file" {
		source      = "private-key/terraform-key.pem"
		destination = "/tmp/terraform-key.pem"
	}

	provisioner "remote-exec" {
		inline = [ 
			"sudo chmod 400 /tmp/terraform-key.pem"
		]
	}

	provisioner "local-exec" {
		command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-ec2.txt"
		working_dir = "local-exec-out-files/"
		on_failure  = continue
		#destroy time provisioners
		# when        = destroy 
	}

}

