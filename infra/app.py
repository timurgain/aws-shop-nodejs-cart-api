#!/usr/bin/env python3
import os

import aws_cdk as cdk

from infra.api_nest_stack import ApiNestStack

# 0. Set environment variables

env = {
    "account": "730335652080",
    "region": "eu-north-1",
}

# 1. Init cdk app

app = cdk.App()

# 2. Create stack

ApiNestStack(
    app,
    "LambdaApiNestStack",
    env=env,
)

# 3. Generate AWS CloudFormation template

app.synth()
