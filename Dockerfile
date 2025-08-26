# Use official Nginx image
FROM nginx:alpine

# Copy your static files to nginx's default html directory is testing
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Nginx automatically starts with the base imageee
