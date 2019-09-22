    cloud_web:
        image: smtc_web_cloud:latest
        ports:
            - "443:8080"
        environment:
            DBHOST: "http://ifelse(eval(defn(`NOFFICES')>1),1,cloud_db,db):9200"
            NO_PROXY: "*"
            no_proxy: "*"
        volumes:
            - /etc/localtime:/etc/localtime:ro
        secrets:
            - source: self_crt
              target: self.crt
              uid: ${USER_ID}
              gid: ${GROUP_ID}
              mode: 0444
            - source: self_key
              target: self.key
              uid: ${USER_ID}
              gid: ${GROUP_ID}
              mode: 0440
            - source: dhparam_pem
              target: dhparam.pem
              uid: ${USER_ID}
              gid: ${GROUP_ID}
              mode: 0444
ifelse(defn(`PLATFORM'),`VCAC-A',`dnl
        networks:
            - default_net
')dnl
        deploy:
            placement:
                constraints:
                    - node.role==manager