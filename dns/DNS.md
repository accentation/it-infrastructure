# DNS definition
Definition of end point to be set in the load balancer being public in internet and working as reverse proxy
##DEV
### public
* http://mydomain.com/ --> 192.168.1.240:8000
* http://mydomain.com/app
* http://mydomain.com/api
* http://mydomain.com/swagger
* http://mydomain.com/jenkins

### private
* NGINX --> 192.168.1.240:8000
* SSH  --> 192.168.1.240:2222
* API --> http://192.168.1.240:8081
* Database --> http://192.168.1.240:3306

##PROD
* TODO