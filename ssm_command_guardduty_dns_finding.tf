resource "aws_ssm_document" "guardduty_dns_exfiltration_finding" {
  name            = "GuardDuty-Generator-DNSDataExfiltration"
  document_format = "YAML"
  document_type   = "Command"

  content = <<DOC
schemaVersion: "2.2"
description: "Generate a GuardDuty DNSDataExfiltration finding"
parameters:
mainSteps:
- action: aws:runShellScript
  name: DNSDataExfiltration
  inputs:
    timeoutSeconds: '120'
    runCommand:
    - "curl -Lo /tmp/queries.txt https://raw.githubusercontent.com/awslabs/amazon-guardduty-tester/master/artifacts/queries.txt"
    - "dig -f /tmp/queries.txt > /dev/null"
DOC
}

resource "aws_ssm_association" "guardduty_dns_exfiltration_finding" {
  name = aws_ssm_document.guardduty_dns_exfiltration_finding.name

  schedule_expression = var.cron_schedule

  targets {
    key    = "InstanceIds"
    values = [var.dns_instance_id]
  }
}