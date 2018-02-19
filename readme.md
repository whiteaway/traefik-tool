# Træfik | your local docker server 

## What is this

Well, check out [traefik](https://hub.docker.com/_/traefik/) - its a golang server project that does magic to your development environment with Docker. 

If you have ever been spinning up an environment with dor example docker-compose which and been annoyed by going for it with localhost and some previously unused port like http://localhost:8733, thats what this is for. Have your development projects hosted on your local machine with an actual url. Like when you used to use (L,M,W)AMP. for example: http://project.dev.local


## Do this
Clone this repo to your machine. I have it in my homefolder in a subdirectory called 'tools'.


Check the example-files for docker-compose.yml configuration file and traefik.toml file.  

You should update these two files with a desired url you want to use locally to have traefik on.  
Either put one in the files and copy them to your folder without example- in front, or run setup.sh (**only works on mac or linux**).

run `docker-compose up` and visit the url you gave. You should now have the traefik interface on the url, and a new network "traefik_nw" for your services to use.


## It does

A service will now run on your machine, so when you make a new docker container, you can give it labels that will allow it to register with your traeffik service. See the labels section in example-docker-compose.yml for labels to register a new service when needed. 

```
      - "traefik.backend=project"
      - "traefik.frontend.rule=Host:project.dev.local"
      - "traefik.port=80"
      - "traefik.enable=true"
```

Also remember to assign it your traefic network:

```
	networks:
  		- traefik_nw
```