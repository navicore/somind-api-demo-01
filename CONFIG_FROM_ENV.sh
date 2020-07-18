# 
# create a config js file to serve to the pre-compiled bundle in the remote browser as needed
# this is necessary since the bundle was compiled when the docker image was made - long long before we
# chose the ENV var values.
# 
# all default web dev infra that assumes all builds are for a static mode and network address are idiotic
# 

rm -rf "./public/auth_config.js"

sed "s/##CLIENT_ID##/${CLIENT_ID}/g" "./auth_config_example.js"     |
sed "s/##DOMAIN##/${DOMAIN}/g"                                            |
sed "s~##APP_ORIGIN##~${APP_ORIGIN}~g"                                    |
sed "s~##API_ORIGIN##~${API_ORIGIN}~g"                                    |
sed "s~##API_IDENTIFIER##~${API_IDENTIFIER}~g" > "./public/auth_config.js"

#
# create a config file to load in the api server at runtime.  note this file doesn't help the bundle
# user since the bundle is already compiled
#
rm -rf "./src/auth_config.json"

sed "s/##CLIENT_ID##/${CLIENT_ID}/g" "./src/auth_config_example.json"     |
sed "s/##DOMAIN##/${DOMAIN}/g"                                            |
sed "s~##APP_ORIGIN##~${APP_ORIGIN}~g"                                    |
sed "s~##API_ORIGIN##~${API_ORIGIN}~g"                                    |
sed "s~##API_IDENTIFIER##~${API_IDENTIFIER}~g" > "./src/auth_config.json"

echo "configured for domain $DOMAIN and origin ${APP_ORIGIN}"

