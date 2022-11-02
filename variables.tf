variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "cron_schedule" {
    type        = string
    description = "Cron expression when to run the GuardDuty generator.  Defaults to running every 2 days 7 days a week."
    default     = "cron(0 2 ? * SUN *)"
}

variable "ssh_bruteforce_target_ip" {
    type        = string
    description = "Instance ID to target a portscan generating a `UnauthorizedAccess:EC2/SSHBruteForce` finding"
}

variable "rdp_bruteforce_target_ip" {
    type        = string
    description = "Instance ID to target a portscan generating a `UnauthorizedAccess:EC2/RDPBruteForce` finding"
}

variable "dns_instance_id" {
    type        = string
    description = "Instance ID to generate `EC2/DNSDataExfiltration` findings"
}

variable "control_instance_id" {
    type        = string
    description = "Instance ID to generate `EC2/C&CActivity.B!DNS` findings"
}

variable "bitcoin_instance_id" {
    type        = string
    description = "Instance ID to generate `CryptoCurrency:EC2/BitcoinTool.B!DNS` findings"
}

variable "portscan_instance_id" {
    type        = string
    description = "Instance ID to generate `Recon:EC2/Portscan` findings"
}

variable "portscan_target_ip" {
    type        = string
    description = "Instance ID to target a portscan generating a `Recon:EC2/Portscan` finding"
}

variable "redteam_instance_id" {
    type        = string
    description = "Redteam tooling instance ID."
}
