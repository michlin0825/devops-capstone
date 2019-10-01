#!/usr/bin/env python
"""does things"""
from flask import Flask

APP = Flask(__name__)


@APP.route("/")
def home():
    """does more things"""
    html = f"<html><h3>Hello Udacity!</h3><p>This is Michael Lin.<br><font color='green'>I love green.</font></p></html>"
    return html.format(format)


if __name__ == "__main__":
    APP.run(host='0.0.0.0', port=80, debug=True) 
