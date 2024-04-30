resource "aws_ecr_repository" "ECR" {
  name                 = "ecr-repo"
 
  tags = {
    name= "Docker_repo"
  }
 } 

 resource "local_file" "ecr_url" {
   filename = "ecr_url"
   content = aws_ecr_repository.ECR.repository_url
 }