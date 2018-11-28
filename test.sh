error() {
  echo ">>>>>> Test Failures Found, exiting test run <<<<<<<<<"

  echo
  echo ===========================================================
  echo Printing logs from APP container
  echo ===========================================================
  echo

  docker logs app

  echo
  echo ===========================================================
  echo End of logs from APP container
  echo ===========================================================
  echo

  exit 1
}
cleanup() {
  echo "....Cleaning up"

  docker stop app
  docker stop mongodb

  docker rm app
  docker rm mongodb
  docker network rm api-test-example.network

  # remove untagged images (these are left behind when docker run fails)
  if [ $(docker images | grep '^<none>' | wc -c) -gt 0 ]; then
    docker images | grep "^<none>" | tr -s " " " " | cut -f3 -d" " | ifne xargs docker rmi
  fi
  echo ""
  echo "....Cleaning up done"
}
trap error ERR
trap cleanup EXIT

ifne () {
        read line || return 1
        (echo "$line"; cat) | eval "$@"
}

echo
echo ===========================================================
echo Building containers
echo ===========================================================
echo

docker build -t api-test-example ./app
docker build -t api-test-example-stub ./stub
docker build -t api-test-example.test ./tests

echo
echo ===========================================================
echo Spinning up test environment
echo ===========================================================
echo

docker network create -d bridge api-test-example.network

docker run -d --net=api-test-example.network --name mongodb mongo
sleep 1
docker run -d --net=api-test-example.network -e MONGO=mongodb://mongodb:27017/customerdetails --name app api-test-example
sleep 1

echo
echo ===========================================================
echo Running outside-in tests
echo ===========================================================
echo

docker run --net=api-test-example.network --rm -e SERVICE_UNDER_TEST_HOSTNAME=app:3000 --name tests api-test-example.test ./node_modules/.bin/cucumber-js --tags @core

echo
echo ===========================================================
echo Running outside-in tests with MONGO down
echo ===========================================================
echo

docker network disconnect api-test-example.network mongodb

docker run --net=api-test-example.network --rm -e SERVICE_UNDER_TEST_HOSTNAME=app:3000 --name tests api-test-example.test cucumberjs --tags @mongo_is_down
