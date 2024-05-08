sleep 20

yum update -y
amazon-linux-extras install docker -y
service docker start

cd ~
mkdir -p /usr/local/lib/docker/cli-plugins
cd /usr/local/lib/docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-linux-x86_64 -o docker-compose
chmod +x docker-compose

cd ~
mkdir airbyte && cd airbyte
wget https://raw.githubusercontent.com/airbytehq/airbyte/master/run-ab-platform.sh
chmod +x run-ab-platform.sh
./run-ab-platform.sh -b