import logging
from aws_cdk import (
    aws_lambda as _lambda,
    aws_apigateway as apigateway,
    Stack,
)
from constructs import Construct

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ApiNestStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        try:

            self.nestHandler = _lambda.Function(
                self,
                "ApiNestHandlerFunction",
                runtime=_lambda.Runtime.NODEJS_20_X,
                code=_lambda.Code.from_asset("../dist"),
                handler="main.handler",
            )

            api = apigateway.RestApi(
                self,
                id="CartAPINestJS",
                rest_api_name="Cart API NestJS",
                deploy=True,
                default_method_options={"api_key_required": True},
            )

            api.root.add_proxy(
                default_integration=apigateway.LambdaIntegration(
                    self.nestHandler, proxy=True
                )
            )

            plan = api.add_usage_plan("UsagePlan",
                name="Easy",
                throttle=apigateway.ThrottleSettings(
                    rate_limit=10,
                    burst_limit=2
                )
            )

            api_key = api.add_api_key("ApiKey")

            plan.add_api_key(api_key)

            logger.info("ApiNestStack created successfully")

        except Exception as err:
            logger.error(f"Error in ApiNestStack: {err}")
