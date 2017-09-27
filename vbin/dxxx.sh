#!/bin/bash
# sudo apt remove --purge atom
say_hey () { \
    echo 'hey from shell script'; \
} \
# -------------------------------------------------------- \
# -------------------------------------------------------- \
function say_hi () { \
    echo 'hello from shell script'; \
} \
# --------------------------------------------------------
# --------------------------------------------------------
actv_venv_FB () { \
  echo 'activating venv'; \
  echo ' >>> cd /home/ubuntu/workspace/flask_blog'; \
  cd /home/ubuntu/workspace/flask_blog; \
  echo 'executing: source venv/bin/activate'; \
  source venv/bin/activate; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'dcmg () :> docker image'

dcmg ()  { \
  echo 'executing: docker images'; \
  docker images; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'dcps () :> docker ps'

dcps ()  { \
  echo 'executing: docker ps'; \
  docker ps; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'dccpps () :> docker-compose ps'

dccpps ()  { \
  echo 'executing: docker-compose ps'; \
  docker-compose ps; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'dcpsa () :> docker ps -all'

dcpsa ()  { \
  echo 'executing: docker ps -all'; \
  docker ps -all; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'dcls () :> docker container ls'

dcls ()  { \
  echo 'executing: docker container ls'; \
  docker container ls \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'dclsa () :> docker container ls -a'

dclsa ()  { \
  echo 'executing: docker container ls -a'; \
  docker container ls -a \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'dcnls () :> docker node ls'

dcnls ()  { \
  echo 'executing: docker node ls'; \
  docker node ls; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

# --------------------------------------------------------

#  echo 'run_redis () :> docker run -d --name redisServer redis'

run_redis () { \
  echo 'executing: docker run -d --name redisServer redis'; \
  docker run -d --name redisServer redis; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------

# --------------------------------------------------------
# --------------------------------------------------------

# Apache must be pulled before this :> docker pull httpd

#  echo 'run_apache () :> docker run -d --name ApacheWebServer httpd'

run_apache () { \
  #echo 'executing: docker run -d --name ApacheWebServer httpd' \
  #docker run -d --name MyWebServer httpd \
  #docker run -d --name ApacheWebServer -P httpd \
  echo 'executing: docker run -d --name ApacheWebServer -p 8000:80 httpd'; \
#  docker run -d --name ApacheWebServer -p 8000:80 httpd; \
  docker run -d --name ApacheWebServer -p 7700:80 httpd; \
  echo 'executing: docker port ApacheWebServer'; \
  docker port ApacheWebServer; \
  echo 'executing: docker-machine ip'; \
  docker-machine ip; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------

#  echo 'stop_apache () :> docker stop ApacheWebServer'

stop_apache () { \
  echo 'executing: docker stop ApacheWebServer'; \
  #docker stop MyWebServer; \
  docker stop ApacheWebServer; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'rm_apache () :> docker rm -f ApacheWebServer'

rm_apache () { \
  echo 'executing: docker rm -f ApacheWebServer'; \
  #docker rm MyWebServer; \
  docker rm -f ApacheWebServer; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'get_ip () :> docker-machine ip (get host IP address)'

# https://docs.docker.com/machine/get-started/#run-containers-and-experiment-with-machine-commands

get_ip () { \
  echo 'executing: docker-machine ip'; \
  # docker-machine ip default; \
  docker-machine ip; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'run_nginx () :> docker run -d -p --name nginxWebServer 8000:80 nginx'

run_nginx () { \
  echo 'executing: docker run -d -p 8000:80 --name nginxWebServer nginx'; \
  docker run -d -p 8000:80 --name nginxWebServer nginx; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'test_nginx () :> curl $(docker-machine ip default):8000 < /c/Users/Sys_2016_07_25/docker/vbin/nginx_test_01.html'
#  echo 'test_nginx () :> curl $(docker-machine ip default):8000 < vbin/nginx_test_01.html'

test_nginx () { \
  echo 'executing: curl $(docker-machine ip default):8000 < /c/Users/Sys_2016_07_25/docker/vbin/nginx_test_01.html'; \
  curl $(docker-machine ip default):8000 < /c/Users/Sys_2016_07_25/docker/vbin/nginx_test_01.html; \
  #curl $(docker-machine ip default):8000 \
  #  <!DOCTYPE html><html><body><h1>Welcome to nginx!</h1></body></html> \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'stop_nginx () :> docker stop nginxWebServer'

stop_nginx () { \
  echo 'executing: docker stop nginxWebServer'; \
  docker stop nginxWebServer; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'rm_nginx () :> docker rm -f nginxWebServer'

rm_nginx () { \
  echo 'executing: docker rm -f nginxWebServer'; \
  docker rm -f nginxWebServer; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'run_ubuntu () :> docker run -it —name ubuntu_container_01 ubuntu:latest'
run_ubuntu () { \
  echo 'executing: docker run -it --name ubuntu_container_01 ubuntu:latest'; \
  docker run -it --name ubuntu_container_01 ubuntu:latest; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'run_registry () :> docker run -d -p 5000:5000 --name local_registry_01 registry'

run_registry () { \
  echo 'executing: docker run -d -p 5000:5000 --name local_registry_01 registry'; \
  docker run -d -p 5000:5000 --name local_registry_01 registry; \
  echo ' --- DONE!'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'x () :> '

remind_wsrv () { \
  echo 'run_redis () :> docker run -d --name redisServer redis'; \
  echo ' --- ffor web servers ---'; \
  echo 'run_apache () :> docker run -d --name ApacheWebServer httpd'; \
  echo 'get_ip () :> docker-machine ip (get host IP address)'; \
  echo 'stop_apache () :> docker stop ApacheWebServer'; \
  echo 'rm_apache () :> docker rm -f ApacheWebServer'; \
  echo 'run_nginx () :> docker run -d -p --name nginxWebServer 8000:80 nginx'; \
  echo 'test_nginx () :> curl $(docker-machine ip default):8000 < vbin/nginx_test_01.html'; \
  echo 'stop_nginx () :> docker stop nginxWebServer'; \
  echo 'rm_nginx () :> docker rm -f nginxWebServer'; \
}
# --------------------------------------------------------
# --------------------------------------------------------

#  echo 'x () :> '

remind () { \
  echo ' *** remind_wsrv :> for web server routines ***'; \
  echo 'dcmg () :> docker images'; \
  echo 'dcps () :> docker ps'; \
  echo 'dccpps () :> docker-compose ps'; \
  echo 'dcpsa () :> docker ps -all'; \
  echo 'dcls () :> docker container ls'; \
  echo 'dclsa () :> docker container ls -a'; \
  echo 'dcnls () :> docker node ls'; \
  echo 'run_registry () :> docker run -d -p 5000:5000 --name local_registry_01 registry'; \
  echo 'run_ubuntu () :> docker run -it --name ubuntu_container_01 ubuntu:latest'; \
};
# --------------------------------------------------------
# --------------------------------------------------------
# --------------------------------------------------------
echo ' --- DONE!';