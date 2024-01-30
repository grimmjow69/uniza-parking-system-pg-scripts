-- Table: public.parking_spots

-- DROP TABLE IF EXISTS public.parking_spots;

CREATE TABLE IF NOT EXISTS public.parking_spots
(
    parking_spot_id integer NOT NULL DEFAULT nextval('parking_spots_parking_spot_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    occupied boolean NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT parking_spots_pkey PRIMARY KEY (parking_spot_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.parking_spots
    OWNER to postgres;

--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    user_id integer NOT NULL DEFAULT nextval('users_user_id_seq'::regclass),
    username character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    profile_photo bytea,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    favourite_spot_id integer,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
    CONSTRAINT fk_favourite_spot_id FOREIGN KEY (favourite_spot_id)
        REFERENCES public.parking_spots (parking_spot_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;

--------------------------------------------------------------------------

-- Table: public.parking_spot_histories

-- DROP TABLE IF EXISTS public.parking_spot_histories;

CREATE TABLE IF NOT EXISTS public.parking_spot_histories
(
    id integer NOT NULL DEFAULT nextval('parking_spot_histories_id_seq'::regclass),
    parking_spot_id integer NOT NULL,
    occupied boolean,
    occupied_since timestamp with time zone,
    CONSTRAINT fk_spot_id FOREIGN KEY (parking_spot_id)
        REFERENCES public.parking_spots (parking_spot_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.parking_spot_histories
    OWNER to postgres;

--------------------------------------------------------------------------

-- Table: public.notifications

-- DROP TABLE IF EXISTS public.notifications;

CREATE TABLE IF NOT EXISTS public.notifications
(
    notification_id integer NOT NULL DEFAULT nextval('notifications_notification_id_seq'::regclass),
    parking_spot_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT fk_spot_id FOREIGN KEY (parking_spot_id)
        REFERENCES public.parking_spots (parking_spot_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.notifications
    OWNER to postgres;

--------------------------------------------------------------------------

-- Table: public.ratings

-- DROP TABLE IF EXISTS public.ratings;

CREATE TABLE IF NOT EXISTS public.ratings
(
    id integer NOT NULL DEFAULT nextval('ratings_id_seq'::regclass),
    user_id integer NOT NULL,
    parking_spot_id integer NOT NULL,
    rating smallint NOT NULL,
    comment character varying(255) COLLATE pg_catalog."default",
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT fk_spot_id FOREIGN KEY (parking_spot_id)
        REFERENCES public.parking_spots (parking_spot_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.ratings
    OWNER to postgres;
