FROM node:16-alpine AS deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json yarn.lock* ./
RUN yarn --frozen-lockfile


# Rebuild the source code only when needed
FROM node:16-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

ENV NEXT_TELEMETRY_DISABLED 1

EXPOSE 3000

ENV PORT 3000
ARG ENVIRONMENT
ENV NEXT_PUBLIC_ENVIRONMENT=$ENVIRONMENT
ENV ENVIRONMENT=$ENVIRONMENT

ARG API_URL
ENV NEXT_PUBLIC_API_URL=$API_URL
ENV API_URL=$API_URL

RUN yarn build
CMD ["yarn", "start"]
