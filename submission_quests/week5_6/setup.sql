DROP DATABASE IF EXISTS internet_tv;
CREATE DATABASE IF NOT EXISTS internet_tv;
USE internet_tv;


DROP TABLE IF EXISTS channels,
                     program_slots,
                     programs,
                     program_schedules,
                     genres,
                     program_genre,
                     seasons,
                     episodes,
                     view_counts;

CREATE TABLE channels (
    PRIMARY KEY (channel_id),
    channel_id             SMALLINT UNSIGNED  NOT NULL AUTO_INCREMENT,
    channel_name           VARCHAR(50)        NOT NULL UNIQUE
);

CREATE TABLE program_slots (
    PRIMARY KEY (program_slot_id),
    program_slot_id        BIGINT UNSIGNED    NOT NULL AUTO_INCREMENT,
    channel_id             SMALLINT UNSIGNED  NOT NULL,
    start_time             DATETIME           NOT NULL,
    end_time               DATETIME           NOT NULL,
    FOREIGN KEY (channel_id)      REFERENCES channels(channel_id) ON DELETE CASCADE
);

CREATE TABLE programs (
    PRIMARY KEY (program_id),
    program_id             BIGINT UNSIGNED    NOT NULL AUTO_INCREMENT,
    program_title          VARCHAR(100)       NOT NULL,
    program_detail         TEXT               NOT NULL
);

CREATE TABLE program_schedules (
    PRIMARY KEY (program_schedule_id),
    program_schedule_id    BIGINT UNSIGNED    NOT NULL AUTO_INCREMENT,
    program_id             BIGINT UNSIGNED    NOT NULL,
    program_slot_id        BIGINT UNSIGNED    NOT NULL,
    FOREIGN KEY (program_id)      REFERENCES programs(program_id) ON DELETE CASCADE,
    FOREIGN KEY (program_slot_id) REFERENCES program_slots(program_slot_id) ON DELETE CASCADE
);

CREATE TABLE genres (
    PRIMARY KEY (genre_id),
    genre_id               SMALLINT UNSIGNED  NOT NULL AUTO_INCREMENT,
    genre_name             VARCHAR(50)        NOT NULL UNIQUE
);

CREATE TABLE program_genre (
    PRIMARY KEY (program_id, genre_id),
    program_id             BIGINT UNSIGNED    NOT NULL,
    genre_id               SMALLINT UNSIGNED       NOT NULL,
    FOREIGN KEY (program_id)      REFERENCES programs(program_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id)        REFERENCES genres(genre_id) ON DELETE CASCADE
);

CREATE TABLE seasons (
    PRIMARY KEY (season_id),
    season_id              INT UNSIGNED       NOT NULL AUTO_INCREMENT,
    program_id             BIGINT UNSIGNED    NOT NULL,
    season_number          INT UNSIGNED,
    FOREIGN KEY (program_id)      REFERENCES programs(program_id) ON DELETE CASCADE
);

CREATE TABLE episodes (
    PRIMARY KEY (episode_id),
    episode_id             INT UNSIGNED       NOT NULL AUTO_INCREMENT,
    program_id             BIGINT UNSIGNED       NOT NULL,
    season_id              INT UNSIGNED,
    episode_number         INT UNSIGNED,
    episode_title          VARCHAR(100)       NOT NULL,
    episode_detail         TEXT               NOT NULL,
    duration               TIME               NOT NULL,
    release_date           DATE               NOT NULL,
    FOREIGN KEY (program_id)      REFERENCES programs(program_id) ON DELETE CASCADE,
    FOREIGN KEY (season_id)       REFERENCES seasons(season_id) ON DELETE CASCADE
    );

CREATE TABLE view_counts (
    PRIMARY KEY (view_count_id),
    view_count_id          INT UNSIGNED       NOT NULL AUTO_INCREMENT,
    episode_id             INT UNSIGNED       NOT NULL,
    program_slot_id        BIGINT UNSIGNED    NOT NULL,
    view_count             BIGINT UNSIGNED    NOT NULL DEFAULT 0,
    FOREIGN KEY (episode_id)      REFERENCES episodes(episode_id) ON DELETE CASCADE,
    FOREIGN KEY (program_slot_id) REFERENCES program_slots(program_slot_id) ON DELETE CASCADE
);
