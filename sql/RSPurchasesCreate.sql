-- Table: public.purchases

-- DROP TABLE IF EXISTS public.purchases;

CREATE TABLE IF NOT EXISTS public.purchases
(
    purchase_id integer NOT NULL DEFAULT nextval('purchases_purchase_id_seq'::regclass),
    item_id integer,
    buy_price integer,
    amt_bought integer,
    total_cost integer,
    buy_time date,
    sale_id integer DEFAULT nextval('purchases_sale_id_seq'::regclass),
    CONSTRAINT purchases_pkey PRIMARY KEY (purchase_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.purchases
    OWNER to postgres;