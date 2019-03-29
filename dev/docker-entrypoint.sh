#!/bin/bash

# if [[ -n "$PRODUCTION" ]]; then
# 	npm install --production
# else
# 	npm install https://github.com/StackStorm/hubot-stackstorm.git#add-msteams
# fi

if [[ ! -d "node_modules" ]]; then
	npm install --save
	npm cache verify
elif [[ ! -d "node_modules/hubot-stackstorm" ]]; then
	npm install https://github.com/StackStorm/hubot-stackstorm.git#add-msteams
	npm cache verify
fi

source /app/st2chatops.env

/app/bin/hubot
