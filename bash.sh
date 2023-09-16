docker build -t your-dockerhub-username/wordpress-apache:v1
docker tag your-dockerhub-username/wordpress-apache:v1 your-dockerhub-username/wordpress-apache:v1
docker login -u your-dockerhub-username
docker push your-dockerhub-username/wordpress-apache:v1
docker run -d -p 8080:80 your-dockerhub-username/wordpress-apache:v1
