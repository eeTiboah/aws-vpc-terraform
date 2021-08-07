

output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image.id
}

output "aws_sg_id" {
  value = aws_security_group.app-sg.id
}