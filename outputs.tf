output "vpc_id" {
  description = "School VPC ID"
  value       = aws_vpc.school_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.school_vpc.cidr_block
}

output "external_subnet_id" {
  value = aws_subnet.external.id
}

output "internal_subnet_id" {
  value = aws_subnet.internal.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.school_igw.id
}

output "availability_zone" {
  value = aws_subnet.external.availability_zone
}
output "external_security_group_id" {
  value = aws_security_group.external_sg.id
}

output "internal_security_group_id" {
  value = aws_security_group.internal_sg.id
}
