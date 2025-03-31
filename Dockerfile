FROM alpine:3.18

# Install dependencies: curl and tar
RUN apk add --no-cache curl tar

# Download the ubi binary (adjust URL if needed)
RUN curl --silent --location https://raw.githubusercontent.com/houseabsolute/ubi/master/bootstrap/bootstrap-ubi.sh | sh

RUN ubi --version

# Create a temporary directory for ubi to install binaries into
RUN mkdir -p /tmp/ubi-bin

# Use ubi to install the pre-built vnext executable
RUN ubi --project harmony-labs/vnext --in /tmp/ubi-bin

# Move the installed vnext binary to a location in PATH
RUN mv /tmp/ubi-bin/vnext /usr/local/bin/vnext

# Clean up: remove ubi and the temporary directory
RUN rm /usr/local/bin/ubi && rm -rf /tmp/ubi-bin

RUN /usr/local/bin/vnext --version

# Set the default entrypoint for the action
ENTRYPOINT ["/usr/local/bin/vnext"]
