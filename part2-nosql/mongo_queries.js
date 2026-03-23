// OP1: insertMany()
db.products.insertMany([
  {
    product_id: "E001",
    name: "Smartphone X",
    category: "Electronics",
    price: 25000,
    brand: "Samsung",
    specs: {
      warranty_years: 2,
      battery: "5000mAh",
      voltage: "220V"
    }
  },
  {
    product_id: "C001",
    name: "Men's Jacket",
    category: "Clothing",
    price: 3000,
    brand: "Zara",
    sizes: ["S", "M", "L", "XL"],
    material: "Leather"
  },
  {
    product_id: "G001",
    name: "Milk Pack",
    category: "Groceries",
    price: 60,
    brand: "Amul",
    expiry_date: "2024-12-30",
    nutrition: {
      calories: 150,
      protein: "8g"
    }
  }
]);

// OP2: find Electronics with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: "2025-01-01" }
});

// OP4: updateOne() add discount_percent
db.products.updateOne(
  { product_id: "E001" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex()
db.products.createIndex({ category: 1 });
