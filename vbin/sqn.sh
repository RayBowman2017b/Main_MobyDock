#!/bin/bash

 echo ''

# ls -la
 echo ' -------------------------------'

# Flask ­ Docker Compose 
# Make sure you're in the same directory as the Dockerfile 
 cd ~/Projects/MobyDock/mobydock
 
# Investigate the Docker Compose help menu 
# docker-compose --help
 
# Run Docker Compose by launching everything in one go 
# docker-compose up
# echo 'docker-compose up'
# docker-compose up
 
# [open a 2nd terminal tab with CTRL+Shift+T]
 
#docker start mobydock_postgres_1
#docker start mobydock_redis_1
#docker start mobydock_mobydock_1

# ralph@sys-2016-07-xu:~/Projects/MobyDock/mobydock$ docker start mobydock_postgres_1
# mobydock_postgres_1
# ralph@sys-2016-07-xu:~/Projects/MobyDock/mobydock$ docker start mobydock_redis_1
# mobydock_redis_1
# ralph@sys-2016-07-xu:~/Projects/MobyDock/mobydock$ docker start mobydock_mobydock_1
# mobydock_mobydock_1
# ralph@sys-2016-07-xu:~/Projects/MobyDock/mobydock$ dcps
# executing: docker ps
# CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
# 1e25a1bb6717        mobydock_mobydock   "gunicorn -b 0.0.0.0:"   About an hour ago   Up 9 seconds        0.0.0.0:8000->8000/tcp   mobydock_mobydock_1
# a5a5448064e5        postgres:9.6.5      "docker-entrypoint.sh"   About an hour ago   Up 26 seconds       0.0.0.0:5432->5432/tcp   mobydock_postgres_1
# edad06d107f5        redis:4.0.1         "docker-entrypoint.sh"   About an hour ago   Up 13 seconds       0.0.0.0:6379->6379/tcp   mobydock_redis_1
#  --- DONE!

# ralph@sys-2016-07-xu:~/Projects/MobyDock/mobydock$ dccpps
# executing: docker-compose ps
#        Name                      Command               State           Ports          
# -------------------------------------------------------------------------------------
# mobydock_mobydock_1   gunicorn -b 0.0.0.0:8000 - ...   Up      0.0.0.0:8000->8000/tcp 
# mobydock_postgres_1   docker-entrypoint.sh postgres    Up      0.0.0.0:5432->5432/tcp 
# mobydock_redis_1      docker-entrypoint.sh redis ...   Up      0.0.0.0:6379->6379/tcp 
#  --- DONE!


# Confirm the newly downloaded images 
 echo 'docker images'
 docker images
 
# Confirm the newly running containers with Docker 
 echo 'docker ps'
 docker ps
 
# Confirm the newly running containers with Docker Compose 
 echo 'docker-compose ps'
 docker-compose ps
 
# Create the PostgreSQL database 
# docker exec mobydock_postgres_1 createdb -U postgres mobydock
# echo 'docker exec mobydock_postgres_1 createdb -U postgres mobydock'
# docker exec mobydock_postgres_1 createdb -U postgres mobydock
 
# ^ If you see that it already exists, that's ok.  
 
# Create the database user and grant permissions onto the database 
# docker exec mobydock_postgres_1 psql -U postgres -c "CREATE USER
# mobydock WITH PASSWORD 'yourpassword'; GRANT ALL PRIVILEGES ON \
# DATABASE mobydock to mobydock;"
# echo 'docker exec mobydock_postgres_1 psql -U postgres -c "CREATE USER '
# echo 'mobydock WITH PASSWORD password_01; GRANT ALL PRIVILEGES ON '
# echo 'DATABASE mobydock to mobydock;"'
# docker exec mobydock_postgres_1 psql -U postgres -c "CREATE USER 
# mobydock WITH PASSWORD 'password_01'; GRANT ALL PRIVILEGES ON 
# DATABASE mobydock to mobydock;"
 
# ^ If you see that it already exists, that's ok.  
 
# ^ If you changed the database name, username or password in the ​
# config/settings.py ​file you will need to 
# adjust the files in both this command as well as the ​
# docker­compose.yml ​file. 
 
# Visit the /seed route in the xubuntu's web browser 
# http://localhost:8000/seed 
 
# Feed MobyDock until you get bored 
# <Keep reloading your browser> 
 
 
 
# [Go back to the 1st terminal tab]
 
# Hit CTRL+C to exit Docker Compose and see if everything shut down 
# echo 'docker ps'
# docker ps
 
# ^ If you see anything, this is an edge case bug with Docker Compose. 
 
# Ensure the containers get stopped 
# echo 'docker-compose stop'
# docker-compose stop
 
# Install git 
# echo 'sudo apt-get install git'
# sudo apt-get install git
 
# Configure git 
# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"
# echo 'git config --global user.email "raybowman2017b@gmail.com"'
# git config --global user.email "raybowman2017b@gmail.com"
# echo 'git config --global user.name "RayBowman2017b"'
# git config --global user.name "RayBowman2017b"
 
# ^ Customize the text in blue with whatever you want.  
 
# Create a git repo out of the project 
# echo 'git init && git add -A && git commit -m "Initial commit"'
# git init && git add -A && git commit -m "Initial commit"

 echo ' -------------------------------'
 echo ' -------------------------------'
