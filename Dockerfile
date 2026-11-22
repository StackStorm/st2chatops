FROM node:24-alpine

WORKDIR /app

# .npmrc applies the supply-chain guardrails: no install scripts, no git dependencies.
# The tree has no native modules, so no compiler is needed.
COPY package.json npm-shrinkwrap.json .npmrc ./
COPY vendor ./vendor
RUN npm ci --omit=dev --no-audit --no-fund && npm cache clean --force

COPY bin ./bin
# hubot scripts only (scripts/ also holds st2chatops-docker-run.sh)
COPY scripts/*.js ./scripts/
COPY external-scripts.json st2chatops.env ./

USER node
EXPOSE 8081
# bin/hubot sources st2chatops.env, whose settings all fall back to the environment
CMD ["/app/bin/hubot"]
