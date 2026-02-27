output "vpc_id" {
  value = data.aws_vpc.this.id
}

output "private_subnets" {
  value = data.aws_subnets.this.ids
}

output "public_subnet_ids" {
  value = data.aws_subnets.this.ids
}