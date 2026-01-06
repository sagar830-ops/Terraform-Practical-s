#create VPC
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-TF"
  }

}

#Created Subnet
resource "aws_subnet" "name" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subetTF"
  }
}
resource "aws_subnet" "name1" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.8.0/22"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subetTF"
  }

}

#created IG
resource "aws_internet_gateway" "IG" {
  
  vpc_id = aws_vpc.name.id
}

#resource "aws_internet_gateway_attachment" "name" {
 # internet_gateway_id = aws_internet_gateway.IG.id

# vpc_id = aws_vpc.name.id

#}

resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }

}

resource "aws_route_table_association" "name" {
  
  subnet_id = aws_subnet.name.id
  route_table_id = aws_route_table.name.id

}

resource "aws_security_group" "dev_sg" {
  name        = "allow_tls"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.name.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-sg"
  }
}

resource "aws_instance" "name" {
   ami = "ami-068c0051b15cdb816"
  instance_type = "t3.small" 
  subnet_id = aws_subnet.name.id
  vpc_security_group_ids = [aws_security_group.dev_sg.id]

  tags = {
     Name = "prod"
  }
}