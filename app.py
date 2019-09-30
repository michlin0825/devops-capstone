#!/usr/bin/env python
"""does things"""
from flask import Flask

APP = Flask(__name__)


@APP.route("/")
def home():
    """does more things"""
    return "Hello World from Michael."


if __name__ == "__main__":
    APP.run(host='0.0.0.0', port=80, debug=True) # specify port=80
