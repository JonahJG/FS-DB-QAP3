-- Table: public.sales

-- DROP TABLE IF EXISTS public.sales;

CREATE TABLE IF NOT EXISTS public.sales
(
    sale_id integer NOT NULL,
    item_id integer NOT NULL,
    sell_price integer,
    sell_time date,
    amt_sold integer,
    total_price integer NOT NULL,
    CONSTRAINT sales_pkey PRIMARY KEY (sale_id),
    CONSTRAINT "itemID" FOREIGN KEY (item_id)
        REFERENCES public.items (item_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sales
    OWNER to postgres;