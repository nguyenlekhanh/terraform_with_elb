data "aws_ami" "server_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.server_ami.id
  instance_type = "t2.micro"

  tags = merge(
    local.common_tags,
    tomap({"Name" = "${local.prefix}-bastion"})
  )
}