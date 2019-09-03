
    defn(`OFFICE_NAME')_simulated_cameras:
        image: smtc_sensor_simulation:latest
        environment:
            FILES: ".mp4$$"
            `NCAMERAS': "defn(`NCAMERAS')"
            RTSP_PORT: "11000"
            RTP_PORT: "12000"
        volumes:
            - /etc/localtime:/etc/localtime:ro
        ifelse(defn(`PLATFORM'),`VCAC-A',`
        networks:
            - default_net')
        deploy:
            placement:
                constraints: [ifelse(eval(defn(`NOFFICES')>1),1,node.labels.defn(`OFFICE_NAME')_zone==yes,node.role==manager)]

