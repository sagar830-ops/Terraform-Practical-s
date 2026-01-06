resource "aws_instance" "name" {
  
  ami = "ami-068c0051b15cdb816"
  instance_type = "t3.small" 
  tags = {
    Name ="prod"
  }
  
}

resource "aws_s3_bucket" "s3B" {
  
  bucket = "s3-bucket-sp-gvfhgffgd"
   
   
  
}