sed "s/##CLIENT_ID##/${CLIENT_ID}/g" "./src/auth_config_example.json" |
sed "s/##DOMAIN##/${DOMAIN}/g" |
sed "s~##APP_ORIGIN##~${APP_ORIGIN}~g" |
sed "s~##API_IDENTIFIER##~${API_IDENTIFIER}~g" > "./src/auth_config.json"

echo "configured for domain $DOMAIN and origin ${APP_ORIGIN}"
