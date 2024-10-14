output "public_instance_id" {
  value = aws_instance.public.id
}
output "private_instance_id" {
  value = aws_instance.private.id
}
output "instance_public_ip" {
  value = aws_instance.public.public_ip
}
output "instance_private_ip" {
  value = aws_instance.private.private_ip
}
