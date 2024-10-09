FROM python:3.11-slim-buster

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# You could add "--host=0.0.0.0" to make the docker container listen to all
# interfaces. Aka it allows ext traffic into your machine.
# To allow only host, you can use `docker run --network="host" {docker-img}` (linux).
# Alternatively if you want to see it working in the docker itself, then
# you need to add `&& apt-get update && apt-get install -y curl` to run. 
# After that write `docker exec -it {container-id} bash` 
# followed by `curl 127.0.0.1:5000` **ASSUMING you started at `-p 5000:5000`
# Alternatively you can first find the container port you are connecting to and
# ask flask to directly connect it.
CMD [ "python3", "-m" ,"flask", "run", "--host=172.17.0.2"]