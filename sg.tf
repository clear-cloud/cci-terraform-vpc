resource "aws_security_group" "ssh_from_cci" {
  name        = "ssh_from_cci"
  description = "Allow inbound SSH from CCI IP ranges"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = split(",", var.cci_cidr_blocks)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "${var.environment}.sg.ssh_from_cci"
    Environment   = var.environment
    Description   = "sg.ssh_from_cci"
    Contact       = var.vpc_contact
    Orchestration = var.global_orchestration
  }
}

