# ==========================================
# EXTERNAL SECURITY GROUP
# ==========================================

resource "aws_security_group" "external_sg" {
  name        = "SG-External"
  description = "Security group for external Linux servers"
  vpc_id      = aws_vpc.school_vpc.id

  tags = {
    Name = "SG-External"
  }
}

# Allow SSH only from your administrative IP
resource "aws_vpc_security_group_ingress_rule" "external_ssh" {
  security_group_id = aws_security_group.external_sg.id

  cidr_ipv4   = var.admin_cidr
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  description = "Administrative SSH access"
}

# Allow outbound traffic
resource "aws_vpc_security_group_egress_rule" "external_egress" {
  security_group_id = aws_security_group.external_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


# ==========================================
# INTERNAL SECURITY GROUP
# ==========================================

resource "aws_security_group" "internal_sg" {
  name        = "SG-Internal"
  description = "Security group for internal Windows and Linux servers"
  vpc_id      = aws_vpc.school_vpc.id

  tags = {
    Name = "SG-Internal"
  }
}

# Allow internal systems to communicate
resource "aws_vpc_security_group_ingress_rule" "internal_traffic" {
  security_group_id = aws_security_group.internal_sg.id

  referenced_security_group_id = aws_security_group.internal_sg.id
  ip_protocol                  = "-1"

  description = "Internal server communication"
}

# Allow outbound traffic
resource "aws_vpc_security_group_egress_rule" "internal_egress" {
  security_group_id = aws_security_group.internal_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}