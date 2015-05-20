## Docker PHP Apache Image
Docker PHP Apache base image from 5.6.9-apache php image on docker hub.

### Requirements
- The root of the site points to the public folder inside the directory you attach to the image.  Eg. /path/to/code needs to have a public/ folder with yoru index.php or index.html file

### Build
To build this image yourself from the code follow these command
```sh
$ docker build -t <name>/php-apache .
```

### Demo Development Usage (With linked MySQL image)
```sh
$ docker run -it -p 9000:80 -v /path/to/code:/var/www/html --link my-mysql:mysql --rm --name my-php-apache <name>/php-apache
```

### Demo Production Usage (With linked MySQL image)
```sh
$ docker run -d --restart=always -p 9000:80 -v /path/to/code:/var/www/html --link my-mysql-image:mysql --name my-php-apache <name>/php-apache
```

### TODO
- 

### License
This code is maintained by Jason Michels (http://jasonmichels.com) and open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)