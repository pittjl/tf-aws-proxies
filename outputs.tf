output "public_ip_list" {
  description = "IPs of spawned hosts"
 // value       = "ssh -i ${module.ssh-key.key_name}.pem ec2-user@${module.ec2.public_ip[*]}"
 value = module.ec2.public_ip[*]
 
}
