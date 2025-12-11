import os
import requests

ACCESS_KEY = "7rL1ziMoz0QVc_bwCE6XJFT141OqG7jN9KDVGzCLR58"

products = [
    "Laptop", "Smartphone", "Headphones", "Smartwatch", "Bluetooth Speaker", 
    "Tablet", "Gaming Console", "Camera", "Monitor", "Keyboard",
    "T-Shirt", "Jeans", "Jacket", "Sneakers", "Hoodie", 
    "Dress", "Shorts", "Sweater", "Socks", "Cap",
    "Coffee Maker", "Microwave Oven", "Blender", "Vacuum Cleaner", "Toaster",
    "Air Fryer", "Cookware Set", "Electric Kettle", "Iron", "Dish Rack",
    "Running Shoes", "Yoga Mat", "Bicycle", "Tent", "Backpack",
    "Water Bottle", "Dumbbell Set", "Tennis Racket", "Camping Stove", "Sleeping Bag"
]

os.makedirs("./images", exist_ok=True)

for product in products:
    query = product.replace(" ", "+")
    url = f"https://api.unsplash.com/search/photos?query={query}&per_page=1&client_id={ACCESS_KEY}"
    r = requests.get(url).json()
    if r["results"]:
        image_url = r["results"][0]["urls"]["regular"]
        img_data = requests.get(image_url).content
        filename = f"images/{product}.jpg"
        with open(filename, "wb") as f:
            f.write(img_data)
        print(f"✅ Downloaded: {product}")
    else:
        print(f"❌ No image found for: {product}")
