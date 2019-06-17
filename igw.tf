#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name          = "${var.environment}.igw"
    Environment   = var.environment
    Description   = "igw"
    Contact       = var.vpc_contact
    Orchestration = var.global_orchestration
  }
}

