#wget -O terraform.zip /tmp/terraform.zip  https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_windows_amd64.zip
#wget -O terraform.zip  https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_windows_amd64.zip
#unzip terraform.zip
export TF_VAR_image_id=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/images?private=true" | jq ."images[] | select(.name == \"tec-demo-$ARTIFACT_ID\") | .id") 

cd terraform
terraform init
terraform apply -input=false -auto-approve
