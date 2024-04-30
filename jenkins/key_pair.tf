resource "aws_key_pair" "myK" {
    key_name   = "deployer-key"
    public_key = var.public_key
}

