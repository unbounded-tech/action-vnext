FROM alpine:3.21

# Install dependencies: curl and tar
RUN apk add --no-cache curl tar git

# Download the ubi binary (adjust URL if needed)
RUN curl --silent --location https://raw.githubusercontent.com/houseabsolute/ubi/master/bootstrap/bootstrap-ubi.sh | sh
RUN ubi --version

# Use ubi to install the pre-built vnext executable
RUN ubi --project harmony-labs/vnext --tag v0.5.0 --in /usr/local/bin/

# Clean up: remove ubi and the temporary directory
RUN rm /usr/local/bin/ubi

RUN /usr/local/bin/vnext --version

RUN adduser -D -u 1001 github && \
    git config --global --add safe.directory /workspace && \
    git config --global --add safe.directory /github/workspace

USER github

# Set the default entrypoint for the action
ENTRYPOINT ["/usr/local/bin/vnext"]
