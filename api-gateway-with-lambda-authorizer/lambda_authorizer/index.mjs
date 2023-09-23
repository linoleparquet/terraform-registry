export const handler = async (event) => {

  // Implement authorization logic here.
  let auth = 'Deny'
  if(event.authorizationToken == 'please-visit-https://linoleparquet.github.io') {
    auth = 'Allow'
  }
  
  // The value of 'arn' follows the format shown below.
  //
  //   arn:aws:execute-api:<regionId>:<accountId>:<apiId>/<stage>/<method>/<resourcePath>"
  //
  // See 'Set up Lambda custom integrations in API Gateway' for details.
  // https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-custom-integrations.html
  
  const arn = event.methodArn;
  const elements = arn.split(':')
  const region = elements[3]
  const accountNumber = elements[4]
  const apiId =  elements[5].split('/')[0]

  const response = {
    "principalId": "principal-id-1234",
    "policyDocument": {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "execute-api:Invoke",
          "Resource": [
            "arn:aws:execute-api:" + region + ":" + accountNumber +":" + apiId + "/*/*/*"
          ],
          "Effect": auth
        }
      ]
    }
  }
  
  return response;
};
