DROP TABLE device_log;
DROP TABLE tracking_device;
DROP TABLE "user";

CREATE Table users(
	id char(36) PRIMARY KEY NOT NULL UNIQUE,
	username varchar(15) NOT NULL,
	email varchar(50) NOT NULL UNIQUE,
	phone varchar(10) NOT NULL,
	password varchar(80) NOT NULL
);

CREATE Table trackers(
	id char(36) PRIMARY KEY NOT NULL UNIQUE,
	tkrname varchar(15) NOT NULL,
	phone varchar(10) NOT NULL,
	user_id char(36) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE Table boundary
(
    id CHAR(36) PRIMARY KEY NOT NULL UNIQUE,
    tracker_id CHAR(36) NOT NULL,
    FOREIGN KEY (tracker_id) references trackers(id) ON DELETE CASCADE,
    time_start timestamptz NOT NULL,
    time_end timestamptz NOT NULL,
    lat float(24) NOT NULL,
    lng float(24) NOT NULL,
    radius smallint NOT NULL
);

CREATE Table tracker_requests
(
	request_id varchar(36) PRIMARY KEY NOT NULL UNIQUE,
	issuer varchar(36),
	trackerId varchar(36),
	FOREIGN KEY (trackerId) references trackers(id),
	delivery_time timestamptz,
	received_time timestamptz,
	request jsonb,
	response jsonb
);
