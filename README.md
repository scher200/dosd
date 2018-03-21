

# DOSD


### DIND OPEN SWARM DEPLOYER

Ever needed more than one swarm on you system. YESSS!!!
Deploy a whole swarm project in a docker container, or as many as you can handle.

*DOSD* is a small project that brings a swarm project to live within a docker container.
It is based on the [DIND Swarm](https://hub.docker.com/r/dockerswarm/dind/)
This give you all flexiblity to test out any kind of swarm project in one command and let's you delete it just as easy again.
The standard run gives you OpenFaas wrapped in a single container, I told you, have fun!!


## RUN
```
docker run -d --name swarm --privileged scher200/dosd
```
Or if you like direct connection ported to your host
```
docker run -d --name swarm -p 8080:8080 --privileged scher200/dosd
```

## SPECIFIED RUN
```
docker run -d --name swarm -p 80:80 --privileged \
           -e DOCKERD_CMD="dockerd --log-level 'fatal' > /dev/null 2>&1 &" \
           -e GIT_REPO="https://ThIsYoUrAmAzInGtOkEn@gitlab.com/username/yourawesomeproject" \
           -e GIT_BRANCH="master" \
           -e DEPLOY_STACK="docker stack deploy -c docker-compose.yml mystackname" \
           scher200/dosd
```
* If you like more logging or want to define a specail docker deamon setup, define DOCKERD_CMD
* Please use an access token if you need to authentication with your private GIT_REPO
* Make sure any GIT_BRACH you define is available in the targeted GIT_REPO
* The DEPLOY_STACK variable can contain a simple docker (swarm) command or any other shell script as long as is shipped within your project.
* If you like to reach your swarm app or swarm cluster define so like -p 2377 or like -p 9000:9000 on your docker run command

## DELETE SWARM PROJECT
```
docker rm -f swarm
```


### If you like another version of docker swarm inside your container
Clone [this github repository](https://github.com/scher200/dosd) by doing
```
git clone https://github.com/scher200/dosd
```
Open the 'Dockerfile' and change the versions specified here
Build it..
```
docker build --rm . -t yourdockername/dosd
```
And please be so kind and push it back to the docker hub
```
docker login
docker push yourdockername/dosd
```