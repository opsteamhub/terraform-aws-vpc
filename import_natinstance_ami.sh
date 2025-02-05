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

echo "AMI mais recente encontrada: $LATEST_AMI_ID"

# Verifica se a AMI já foi copiada para a região padrão
EXISTING_AMI_ID=$(aws ec2 describe-images \
  --owners self \
  --filters "Name=name,Values=Copy of $LATEST_AMI_ID" \
  --query 'Images[?State==`available`].ImageId' \
  --output text)

if [[ -n "$EXISTING_AMI_ID" ]]; then
  echo "AMI já está disponível na região padrão: $EXISTING_AMI_ID"
  exit 0
fi

# Inicia a cópia da AMI para a região padrão
aws ec2 copy-image \
  --source-region $SOURCE_REGION \
  --source-image-id $LATEST_AMI_ID \
  --name "Copy of $LATEST_AMI_ID" \
  --query 'ImageId' \
  --output text

echo "Requisição para copiar a AMI ($LATEST_AMI_ID) foi feita."
