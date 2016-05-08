CREATE USER sakila_dv IDENTIFIED BY 'sakila_dv';
GRANT ALL PRIVILEGES ON sakila_data_vault.* TO sakila_dv;
