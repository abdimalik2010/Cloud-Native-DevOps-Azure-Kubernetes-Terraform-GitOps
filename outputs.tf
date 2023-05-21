output "master-node-ip" {
  value = module.public_ip.static-ips[0].ip_address

}

output "worker-node-ip" {
  value = module.public_ip.static-ips[1].ip_address
}