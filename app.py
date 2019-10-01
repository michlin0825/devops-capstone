#!/usr/bin/env python
"""flask framework for http endpoint."""
from flask import Flask

APP = Flask(__name__)


@APP.route("/")
def home():
    """Simple content for default rout."""
    return "Hello devops from Michel Lin"


if __name__ == "__main__":
    APP.run(host='0.0.0.0', port=80, debug=True) # specify port=80
