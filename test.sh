#!/bin/bash

nohup npm run start &
serverPID=$!

# wait for the server to start running
while [[ "$(curl -s -o /dev/null -w '%{http_code}' 'localhost:4000')" == "000" ]]; do sleep 1; done

# start jest
npm run run-test --coverage
test_result=$?

# kill the server again
kill $serverPID

if [[ "$test_result" != "0" ]]; then
  echo "tests failed!"
  exit 1
fi
