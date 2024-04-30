resource "aws_db_instance" "RDS_instance" {

  #vpc_security_group_ids = [aws_security_group.RDS_sec.id]
  identifier          = "dhangodb"
  allocated_storage   = 20
  engine              = "mysql"
  db_name               = "dhangodb"
  instance_class      = "db.t3.micro"
  publicly_accessible = true
  skip_final_snapshot = true
  username            = "mo"
  password            = "M12345mmm"

}

output "rds_dns_endpoint" {
  value = aws_db_instance.RDS_instance.endpoint
  
}
 resource "local_file" "rds_url" {
   filename = "rds_url"
   content = aws_db_instance.RDS_instance.endpoint
 }