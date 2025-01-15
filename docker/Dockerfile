# Stage 1: Build the Angular application
FROM node:lts AS build
ARG ENVIRONMENT=local
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN if [ -n "$ENVIRONMENT" ] && [ "$ENVIRONMENT" != "local" ]; then \
    npx ng build --configuration $ENVIRONMENT; \
    else \
    npx ng build; \
    fi

# Stage 2: Serve the application with nginx
FROM nginx:stable-alpine

# In alpine, gettext is installed differently
RUN apk add --no-cache gettext

# Copy the built app
COPY --from=build /app/dist /usr/share/nginx/html

# Copy the Nginx config template
COPY docker/default.conf.template /etc/nginx/templates/default.conf.template

# Copy the entrypoint script
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

# Use the custom entrypoint script
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
