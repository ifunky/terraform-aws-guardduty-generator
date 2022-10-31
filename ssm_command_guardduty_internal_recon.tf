resource "aws_ssm_document" "guardduty_internal_recon_finding" {
  name            = "GuardDuty-Generator-Internal-Recon"
  document_format = "YAML"
  document_type   = "Command"

  content = <<DOC
schemaVersion: "2.2"
description: "Generate a GuardDuty Recon:EC2/Portscan finding"
parameters:
  TargetIP:
    type: "String"
    description: "Target IP for port scan"
mainSteps:
- action: aws:runShellScript
  name: runScript
  inputs:
    timeoutSeconds: '120'
    runCommand:
    - "yum install nmap -y"
    - "nmap -sT {{TargetIP}}"
DOC
}

resource "aws_ssm_association" "guardduty_internal_recon_finding" {
  name = aws_ssm_document.guardduty_dns_exfiltration_finding.name

  schedule_expression = var.cron_schedule

  parameters = {
    TargetIP = var.portscan_target_ip
  }

  targets {
    key    = "InstanceIds"
    values = [var.bitcoin_instance_id]
  }

}