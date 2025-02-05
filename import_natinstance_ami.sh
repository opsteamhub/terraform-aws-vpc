#!/bin/bash

# Configuração
SOURCE_REGION="eu-west-1"  # Região de origem da AMI

# Obtém a AMI mais recente na região de origem
LATEST_AMI_ID=$(aws ec2 describe-images \
  --region $SOURCE_REGION \
  --owners amazon \
  --filters "Name=name,Values=amzn-ami-vpc-nat*" \
  --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
  --output text)

echo "AMI mais recente de NatInstance na Irlanda encontrada. ID na Irlanda: $LATEST_AMI_ID"

# Verifica se já existe uma AMI copiada na região local
EXISTING_AMI_ID=$(aws ec2 describe-images \
  --owners self \
  --filters "Name=name,Values=Copy of $LATEST_AMI_ID" \
  --query 'Images[?State==`available`].ImageId' \
  --output text)

if [[ -n "$EXISTING_AMI_ID" ]]; then
  echo "AMI já está disponível na região local."
  echo "ID da AMI anterior na conta local: $EXISTING_AMI_ID"
  echo "Atualize o vpc_config[\"ami_id\"] com: $EXISTING_AMI_ID"
  exit 0
fi

# Inicia a cópia da AMI para a região padrão
COPY_AMI_ID=$(aws ec2 copy-image \
  --source-region $SOURCE_REGION \
  --source-image-id $LATEST_AMI_ID \
  --name "Copy of $LATEST_AMI_ID" \
  --query 'ImageId' \
  --output text)

echo "Requisição para copiar a AMI ($LATEST_AMI_ID) foi feita."
echo "ID da nova AMI copiada: $COPY_AMI_ID"
echo "Atualize o vpc_config[\"ami_id\"] com: $COPY_AMI_ID"
echo "O processo de clonagem pode levar alguns minutos para que a imagem fique disponível."
echo "Acompanhe no console da AWS ou verifique o status no terminal com:"
echo "aws ec2 describe-images --image-ids $COPY_AMI_ID --query 'Images[0].State' --output text"
