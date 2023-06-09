from flask import Flask
from flask.logging import create_logger
import logging

app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)

@app.route("/")
def home():
    html = f"<h3>Thodoris' Cloud Devops Capstone Project Home</h3>"
    return html.format(format)

@app.route("/hello")
def hello():
    LOG.info("Received hello request")
    html = f"<h3>Hello from Thodoris' Cloud Devops Capstone project NEW Deployment!</h3>"
    return html.format(format)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8000, debug=True)
