resource "aws_cloudwatch_metric_alarm" "cpu_high" {
    alarm_name          = "EC2-CPU-High"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = 5
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 60
    statistic           = "Average"
    threshold           = 95
    alarm_description   = "Alarm when CPU exceeds 95% for 5 minutes"
    dimensions = {
        InstanceId = var.instance_id
    }
}

resource "aws_cloudwatch_metric_alarm" "ram_high" {
    alarm_name          = "EC2-RAM-High"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = 1
    metric_name         = "mem_used_percent"
    namespace           = "CWAgent"
    period              = 60
    statistic           = "Average"
    threshold           = 90
    alarm_description   = "Alarm when RAM usage exceeds 90% for 1 minute"
    dimensions = {
        InstanceId = var.instance_id
    }
}