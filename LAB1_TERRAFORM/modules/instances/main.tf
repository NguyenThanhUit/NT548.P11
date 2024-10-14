resource "aws_instance" "public" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.public_sg_id]
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  tags                        = { Name = "Public Instance" }
}

resource "aws_instance" "private" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.private_sg_id]
  subnet_id              = var.private_subnet_id
  tags                   = { Name = "Private Instance" }
}