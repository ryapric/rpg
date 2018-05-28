EXTENSION = postgres_qol
DATA = postgres_qol--0.1.sql
# REGRESS = postgress_qol_test

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
