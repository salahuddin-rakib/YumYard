# README

These steps needs to follow to run and operate this project.

Things you need to follow:

## 1. Installation:

****
** You can skip this part if you already have ruby 3.2.2 and rails 7 installed in you machine. **

You need to install ruby programming language, Ruby on Rails and Postgresql Database.
For windows pc you can follow https://gorails.com/setup/windows/11. For ubuntu pc you
can follow https://gorails.com/setup/ubuntu/22.04. For macOS you can follow
https://gorails.com/setup/macos/13-ventura. Note: You have to install ruby 3.2.2 and rails
7 version for this project. You also need to configure postgresql to make it runnable.
****

## 2. Configuration:

****

### 2.1 Server running port configuration:

****

** You can skip this part if you don't want to change rails server running port. **

When we will run rails server by default it will run on 4000 post. You can change port by following these steps.

* Go to `./YumYard/config/puma.rb` file.
* See there is a line `port ENV.fetch("PORT") { 4000 }`. Change `port ENV.fetch("PORT") { 4000 }`
  to `port ENV.fetch("PORT") { your_specific_port_number }`.

****

### 2.2 Configuration for database:

****
You need to create a super admin in postgres. Then:

* Go to `./YumYard/config/database.yml` file.
* Change `your_postgresql_username` and `your_postgresql_password` with your postgres super admin `username`
  and `password`.

****
****

## 3. Database creation:

****
Go to the project folder(`YumYard`) in terminal. After that run `rails db:create:all` command.
****

## 3. Run rails server:

****
Go to the project folder(`YumYard`) in terminal. After that run `rails s` command. That's it, your rails server will
run.
****

## 4. Run test suite:

****
To run test suite just run `rspec spec` in the project folder terminal.
****

# API docs:

`base_url:` http://localhost:4000

## 1. Food APIs:

****
1.1 **Get foods:** `base_url/foods`

*** **Note:** I have added pagination and filter capabilities in this API. ***

**Params for pagination and filter:**
```
{
  "page": 0,                      // By default 0
  "per_page": 20,                 // By default 10
  "name": "ros",                  // Case insensitive search.
  "price": 700,
  "price_compare_operator": ">",  // The value will be among ["<", "=", ">"]
  "category": "dessert"           // The value will be among ['appetizer', 'main_course', 'dessert'].
}
```

**Method:** `GET`

**Response:**

status_code: `200`
```
{
  "message": "Successfully fetched food list.",
  "foods": [
    {
      "id": 1,
      "name": "Sweet",
      "image_url": "https://m.recipes.timesofindia.com/photo/96538839/96538839.jpg",
      "stock_quantity": 100,
      "price": "1000.0",
      "category": "dessert"
    }
  ],
  "total": 1
}
```
****
1.2 **Create a food:** `base_url/foods`

**Method:** `POST`

**Request body:**
```
{
  "name": "Rosogolla",
  "image_url": "https://m.recipes.timesofindia.com/photo/96538839/96538839.jpg",
  "stock_quantity": 100,
  "price": 700,
  "category": "dessert"  // The value will be among ['appetizer', 'main_course', 'dessert'].
}
```

**Response:**

status_code: `201`
```
{
    "message": "Successfully created food."
}
```
****
1.3 **Update a food:** `base_url/foods`

**Method:** `PUT`

**Request body:**
```
{
  "name": "Rosogolla",
  "image_url": "https://m.recipes.timesofindia.com/photo/96538839/96538839.jpg",
  "stock_quantity": 500,
  "price": 700,
  "category": "dessert"  // The value will be among ['appetizer', 'main_course', 'dessert'].
}
```

**Response:**

status_code: `200`
```
{
    "message": "Successfully updated food."
}
```
****

## 2. Coupon APIs:

****
2.1 **Create a Coupon:** `base_url/coupons`

**Method:** `POST`

**Request body:**
```
{
  "food_id": 3,
  "offer_amount": 300
}
```

**Response:**

status_code: `201`
```
{
    "message": "Successfully created coupon.",
    "coupon": {
        "id": 2,
        "food_id": 1,
        "status": "active",
        "token": "nSmNGxNb",
        "offer_amount": 250,
        "expires_at": "2023-08-12T11:35:30.931Z",
        "created_at": "2023-08-12T11:33:30.931Z",
        "updated_at": "2023-08-12T11:33:30.931Z"
    }
}
```
****
2.2 **Delete a Coupon:** `base_url/coupons/:id`

**Method:** `DELETE`

**Response:**

status_code: `200`
```
{
    "message": "Successfully deleted coupon."
}
```
****


## 3. Order APIs:

****
3.1 **Create a Order:** `base_url/api/:food_id/process_order`

**Method:** `POST`

**Request body:**
```
{
  "price": 700,
  "total_ordered": 10,
  "coupon_token": "jPIScdBr"
}
```

**Response:**

status_code: `200`
```
{
    "message": "Order placed successfully."
}
```
****