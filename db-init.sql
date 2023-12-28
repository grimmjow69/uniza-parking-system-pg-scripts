CREATE DATABASE uniza-parking-system


-- Table: public.parking_lot

-- DROP TABLE IF EXISTS public.parking_lot;

CREATE TABLE IF NOT EXISTS public.parking_lot
(
    spot_id integer NOT NULL DEFAULT nextval('parking_lot_id_seq'::regclass),
    spot_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
    occupied boolean NOT NULL,
    updated_at timestamp with time zone,
    CONSTRAINT parking_lot_pkey PRIMARY KEY (spot_id)
)

-- Table: public.user

-- DROP TABLE IF EXISTS public."user";

CREATE TABLE IF NOT EXISTS public."user"
(
    user_id integer NOT NULL DEFAULT nextval('user_user_id_seq'::regclass),
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    password_hash character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    profile_photo bytea,
    favorite_spot_id integer,
    CONSTRAINT user_pkey PRIMARY KEY (user_id),
    CONSTRAINT favourite_spot_id_fk FOREIGN KEY (favorite_spot_id)
        REFERENCES public.parking_lot (spot_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

-- Table: public.notification

-- DROP TABLE IF EXISTS public.notification;

CREATE TABLE IF NOT EXISTS public.notification
(
    notification_id integer NOT NULL DEFAULT nextval('notification_notification_id_seq'::regclass),
    spot_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT notification_pkey PRIMARY KEY (notification_id),
    CONSTRAINT spot_id_fk FOREIGN KEY (spot_id)
        REFERENCES public.parking_lot (spot_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_id_fk FOREIGN KEY (user_id)
        REFERENCES public."user" (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)





