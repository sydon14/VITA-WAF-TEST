provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vita-waf-test-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vita-waf-test-igw"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "vita-waf-test-subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "vita-waf-test-subnet-b"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "vita-waf-test-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "allow_http" {
  name        = "vita-waf-test-allow-http"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "vita-waf-test-sg"
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-00a929b66ed6e0de6" # Amazon Linux 2
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_a.id
  security_groups             = [aws_security_group.allow_http.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install -y httpd
              echo "WAF Demo Page" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = "vita-waf-test-ec2"
  }
}

resource "aws_lb" "alb" {
  name               = "dmv-waf-test-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  security_groups    = [aws_security_group.allow_http.id]

  tags = {
    Name = "dmv-waf-test-alb"
  }
}

resource "aws_lb_target_group" "target" {
  name     = "dmv-waf-test-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "dmv-waf-test-tg"
  }
}

resource "aws_lb_target_group_attachment" "ec2" {
  target_group_arn = aws_lb_target_group.target.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target.arn
  }
}


# ========== DOT ALB Setup ==========

resource "aws_lb" "dot_alb" {
  name               = "dot-waf-test-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  security_groups    = [aws_security_group.allow_http.id]

  tags = {
    Name = "dot-waf-test-alb"
  }
}

resource "aws_lb_target_group" "dot_target" {
  name     = "dot-waf-test-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "dot-waf-test-tg"
  }
}

resource "aws_lb_target_group_attachment" "dot_ec2" {
  target_group_arn = aws_lb_target_group.dot_target.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_listener" "dot_listener" {
  load_balancer_arn = aws_lb.dot_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dot_target.arn
  }
}



# ========== TAX ALB Setup ==========

resource "aws_lb" "tax_alb" {
  name               = "tax-waf-test-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  security_groups    = [aws_security_group.allow_http.id]

  tags = {
    Name = "tax-waf-test-alb"
  }
}

resource "aws_lb_target_group" "tax_target" {
  name     = "tax-waf-test-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "tax-waf-test-tg"
  }
}

resource "aws_lb_target_group_attachment" "tax_ec2" {
  target_group_arn = aws_lb_target_group.tax_target.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_listener" "tax_listener" {
  load_balancer_arn = aws_lb.tax_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tax_target.arn
  }
}
