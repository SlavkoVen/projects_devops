FROM python:3.10.14-slim-bullseye

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt

CMD pytest --alluredir=/app/allure-results tests/alerts_frame_windows_test.py


