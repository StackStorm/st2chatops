FROM mhart/alpine-node

COPY package.json /app/package.json
COPY external-scripts.json /app/external-scripts.json
COPY hubot-scripts.json /app/hubot-scripts.json
RUN cd /app; npm install --production; npm cache clean

EXPOSE 8080
CMD ["/app/bin/hubot"]
