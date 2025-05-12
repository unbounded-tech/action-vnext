Compose can now delegate builds to bake for better performance.
 To do so, set COMPOSE_BAKE=true.
#0 building with "builder-b5b354c7-3f9a-40d5-b405-e1e855e3267a" instance using docker-container driver

#1 [changelog internal] load build definition from Dockerfile
#1 transferring dockerfile: 824B done
#1 DONE 0.0s

#2 [changelog internal] load metadata for docker.io/library/alpine:3.21
#2 DONE 0.1s

#3 [changelog internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [changelog  1/10] FROM docker.io/library/alpine:3.21@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c
#4 resolve docker.io/library/alpine:3.21@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c done
#4 DONE 0.0s

#5 [changelog internal] load build context
#5 transferring context: 35B done
#5 DONE 0.0s

#6 [changelog  7/10] RUN /usr/local/bin/vnext --version
#6 CACHED

#7 [changelog  8/10] COPY entrypoint.sh /entrypoint.sh
#7 CACHED

#8 [changelog  9/10] RUN chmod +x /entrypoint.sh
#8 CACHED

#9 [changelog  5/10] RUN ubi --project harmony-labs/vnext --tag v0.11.1 --in /usr/local/bin/
#9 CACHED

#10 [changelog  4/10] RUN ubi --version
#10 CACHED

#11 [changelog  2/10] RUN apk add --no-cache curl tar git
#11 CACHED

#12 [changelog  6/10] RUN rm /usr/local/bin/ubi
#12 CACHED

#13 [changelog  3/10] RUN curl --silent --location https://raw.githubusercontent.com/houseabsolute/ubi/master/bootstrap/bootstrap-ubi.sh | sh
#13 CACHED

#14 [changelog 10/10] RUN adduser -D -u 1001 github &&     git config --global --add safe.directory /workspace &&     git config --global --add safe.directory /github/workspace
#14 CACHED

#15 [changelog] importing to docker
#15 DONE 0.0s

#16 [changelog] exporting to docker image format
#16 exporting layers done
#16 exporting manifest sha256:c25770f388cd9c05422443b907d37a279aac3b97b79a3be1bf95d07391d963e8 done
#16 exporting config sha256:d99fd3bab64bfd68e0bc27d52602c5e5dff2f2bbad80b41511d886b3953c67d4 done
#16 sending tarball 0.1s done
#16 DONE 0.1s

#17 [changelog] resolving provenance for metadata file
#17 DONE 0.0s
### What's changed in v0.10.2

* fix: quiet docker run
