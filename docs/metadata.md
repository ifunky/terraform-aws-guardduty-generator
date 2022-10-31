# Module Specifics

Core Version Constraints:
* `>= 1.0`

Provider Requirements:
* **aws (`hashicorp/aws`):** `~> 4.0`

## Input Variables
* `bitcoin_instance_id` (required): Instance ID to generate `CryptoCurrency:EC2/BitcoinTool.B!DNS` findings
* `control_instance_id` (required): Instance ID to generate `EC2/C&CActivity.B!DNS` findings
* `cron_schedule` (default `"cron(0 2 ? * SUN *)"`): Cron expression when to run the GuardDuty generator.  Defaults to running every 2 days 7 days a week.
* `dns_instance_id` (required): Instance ID to generate `EC2/DNSDataExfiltration` findings
* `portscan_instance_id` (required): Instance ID to generate `Recon:EC2/Portscan` findings
* `portscan_target_ip` (required): Instance ID to target a portscan generating a `Recon:EC2/Portscan` finding
* `tags` (default `{}`): Additional tags (e.g. map('BusinessUnit`,`XYZ`)

## Managed Resources
* `aws_ssm_association.guardduty_bitcoin_mining_finding` from `aws`
* `aws_ssm_association.guardduty_command_and_control_finding` from `aws`
* `aws_ssm_association.guardduty_dns_exfiltration_finding` from `aws`
* `aws_ssm_association.guardduty_internal_recon_finding` from `aws`
* `aws_ssm_document.guardduty_bitcoin_mining_finding` from `aws`
* `aws_ssm_document.guardduty_command_and_control_finding` from `aws`
* `aws_ssm_document.guardduty_dns_exfiltration_finding` from `aws`
* `aws_ssm_document.guardduty_internal_recon_finding` from `aws`

