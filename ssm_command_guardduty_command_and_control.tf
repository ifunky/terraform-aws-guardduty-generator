resource "aws_ssm_document" "guardduty_command_and_control_finding" {
  name            = "GuardDuty-Generator-CommandAndControl"
  document_format = "YAML"
  document_type   = "Command"

  content = <<DOC
schemaVersion: "2.2"
description: "Generate a GuardDuty EC2/C&CActivity.B!DNS finding"
parameters:
mainSteps:
- action: aws:runShellScript
  name: runScript
  inputs:
    timeoutSeconds: '120'
    runCommand:
    - "dig GuardDutyC2ActivityB.com any"
DOC
}

resource "aws_ssm_association" "guardduty_command_and_control_finding" {
  name = aws_ssm_document.guardduty_dns_exfiltration_finding.name

  schedule_expression = var.cron_schedule

  targets {
    key    = "InstanceIds"
    values = [var.control_instance_id]
  }
}