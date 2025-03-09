FROM montali/python-api:latest

RUN apt update
RUN apt install python3 python3-pip -y

RUN mkdir /python_api

COPY requirements.txt /python_api/requirements.txt
RUN pip3 install -r /python_api/requirements.txt
COPY python-api.py /python_api/python-api.py

WORKDIR /python_api

CMD ["python3", "python-api.py"]