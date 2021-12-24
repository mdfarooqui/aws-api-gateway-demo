<h1 align="center">Swagger in AWS amazon</h1>

Please be free on watching those references in advance:

* [OpenAPI Spec](https://github.com/OAI/OpenAPI-Specification) 
* [SwaggerHub Vendor Extensions](https://app.swaggerhub.com/help/apis/vendor-extensions)
* https://app.swaggerhub.com/apis/moballiachi/fis-paas-bigdata/1.0.0


## Overview
This project is a initive to understand and contribute on how we can implement swagger as main tool to development and management our API in AWS amazon cloud. It is composed by an lambda and API Gateway which are deployed by terraform.


## Prerequisites
Get in your bastion machine in AWS amazon and install terrafom tool to deploy your enviroment with the follows command lines:

    $ curl -O https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip

    $ sudo unzip terraform_0.11.14_linux_amd64.zip -d /usr/bin/

    $ terraform -v


## Setups variables 
Download the project and be careful with following properties which are in file:
lambda/faas-CataloguesGet/variable.tf
* role_arn: replace your id tenant in the defult field

apigateway/openapi-public/variable.tf
* aws_tenant: replace your id tenant in the defult field


## Deploy your infrastructure
Go to apigateway/openapi-public folder and use terraform to deploy your APIGateway RESTful 

    $ cd apigateway/openapi-public

    $ terrafom init

    $ terraform plan

    $ terrafom apply


## Generete your code with swagger-codegen
Go to apigateway/openapi-public folder and execute the following command line:

    $ java -jar assent/swagger-codegen-cli.jar generate \
        -i ./apigateway-swagger-public.yaml \
        -l java \
        -o samples/java

"# aws-api-gateway-demo" 
"# aws-api-gateway-demo" 
"# aws-api-gateway-demo" 
