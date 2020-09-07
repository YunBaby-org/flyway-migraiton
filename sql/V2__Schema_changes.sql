DROP TABLE device_log;
DROP TABLE tracking_device;
DROP TABLE "user";

CREATE Table users_table(
    user_id varchar(36) PRIMARY KEY NOT NULL UNIQUE,
    username varchar(15),
    email varchar(50) NOT NULL UNIQUE,
    phone varchar(10) NOT NULL UNIQUE,
    password varchar(36) NOT NULL
);

CREATE Table trackers_table(
    device_id varchar(36) PRIMARY KEY NOT NULL UNIQUE,
    tkrname varchar(15) NOT NULL,
    phone varchar(10) NOT NULL UNIQUE,
    user_id varchar(36) NOT NULL UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users_table(user_id)
);

CREATE Table cage(
    device_id varchar(36) NOT NULL UNIQUE,
    FOREIGN KEY (device_id) references trackers_table(device_id),
    alert_distance smallint
);

CREATE Table tracker_requests(
    request_id varchar(36) PRIMARY KEY NOT NULL UNIQUE,
    issuer varchar(36),
    trackerId varchar(36),
    FOREIGN KEY (trackerId) references trackers_table(device_id),
    delivery_time timestamptz,
    received_time timestamptz,
    request jsonb,
    response jsonb
);
