#!/usr/bin/env python
"""flask framework for http endpoint."""
from flask import Flask

APP = Flask(__name__)


@APP.route("/")
def home():
    """Simple content for default rout."""
    html = f"<h3>Hello Udacity!</h3><p>This is Michael Lin</p>\
        <p>Code changed. blue/green deployment stages</p>"
    return html.format(format)


if __name__ == "__main__":
    APP.run(host='0.0.0.0', port=80, debug=True) # specify port=80
