-- Table: public.items

-- DROP TABLE IF EXISTS public.items;

CREATE TABLE IF NOT EXISTS public.items
(
    item_id integer NOT NULL,
    item_name character varying(128) COLLATE pg_catalog."default" NOT NULL,
    item_description character varying(240) COLLATE pg_catalog."default",
    item_image character varying(360) COLLATE pg_catalog."default",
    item_price character varying(12) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT items_pkey PRIMARY KEY (item_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.items
    OWNER to postgres;