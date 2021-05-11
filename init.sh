#!/bin/bash
WA_ROOT=/opt/workadventure

## create user workadventure with Home-Directory /opt/workadventure (vgl. binary kitch)
##

# install stuff
DEBIAN_FRONTEND=noninteractive apt --assume-yes install git nano htop #nginx


# clone repos
#git clone https://github.com/thecodingmachine/workadventure.git ${WA_ROOT}/source
git clone https://git.binary-kitchen.de/noby/workadventure.git ${WA_ROOT}/source
git clone https://github.com/dirkbr/wa-deployment.git ${WA_ROOT}/wa-deployment
bash ${WA_ROOT}/install-docker.sh

# copy docker  files
cp --backup ${WA_ROOT}/wa-deployment/.env ${WA_ROOT}/source/.env
cp --backup ${WA_ROOT}/wa-deployment/docker-compose.yaml ${WA_ROOT}/source/docker-compose.yaml

# copy nginx config
cp ${WA_ROOT}/wa-deployment/workadventure /etc/nginx/sites-available/workadventure
ln -s /etc/nginx/sites-available/workadventure /etc/nginx/sites-enabled/workadventure
mkdir /etc/nginx/ssl

# increase server_names_hash_bucket_size to 64 in /etc/nginx/nginx.conf

### afterwards:

# copy ssl certificates to !!! change remote folder !!!
# - ssl_certificate /etc/nginx/ssl/wa.xn--tdelteile-q9a.de/fullchain.pem;
# - ssl_certificate_key /etc/nginx/ssl/wa.xn--tdelteile-q9a.de/privkey.pem;
# nginx -t && system restart nginx

# companions
# copy companion tiles to front/dist/resources/characters/
# edit front/src/Phaser/Companion/CompanionTextures.ts
# - add one line per companion
# - { name: "dog1", img: "resources/characters/pipoya/Dog 01-1.png", behaviour: "dog" };
