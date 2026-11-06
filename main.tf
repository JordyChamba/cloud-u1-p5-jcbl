# Configuración del proveedor AWS
provider "aws" {
  region = "us-east-1"
}

# Creamos el Security Group
resource "aws_security_group" "mi_security_group" {
  name        = "mi-security-group-terraform"
  description = "SG instancia terraform"
  vpc_id      = "vpc-0b4e3ec247ede4cc9"

  # Entrada: SSH (puerto 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Entrada adicional (opcional si vas a levantar un servidor web):
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Salida: Permitir todo el tráfico saliente (DNS, repositorios, HTTPS)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Declaración de la instancia EC2
resource "aws_instance" "mi_instancia" {
  ami           = "ami-081ed2c497357665b"
  instance_type = "t2.micro"
  key_name      = "mi-primera-llaves-jc"

  tags = {
    Name = "MiInstanciaTerraform"
  }

  vpc_security_group_ids = [aws_security_group.mi_security_group.id]
}