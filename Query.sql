CREATE TABLE Tags (
    id INT IDENTITY PRIMARY KEY,
    tag_name VARCHAR,
    icon TEXT,
    created_at DATETIME, 
    updated_at DATETIME, 
    created_by UNIQUEIDENTIFIER, 
    updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Categories (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  parent_id UNIQUEIDENTIFIER,
  category_name VARCHAR,
  category_description TEXT,
  icon TEXT,
  image_path TEXT,
  active BIT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Staff_Accounts (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  phone_number VARCHAR(100),
  email VARCHAR,
  password_hash TEXT,
  active BIT,
  profile_image TEXT,
  registered_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Notifications(
  id UNIQUEIDENTIFIER,
  account_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Staff_Accounts(id),
  title VARCHAR(100),
  content TEXT,
  seen BIT,
  created_at DATETIME,
  recieve_time DATETIME,
  notification_expiry_date DATE
);

CREATE TABLE Variant_values(
  id UNIQUEIDENTIFIER,
  variant_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Variants(id),
  price NUMERIC,
  quantity INT
);

CREATE TABLE Product_tags(
  tag_id INTEGER FOREIGN KEY REFERENCES Tags(id),
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(id)
);

CREATE TABLE Product_categories(
  category_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Caregories(id),
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(id)
);

CREATE TABLE Staff_roles(
  staff_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Staff_Accounts(id),
  role_id INTEGER FOREIGN KEY REFERENCES Roles(id)
);

CREATE TABLE Slideshows(
  id UNIQUEIDENTIFIER,
  destination_url TEXT,
  image_url TEXT,
  clicks SMALLINT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Variants(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  variant_attribute_value_id UNIQUEIDENTIFIER,
  product_id UNIQUEIDENTIFIER
);

CREATE TABLE Products(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  product_name VARCHAR,
  SKU VARCHAR,
  regular_price NUMERIC,
  discount_price NUMERIC,
  quantity INTEGER,
  short_description VARCHAR(165),
  product_description TEXT,
  product_weight NUMERIC,
  product_note VARCHAR,
  published BIT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Roles(
  id INT IDENTITY(1,1) PRIMARY KEY,
  role_name VARCHAR,
  privilegas TEXT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Product_Shippings(
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(product_id),
  shipping_id INTEGER FOREIGN KEY REFERENCES Shippings(id),
  ship_charge NUMERIC,
  free BIT,
  estimated_days NUMERIC
);

CREATE TABLE Variant_attribute_values(
  variant_attribute_value_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Variants(variant_attribute_value_id),
  attribute_value_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Attribute_Values(id)
);

CREATE TABLE Product_attributes(
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(id),
  attribute_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Attributes(id)
);

CREATE TABLE Galleries(
  id UNIQUEIDENTIFIER,
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(product_id),
  image_path TEXT,
  thumbnail BIT,
  display_order SMALLINT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Sells(
  id UNIQUEIDENTIFIER,
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(product_id),
  price FLOAT,
  quantity SMALLINT
);

CREATE TABLE Card_Items(
  id UNIQUEIDENTIFIER,
  card_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Cards(card_id),
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(product_id),
  quantity SMALLINT
);

CREATE TABLE Shippings(
  id INTEGER IDENTITY(1,1) PRIMARY KEY,
  order_items_id INTEGER FOREIGN KEY REFERENCES Order_Items(shipping_id),
  name TEXT,
  active BIT,
  icon_path TEXT,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Attribute_Values(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  attribute_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Attributes(id),
  attribute_value VARCHAR,
  color VARCHAR(50)
);

CREATE TABLE Attributes(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  attribute_name VARCHAR,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Product_coupons(
  coupon_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Coupons(id),
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(id)
);

CREATE TABLE Order_Items(
  id UNIQUEIDENTIFIER,
  product_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Products(id),
  order_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Orders(id),
  price NUMERIC,
  quantity INTEGER,
  shipping_id INTEGER PRIMARY KEY
);

CREATE TABLE Orders(
  id UNIQUEIDENTIFIER PRIMARY KEY, 
  coupon_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Coupons(id),
  customer_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Customers(id),
  order_status_id INTEGER FOREIGN KEY REFERENCES Order_Statuses(id),
  order_approved_id DATETIME,
  order_delivered_carrier_date DATETIME,
  order_delivered_customer_date_ DATETIME,
  created_at DATETIME
);

CREATE TABLE Order_Status(
  id INTEGER PRIMARY KEY,
  status_name VARCHAR,
  color VARCHAR(50),
  privacy VARCHAR(50),
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Cards(
  card_id UNIQUEIDENTIFIER PRIMARY KEY,
  customer_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Customers(id)
);

CREATE TABLE Customer_Addrsses(
  id UNIQUEIDENTIFIER,
  customer_id UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Customers(id),
  address_line1 TEXT,
  address_line2 TEXT,
  postal_code VARCHAR,
  country VARCHAR,
  city VARCHAR,
  phone_number VARCHAR
);

CREATE TABLE Coupons(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  code VARCHAR,
  coupon_description TEXT,
  discount_value NUMERIC,
  discount_type VARCHAR(50),
  times_used INTEGER,
  max_usega INTEGER,
  coupon_start_date DATETIME,
  coupon_end_date DATETIME,
  created_at DATETIME,
  updated_at DATETIME,
  created_by UNIQUEIDENTIFIER,
  updated_by UNIQUEIDENTIFIER
);

CREATE TABLE Customers(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  phone_number VARCHAR,
  email TEXT,
  password_hash TEXT,
  active BIT,
  registered_at DATETIME,
  created_at DATETIME
);
