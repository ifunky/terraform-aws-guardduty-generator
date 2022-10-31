resource "aws_ssm_document" "guardduty_bitcoin_mining_finding" {
  name            = "GuardDuty-Generator-Bitcoin-Mining"
  document_format = "YAML"
  document_type   = "Command"

  content = <<DOC
schemaVersion: "2.2"
description: "Generate a GuardDuty CryptoCurrency:EC2/BitcoinTool.B!DNS finding"
parameters:
mainSteps:
- action: aws:runShellScript
  name: runScript
  inputs:
    timeoutSeconds: '120'
    runCommand:
    - "curl -s http://pool.minergate.com/dkjdjkjdlsajdkljalsskajdksakjdksajkllalkdjsalkjdsalkjdlkasj  > /dev/null"
    - "curl -s http://xmr.pool.minergate.com/dhdhjkhdjkhdjkhajkhdjskahhjkhjkahdsjkakjasdhkjahdjk  > /dev/null"
DOC
}

resource "aws_ssm_association" "guardduty_bitcoin_mining_finding" {
  name = aws_ssm_document.guardduty_dns_exfiltration_finding.name

  schedule_expression = var.cron_schedule

  targets {
    key    = "InstanceIds"
    values = [var.bitcoin_instance_id]
  }
}