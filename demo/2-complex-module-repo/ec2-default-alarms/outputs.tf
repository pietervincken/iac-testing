output "ids" {
    description = "List of CloudWatch alarm IDs for CPU and RAM high alarms"
    value = [
        aws_cloudwatch_metric_alarm.cpu_high.id, 
        aws_cloudwatch_metric_alarm.ram_high.id
    ]
}