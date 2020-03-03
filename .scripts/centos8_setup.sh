REMOTE_USER="$1"
HOST="$2"
SSH_KEY="$3"
REMOTE_DOCKER_DIR="/docker"
DOCKER_COMPOSE_REPO="https://gitlab.com/l.levickas/alws"
TAB="    "
ALLOWED_IP=""

if [[ -z $1 ]]; then
	read -p "Remote User:" REMOTE_USER
	read -p "Remote Address:" HOST
	read -p "SSH Key To Send To Remote Authorized List:" SSH_KEY
fi

if [[ ! -f $SSH_KEY ]]; then
	ssh-keygen
fi

ssh-copy-id -i ${SSH_KEY} ${REMOTE_USER}@${HOST} \
	&& echo "\nHost ${HOST}\n${TAB}IdentityFile ${SSH_KEY}"

ssh ${REMOTE_USER}@${HOST} << EOF
	yes | dnf update \
	&& yes | dnf install lynis vim curl git \
	&& dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo \
	&& dnf install docker-ce --nobest -y \
	&& systemctl start docker \
	&& systemctl enable docker \
	&& curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose \
	&& git clone "$DOCKER_COMPOSE_REPO" "$REMOTE_DOCKER_DIR" \
	&& cd $REMOTE_DOCKER_DIR \
	&& mv .env.dist .env \
	&& echo "Edit $REMOTE_DOCKER_DIR/.env to your needs and run the docker-compose"
EOF

if [[ ! -z $ALLOWED_IP ]]; then
	ssh ${REMOTE_USER}@${HOST} "iptables -A INPUT -p tcp ! -s $ALLOWED_IP -j DROP"
fi
