resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux_latest.id
  
  instance_type = "t2.micro"

  tags = merge(
    local.common_tags,
    {
      Name = "ec2-${var.env}-${var.name}"
    }
  )

  subnet_id = var.subnet_id
}

data "aws_ami" "amazon_linux_latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}