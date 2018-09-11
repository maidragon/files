FROM centos
RUN  yum install wget -y \
 && wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm  \
 && rpm -Uvh epel-release-latest-7.noarch.rpm  \
 && yum install trafficserver -y  \
 && cd /etc/trafficserver  \
 && sed -i "s/CONFIG proxy.config.url_remap.pristine_host_hdr INT 0/CONFIG proxy.config.url_remap.pristine_host_hdr INT 1/g" records.config  \
 && sed -i "s/CONFIG proxy.config.http.server_ports STRING 8080/CONFIG proxy.config.http.server_ports STRING 80 80:ipv6/g" records.config  \
 && sed -i "s/CONFIG proxy.config.http.cache.required_headers INT 2/CONFIG proxy.config.http.cache.required_headers INT 0/g" records.config  \
 && echo "map http://cdn.phbai.com/ http://ro.prpr.io/" >> remap.config \
 && echo "map http://cdn.loli.rip/ http://ro.prpr.io/" >> remap.config \
 && echo "regex_map http://(.*)/ http://ro.prpr.io/" >> remap.config  \
 && sed -i "s/var\/cache\/trafficserver 256M/var\/cache\/trafficserver 10G/g" storage.config

EXPOSE 80
CMD ["sh", "-c", "/usr/bin/trafficserver start ; tail -f /dev/null"]