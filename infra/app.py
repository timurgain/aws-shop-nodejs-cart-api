#!/usr/bin/env python3
import os

import aws_cdk as cdk

from infra.infra.lambda_nest_app_stack import LambdaNestAppStack

# 0. Set environment variables

env = {
    "account": "730335652080",
    "region": "eu-north-1",
}

# 1. Init cdk app

app = cdk.App()

# 2. Create stack

LambdaNestAppStack(
    app,
    "LambdaNestAppStack",
    env=env,
)

# 3. Generate AWS CloudFormation template

app.synth()
