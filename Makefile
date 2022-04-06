ifneq (,$(wildcard ./.env))
    include .env
    export
endif

update:
	sudo apt update -y
upgrade:
	sudo apt upgrade -y
install_needed:
	sudo apt install -y \
		wget \
		git \
		ssh \
		vim \
		zsh \
		terminator \
		chromium-browser \
		mumble
install_spotify:
	curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update -y && sudo apt-get install -y spotify-client
install_phpstorm:
	mkdir -p ./download/phpstorm
	wget -O ./download/phpstorm.tar.gz https://download.jetbrains.com/webide/PhpStorm-2021.3.3.tar.gz 
	sudo tar -xzf ./download/phpstorm.tar.gz -C /opt
	sudo rm ./download/phpstorm.tar.gz
install_docker:
	sudo apt update -y
	sudo apt install -y \
		ca-certificates \
		curl \
		gnupg \
		lsb-release
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu ${UBUNTU_VERSION} stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update -y
	sudo apt install -y docker-ce docker-ce-cli containerd.io
	sudo groupadd -f docker
	sudo usermod -aG docker $(USER)
install_enpass:
	sudo echo "deb https://apt.enpass.io/ stable main" | sudo tee -a /etc/apt/sources.list.d/enpass.list
	sudo wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo tee /etc/apt/trusted.gpg.d/enpass.asc
	sudo apt update -y
	sudo apt install -y enpass
install_insomnia:
	echo "deb [trusted=yes arch=${ARCH}] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
	sudo apt update -y
	sudo apt install -y insomnia
install_nodejs:
	sudo apt update -y
	sudo apt install -y nodejs npm
	sudo npm install --global yarn
install_vscode:
	sudo apt update -y
	sudo apt install -y software-properties-common apt-transport-https
	sudo wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=${ARCH}] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install -y code
git_config:
	git config --global --replace-all user.name "${INSTALL_GIT_FIRSTNAME}" 
	git config --global --replace-all user.email ${INSTALL_GIT_EMAIL}
install_all: update upgrade install_needed git_config install_phpstorm install_spotify install_docker install_enpass install_insomnia install_nodejs install_vscode