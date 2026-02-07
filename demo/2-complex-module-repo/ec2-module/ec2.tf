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

resource "aws_cloudwatch_metric_alarm" "disk_usage_high" {
  alarm_name          = "alarm-${var.env}-${var.name}-ec2-disk-90-full"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "Alarm when disk usage is 90% or higher"
  dimensions = {
    InstanceId = aws_instance.this.id
    path       = "/"
    fstype     = "ext4"
  }
  actions_enabled     = true
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