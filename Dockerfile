FROM alpine:3.22

# Install dependencies: curl and tar
RUN apk add --no-cache curl tar git

# Download the ubi binary (adjust URL if needed)
RUN curl --silent --location https://raw.githubusercontent.com/houseabsolute/ubi/master/bootstrap/bootstrap-ubi.sh | sh
RUN ubi --version

# Use ubi to install the pre-built vnext executable
RUN ubi --project unbounded-tech/vnext --tag v1.15.11 --in /usr/local/bin/

# Clean up: remove ubi and the temporary directory
RUN rm /usr/local/bin/ubi

RUN /usr/local/bin/vnext --version

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN adduser -D -u 1001 github && \
    git config --global --add safe.directory /workspace && \
    git config --global --add safe.directory /github/workspace

USER github

ENTRYPOINT ["/entrypoint.sh"]
