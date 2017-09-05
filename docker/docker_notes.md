## Docker command
* start container
```shell
$ docker run container_name:version
```

* map a host port to container port
    * docker container run -p 9999:80 httpd:2.4

* Accessing container:
    * find id: docker container ls
    * execute cmd: docker container exec container_id/name command
    * attaching a shell to a container :
    ```shell
    $ docker container exec -it container_id/name /bin/bash
    # start container and connect to it
    $ docker run -it  image_name:version
    ```
    * get console output from container
    ```shell
    docker logs container_id
    ```

* install package inside a container in attached shell
    * the package will be kept after exit container?

## Dockerfile

* specify base iamge:
    * FROM image_name
* Expose a port inside of its associated container
    * EXPOSE port_number
    * you still need map ports between the host and container when you run `docker container run`
* run command
    * RUN command
* Add information to Dockerfile
    * LABEL key="value"
* Build Image from dockerfile
    * docker image build --tag image_name:version .

## Copy file into running container

### command
  ```
  docker container op local_file container_id:container_destionation
  ```
### Dockerfile instruction
  ```
  COPY page.html /usr/local/apache2/htdocs/
  ```
### volume

```
#create a link between the folder /my-files on your host #machine and the htdocs folder in the #container.
#This also runs the container in the background.
    docker run -d -p 80:80 -v /my-files:/usr/local/apache2/htdocs web-server:1.1
```
  we can also create a volume explicitly before image start

```
#create volume
$ docker volume create my-vol
```
list volume

```
$ docker volume ls
local               my-vol
```
inspect volume to find out the location on host system
```
$ docker volume inspect my-vol
  [
      {
          "Driver": "local",
          "Labels": {},
          "Mountpoint": "/var/lib/docker/volumes/my-vol/_data",
          "Name": "my-vol",
          "Options": {},
          "Scope": "local"
      }
  ]
```
start a container with volume
```
$ docker run -d \
  -it \
  --name devtest \
  --mount source=myvol2,target=/app \
  nginx:latest
```
the above command bind the folder on the host: /var/lib/docker/volumes/my-vol/_data with the location /data on the container
