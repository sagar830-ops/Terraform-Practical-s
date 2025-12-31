output "public_ip" {
  
value = aws_instance.name.public_ip

}

output "privat_i" {
  
  value = aws_instance.name.availability_zone
  
}