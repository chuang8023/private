server {
     listen Port;

     server_name TIpAddress;

     root /var/www/org.feature.moban.aysaas.com/public/;
     error_log /var/log/nginx/org.moban.aysaas.cn-error.log error;
     access_log /var/log/nginx/org.moban.aysaas.cn-access.log combined;

        index index.php index.html index.htm;
        location / {
                if (!-e $request_filename) {
                        rewrite ^/(.*)$ /index.php?$1 last;
                }
        }

         location ~ \.php$ {
                fastcgi_pass 127.0.0.1:TPhpPort;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
                fastcgi_param ENV development;
        }
}
