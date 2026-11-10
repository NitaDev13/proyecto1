#!/bin/bash
# Proyecto 1 · Despliegue del servidor web de Librería Tinta
set -euo pipefail
export AWS_PAGER=""           # evita que la salida se abra en un visor y detenga el script

REGION="us-east-1"
SUBNET_ID="subnet-0cce9425a237183c8"   # TODO: ID de tu subred libreria-publica
VPC_ID="vpc-0398356d9208023ac"         # TODO: ID de tu VPC libreria-vpc
MI_IP="86.127.225.132/32"              # TODO: tu IP pública (consúltala en https://checkip.amazonaws.com)
ALUMNO="Tania Algarra"                 # TODO

# 1. AMI más reciente de Amazon Linux 2023
AMI_ID=$(aws ssm get-parameters --region "$REGION" \
  --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 \
  --query "Parameters[0].Value" --output text)

# 2. Grupo de seguridad
SG_ID=$(aws ec2 create-security-group --region "$REGION" \
  --group-name libreria-web-cli-sg \
  --description "Web Libreria Tinta (CLI)" \
  --vpc-id "$VPC_ID" \
  --query "GroupId" --output text)

# TODO: permitir HTTP (80) desde cualquier origen
aws ec2 authorize-security-group-ingress --region "$REGION" \
  --group-id "$SG_ID" --protocol tcp --port 80 --cidr 0.0.0.0/0

# TODO: permitir SSH (22) solo desde MI_IP
aws ec2 authorize-security-group-ingress --region "$REGION" \
  --group-id "$SG_ID" --protocol tcp --port 22 --cidr "$MI_IP"

# 3. Instancia
INSTANCE_ID=$(aws ec2 run-instances --region "$REGION" \
  --image-id "$AMI_ID" \
  --instance-type t3.micro \
  --key-name vockey \
  --subnet-id "$SUBNET_ID" \
  --security-group-ids "$SG_ID" \
  --user-data file://user-data1.sh \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=libreria-web-cli},{Key=Proyecto,Value=P1},{Key=Alumno,Value=$ALUMNO}]" \
  --query "Instances[0].InstanceId" --output text)

echo "Instancia creada: $INSTANCE_ID"

# TODO: esperar a que la instancia esté en estado running
aws ec2 wait instance-running --region "$REGION" --instance-ids "$INSTANCE_ID"

# TODO: obtener su IP pública y guardarla en la variable IP
IP=$(aws ec2 describe-instances --region "$REGION" --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Abre en el navegador: http://$IP"