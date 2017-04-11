CREATE EXTENSION "uuid-ossp";

CREATE TABLE product (
  id uuid,
  lookupcode varchar(32) NOT NULL DEFAULT(''),
  quantity int NOT NULL DEFAULT(0),
  salable boolean NOT NULL DEFAULT('TRUE'),
  price money NOT NULL DEFAULT(0.00),  
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_product_lookupcode
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default");

CREATE TABLE employee (
  id uuid NOT NULL,
  employeeid character varying(32) NOT NULL DEFAULT(''),
  firstname character varying(128) NOT NULL DEFAULT(''),
  lastname character varying(128) NOT NULL DEFAULT(''),
  password character varying(512) NOT NULL DEFAULT(''),
  active boolean NOT NULL DEFAULT(FALSE), 
  classification int NOT NULL DEFAULT(0),
  managerid uuid NOT NULL,
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT employee_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_employee_employeeid
  ON employee
  USING hash(employeeid);
  
--CREATE TYPE transaction_type AS ENUM ('sale', 'return');


//cgmcname ~1.5 hours worked on


CREATE TABLE transaction2 (
        id uuid,
	transid uuid NOT NULL,
	itemnum int NOT NULL,
	createdon timestamp without time zone NOT NULL DEFAULT now(),
	productid uuid NOT NULL,
	productnum int NOT NULL DEFAULT (1),
	CONSTRAINT transaction2_pkey PRIMARY KEY (id),
	CONSTRAINT productid_key FOREIGN KEY (productid)
		REFERENCES product (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
			
)	WITH (
	OIDS=FALSE
);


CREATE TABLE transaction1 (
	id uuid NOT NULL,
	cashierid uuid NOT NULL,
	total money NOT NULL DEFAULT 0.00,
	transtype varchar(8) NOT NULL DEFAULT('sale'),
	referenceid uuid NOT NULL,
	createdon timestamp without time zone NOT NULL DEFAULT(now()),
	CONSTRAINT transaction1_pkey PRIMARY KEY (recordid),
 	CONSTRAINT transaction1_employee_fkey FOREIGN KEY (cashierid)
		REFERENCES employee (id) MATCH SIMPLE 
		ON UPDATE NO ACTION ON DELETE NO ACTION, 
	CONSTRAINT transaction1_tran2_fkey FOREIGN KEY (referenceid)
		REFERENCES transaction2 (transid) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION, 
	CONSTRAINT type_check CHECK (transtype IN ('sale', 'return'))
)	WITH (
	OIDS=FALSE
);



INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 100
     , 'TRUE'
     , 19.99
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode2'
     , 125
     , 'FALSE'
     , 2000.99
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode3'
     , 150
     , 'TRUE'
     , 400
     , current_timestamp
);
