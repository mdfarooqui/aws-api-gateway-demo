resource "aws_api_gateway_rest_api" "paas-apigateway-customer-profile-service" {
  name        = "customer-profile-service"
  description = "customer-profile-service"
  body        = "${data.template_file.paas-apigateway-customer-profile-service.rendered}"
  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
            "Service": ["apigateway.amazonaws.com"]
        },
        "Action": "execute-api:Invoke"
      }
    ]
}
EOF

}

resource "aws_api_gateway_deployment" "client-example-api" {
  rest_api_id = "${aws_api_gateway_rest_api.paas-apigateway-customer-profile-service.id}"
  stage_name  = "dev"

  stage_description = "${file("customer-profile-service.yaml")}"
  
  depends_on = [aws_api_gateway_rest_api.paas-apigateway-customer-profile-service]
}

data "template_file" "paas-apigateway-customer-profile-service"{
  template = "${file("customer-profile-service.yaml")}"
  
  vars = {
    aws_tenant              = "${var.aws_tenant}"
    region                  = "${var.region}"
    apigateway_version      = "${var.apigateway_version}"
    standar_request_integration = <<EOF
    {
      \"body\" : $input.json('$'),
      \"headers\":{
          #foreach($header in $input.params().header.keySet())
          \"$header\": \"$util.escapeJavaScript($input.params().header.get($header))\" #if($foreach.hasNext),#end
          #end
        },
      \"method\":   \"$context.httpMethod\",
      \"params\": {
        #foreach($param in $input.params().path.keySet())
        \"$param\": \"$util.escapeJavaScript($input.params().path.get($param))\" #if($foreach.hasNext),#end
        #end
      },
      \"query\": {
        #foreach($queryParam in $input.params().querystring.keySet())
        \"$queryParam\": \"$util.escapeJavaScript($input.params().querystring.get($queryParam))\" #if($foreach.hasNext),#end
        #end
      } 
    }
    EOF
  }
}

