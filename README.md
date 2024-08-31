# PizzaReader-docker
Used for development purposes, may need improvements to be used in production.  
For example you should configure the nginx only as proxy and remove phpmyadmin.  

# Usage
You have to add certificates in [nginx/conf.d/ssl](nginx/conf.d/ssl).

Clone the repo into `app` folder.
```bash
git clone https://github.com/FedericoHeichou/PizzaReader.git app
cp .env.example .env
docker compose up -d
```
