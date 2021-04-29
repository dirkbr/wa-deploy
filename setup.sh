#!/bin/bash

git clone https://github.com/thecodingmachine/workadventure.git /opt/workadventure
git clone https://github.com/dirkbr/wa-deployment.git /opt/wa-deployment

mv --backup /opt/wa-deployment/.env /opt/workadventure/.env
mv --backup /opt/wa-deployment/docker-compose.yaml /opt/workadventure/docker-compose.yaml
