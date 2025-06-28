# scp -i ~/.ssh/id_rsa -r app ubuntu@<EC2_PUBLIC_IP>:~/app
# ssh -i ~/.ssh/id_rsa ubuntu@<EC2_PUBLIC_IP>

# cd app
# docker build -t flask-app .
# docker run -d -p 5000:5000 --name flask-container flask-app

FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
