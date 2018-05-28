EXTENSION = pg_qol
DATA = pg_qol--0.1.sql
# REGRESS = pg_qol_test

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
