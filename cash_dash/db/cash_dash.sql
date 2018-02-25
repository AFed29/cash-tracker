DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE transactions (
  id SERIAL8 PRIMARY KEY,
  amount INT4 NOT NULL,
  category_id INT4 REFERENCES categories(id),
  merchant_id INT4 REFERENCES merchants(id)
)
