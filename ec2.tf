# Find the current Ubuntu Server 24.04 LTS AMI
data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

# Linux server 1 - External subnet
resource "aws_instance" "linux_ext01" {
  ami                         = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type               = "c7i.large"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.external.id
  vpc_security_group_ids      = [aws_security_group.external_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "Linux-EXT01"
    Role = "External Linux Server"
  }
}

# Linux server 2 - External subnet
resource "aws_instance" "linux_ext02" {
  ami                         = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type               = "c7i.large"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.external.id
  vpc_security_group_ids      = [aws_security_group.external_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "Linux-EXT02"
    Role = "External Linux Server"
  }
}

# Linux server 3 - Internal subnet
resource "aws_instance" "linux_int01" {
  ami                    = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type          = "c7i.large"
  key_name               = var.key_name
  subnet_id              = aws_subnet.internal.id
  vpc_security_group_ids = [aws_security_group.internal_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "Linux-INT01"
    Role = "Internal Linux Server"
  }
}

# Linux server 4 - Internal subnet
resource "aws_instance" "linux_int02" {
  ami                    = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type          = "c7i.large"
  key_name               = var.key_name
  subnet_id              = aws_subnet.internal.id
  vpc_security_group_ids = [aws_security_group.internal_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "Linux-INT02"
    Role = "Internal Linux Server"
  }
}

# Find the current Windows Server 2022 English Full Base AMI
data "aws_ssm_parameter" "windows_2022_ami" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
}

# Four Windows servers for the school environment
resource "aws_instance" "windows" {
  for_each = toset([
    "Windows-DC01",
    "Windows-DC02",
    "Windows-CA01",
    "Windows-NPS01"
  ])

  ami                         = data.aws_ssm_parameter.windows_2022_ami.value
  instance_type               = "c7i.xlarge"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.internal.id
  vpc_security_group_ids      = [aws_security_group.internal_sg.id]
  associate_public_ip_address = false

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = each.key
    Role = "Internal Windows Server"
  }
}
