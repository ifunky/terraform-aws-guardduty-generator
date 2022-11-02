

# terraform-aws-guardduty-generator
 [![Wiz](https://img.shields.io/badge/Wiz%20Security-green)](https://www.wiz.io/solutions/iac) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This module is designed to generate a selection of AWS GuardDuty findings for incident reponse testing purposes.  The samples are based on the offical AWS GaurdDuty Tester
repo: https://github.com/awslabs/amazon-guardduty-tester/

## GuardDuty Findings Generated
- Recon:EC2/Portscan (simulate internal recon and attempted lateral movement)
- Trojan:EC2/DNSDataExfiltration
- Backdoor:EC2/C&CActivity.B!DNS
- CryptoCurrency:EC2/BitcoinTool.B!DNS
- UnauthorizedAccess:EC2/RDPBruteForce
- UnauthorizedAccess:EC2/SSHBruteForce

## Prerequisites

### AWS Systems Manager Configuration  
This solutions uses AWS Systems Manager so you will need to configure the relevant accounts as per the AWS documentation: https://docs.aws.amazon.com/systems-manager/latest/userguide/automation-setup.html

### Red Team EC2 Instance
An EC2 istance used for red team activity with the following utilities installed:
- Nmap 
- Crowbar
- SSB



## Usage
```hcl
module "guard_duty_generator" {
    source = "git::https://github.com/ifunky/terraform-aws-guardduty-generator.git?ref=main"

    cron_schedule           = cron(0 2 ? * SUN *)"  # Every 2 days
    dns_instance_id         = module.ec2_linux_vuln_ssh_password.id
    control_instance_id     = module.ec2_linux_vuln_with_admin.id
    bitcoin_instance_id     = module.ec2_linux_vuln_with_admin.id
    portscan_instance_id    = module.ec2_linux_vuln_with_admin.id
    portscan_target_ip      = "11.0.2.45"
    rdp_bruteforce_instance = "52.1.2.3"
    ssh_bruteforce_instance = "52.1.2.3"
    redteam_instance_id     = module.ec2_redteam.id
}  

```
> NOTE: For ease of maintenance the above example uses the `main` branch but we recommend using a version number in your production code


## Makefile Targets
The following targets are available: 

```
createdocs/help                Create documentation help
polydev/createdocs             Run PolyDev createdocs directly from your shell
polydev/help                   Help on using PolyDev locally
polydev/init                   Initialise the project
polydev/validate               Validate the code
polydev/wizscan                Security validation
polydev                        Run PolyDev interactive shell to start developing with all the tools or run AWS CLI commands :-)
wizauth                        WizCli authentication
wizscan                        Scan code
```
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
* `rdp_bruteforce_target_ip` (required): Instance ID to target a portscan generating a `UnauthorizedAccess:EC2/RDPBruteForce` finding
* `redteam_instance_id` (required): Redteam tooling instance ID.
* `ssh_bruteforce_target_ip` (required): Instance ID to target a portscan generating a `UnauthorizedAccess:EC2/SSHBruteForce` finding
* `tags` (default `{}`): Additional tags (e.g. map('BusinessUnit`,`XYZ`)

## Managed Resources
* `aws_ssm_association.guardduty_bitcoin_mining_finding` from `aws`
* `aws_ssm_association.guardduty_brutforce_rdp_finding` from `aws`
* `aws_ssm_association.guardduty_brutforce_ssh_finding` from `aws`
* `aws_ssm_association.guardduty_command_and_control_finding` from `aws`
* `aws_ssm_association.guardduty_dns_exfiltration_finding` from `aws`
* `aws_ssm_association.guardduty_internal_recon_finding` from `aws`
* `aws_ssm_document.guardduty_bitcoin_mining_finding` from `aws`
* `aws_ssm_document.guardduty_brutforce_rdp_finding` from `aws`
* `aws_ssm_document.guardduty_brutforce_ssh_finding` from `aws`
* `aws_ssm_document.guardduty_command_and_control_finding` from `aws`
* `aws_ssm_document.guardduty_dns_exfiltration_finding` from `aws`
* `aws_ssm_document.guardduty_internal_recon_finding` from `aws`




## Related Projects

Here are some useful related projects.

- [PolyDev](https://github.com/ifunky/polydev) - PolyDev repo and setup guide





## References

For more information please see the following links of interest: 

- [GuardDuty Tester](https://github.com/awslabs/amazon-guardduty-tester/) - AWS GuardDuty Tester Repo

