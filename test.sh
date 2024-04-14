#/bin/bash

set -e

npm i

npm run start &

npx prettier . --check

# wait for the server to start running
while [[ "$(curl -s -o /dev/null -w '%{http_code}' 'localhost:4000')" == "000" ]]; do sleep 1; done

# start jest
npm run run-test --coverage || true

# kill the server again
killall node
