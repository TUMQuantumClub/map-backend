#!/bin/bash

npm i

nohup npm run start &
serverPID=$!

npx prettier . --check
prettier_result=$?

# wait for the server to start running
while [[ "$(curl -s -o /dev/null -w '%{http_code}' 'localhost:4000')" == "000" ]]; do sleep 1; done

# start jest
npm run run-test --coverage
test_result=$?

# kill the server again
kill $serverPID

if [[ "$prettier_result" != "0" ]]; then
  echo "prettier failed! Run ´npm run format´ to automatically fix this"
  if [[ "$test_result" != "0" ]]; then
    echo "tests failed as well!"
  fi
  exit 1
fi

if [[ "$test_result" != "0" ]]; then
  echo "tests failed!"
  exit 2
fi
