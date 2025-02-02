/* drop tables in reverse order of creating */

DROP TABLE rsvps;
DROP TABLE events;
DROP TABLE groups;
DROP TABLE members;
DROP TABLE venues;

CREATE TABLE venues (
  id_venue BIGINT primary key NULL,
  name VARCHAR(100)  NULL,
  address_1 VARCHAR(200)  NULL,
  address_2 VARCHAR(200)  NULL,
  phone VARCHAR(100)  NULL,
  lon FLOAT  NULL,
  lat FLOAT  NULL,
  zip VARCHAR(10)  NULL,
  city VARCHAR(50)  NULL,
  state VARCHAR(50)  NULL,
  country VARCHAR(50)  NULL,
  repinned BOOLEAN  NULL
);
CREATE TABLE members (
  id_member VARCHAR(20) primary key NULL,
  /* belongs to many groups!!! should be a separate table!! */
  id_group VARCHAR(20)  NULL,
  /* core member attributes */
  name VARCHAR(100)  NULL,
  bio VARCHAR(500)  NULL,
  visited BIGINT  NULL,
  joined BIGINT  NULL,
  link VARCHAR(100)  NULL,
  /* location */
  city VARCHAR(100)  NULL,
  lon FLOAT  NULL,
  lat FLOAT  NULL,
  state VARCHAR(100)  NULL,
  country VARCHAR(100)  NULL,
  hometown VARCHAR(100)  NULL,
  /* photo */
  id_photo FLOAT  NULL,
  link_photo VARCHAR(100)  NULL,
  thumb_link_photo VARCHAR(100)  NULL,
  highres_link_photo VARCHAR(100)  NULL
);
CREATE TABLE groups (
  id_group VARCHAR(30) primary key NOT NULL,
  /* has one organizer */
  id_organizer VARCHAR(30) references members(id_member) NOT NULL,  
  name_organizer VARCHAR(100)  NULL,
  /* is in one category */
  id_category BIGINT  NULL,
  name_category VARCHAR(100)  NULL,
  shortname_category VARCHAR(100)  NULL,
  /* core group attributes */
  name VARCHAR(100)  NULL,
  description VARCHAR(100)  NULL,
  link VARCHAR(100)  NULL,
  who VARCHAR(100)  NULL,
  join_mode VARCHAR(100)  NULL,
  created TIMESTAMP NULL,
  created_wday SMALLINT  NULL,
  urlname VARCHAR(250)  NULL,
  visibility VARCHAR(20)  NULL,
  /* attributes that change over time */
  no_members INT NULL,
  rating FLOAT NULL,
  /* location */
  city VARCHAR(100)  NULL,
  lat FLOAT  NULL,
  lon FLOAT  NULL,
  state VARCHAR(100)  NULL,
  country VARCHAR(100)  NULL,
  timezone VARCHAR(100)  NULL
);
CREATE TABLE events (
  id_event VARCHAR(30) primary key NULL,
  /* belongs to one group */
  id_group VARCHAR(30) REFERENCES groups(id_group) NOT NULL,
  /* has one venue */
  id_venue BIGINT REFERENCES venues(id_venue) NOT NULL,
  /* core event attributes */
  name VARCHAR(100)  NULL,
  description VARCHAR(500)  NULL,
  time TIMESTAMP NULL,
  time_wday SMALLINT  NULL,
  utc_offset SMALLINT  NULL,
  event_url VARCHAR(150)  NULL,
  duration FLOAT  NULL,
  status VARCHAR(100)  NULL,
  why VARCHAR(260)  NULL,
  how_to_find_us VARCHAR(250)  NULL,
  rating FLOAT  NULL,
  venue_visibility VARCHAR(30)  NULL,
  created TIMESTAMP NULL,
  created_wday SMALLINT  NULL,
  updated TIMESTAMP  NULL,
  photo_url VARCHAR(250)  NULL,
  /* fee */
  label_fee VARCHAR(100)  NULL,
  amount_fee FLOAT  NULL,
  accepts_fee VARCHAR(20)  NULL,
  currency_fee VARCHAR(100)  NULL,
  description_fee VARCHAR(100)  NULL,
  required_fee VARCHAR(100)  NULL,
  /* counts */
  yes_rsvp_count INT  NULL,
  waitlist_count INT  NULL,
  maybe_rsvp_count INT  NULL,
  count_rating INT  NULL,
  average_rating FLOAT  NULL,
  headcount BIGINT  NULL
);
COMMENT ON COLUMN events.duration IS 'Event duration in milliseconds';
COMMENT ON COLUMN events.why IS 'We should do this because...';
COMMENT ON COLUMN events.venue_visibility IS 'Controls the visibility of venue. May be one of "public" or "members"';


CREATE TABLE rsvps (
  rsvp_id BIGINT primary key NULL,
  /* this is a join table between member and event */
  id_member VARCHAR(30) REFERENCES members (id_member),
  id_event VARCHAR(30) REFERENCES events (id_event),
  /* core attributes */
  response VARCHAR(20)  NULL,
  watching BOOLEAN  NULL,
  comments VARCHAR(250)  NULL,
  guests BIGINT  NULL,
  /* time */
  created TIMESTAMP NULL,
  created_time TIME  NULL,
  created_wday SMALLINT  NULL,
  mtime TIMESTAMP NULL,
  mtime_time TIME NULL,
  mtime_wday SMALLINT  NULL
);
