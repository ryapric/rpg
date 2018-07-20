EXTENSION = rpg
DATA = rpg--0.1.sql
# REGRESS = rpg_test

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
