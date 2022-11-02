resource "aws_ssm_document" "guardduty_brutforce_ssh_finding" {
  name            = "GuardDuty-Generator-BruteForce-SSH"
  document_format = "YAML"
  document_type   = "Command"

  content = <<DOC
schemaVersion: "2.2"
description: "Generate a GuardDuty UnauthorizedAccess:EC2/SSHBruteForce finding"
parameters:
  TargetIP:
    type: String
    description: "(Required) Target instance IP"
mainSteps:
- action: aws:runShellScript
  name: runScript
  inputs:
    timeoutSeconds: '120'
    runCommand:
    - "ssb -p 22 -c 200 -w /opt/tools/lists/password_list.txt -v {{TargetIP}}"
DOC
}

resource "aws_ssm_association" "guardduty_brutforce_ssh_finding" {
  name = aws_ssm_document.guardduty_brutforce_ssh_finding.name

  schedule_expression = var.cron_schedule

  parameters = {
    TargetIP = var.ssh_bruteforce_target_ip
  }

  targets {
    key    = "InstanceIds"
    values = [var.redteam_instance_id]
  }

}
