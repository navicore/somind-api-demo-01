# run this from the Dockerfile cmd/entrypoint to write the proper
# auth config data from ENV vars to files visible to both the server and
# the client post bundle build time (docker image creation).

# only bad people make binaries that can only be run with a certain network
# address or hard-coded to use specific external services - see "12 factor app"

source ./MAKE_CONFIG_FROM_ENV.sh
yarn prod
