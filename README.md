# Challenge_1_mobile_store_maker

## Group4 Members

1290162    Kuttin, Samuel Elliot -> Investigate Shoppify / Wireframe 
1276906    Lee, Wei-An -> Documenation
1255561    Lian, Tianhua -> Home Page
1273233    Lin, Tzu-Hsuan -> Order List Page
1266613    Lin, Zhixiang -> Product List Page
1307010    Liu, Jun -> MVVM Architecture
1267834    Liu, Yingqi -> Add / Edit Product
1271467    Mahirwe, Yves Byukusenge -> Depedency Injection
1275569    Mehta, Manav Samirbhai -> Add/Edit Order
1275544    Naeem, Muhammad Nouman -> UIUX


**GitHub Project Link**
https://github.com/TzuHsuanLin-127322/Comp5450Challenge1

---

## Project Description

This app was developed as part of Group 4's challenge for the Comp-5450-SA 2025 course:
“A framework for building mobile stores (like Shopify)”

Our project simulates an e-commerce application framework modeled after Shopify. It includes product management and order management with simple navigation, suitable for further expansion into an action store with more features.

---

## App Structure & Features

### Main Page
- Bottom navigation bar to switch between Product Page and Order Page
- Displays a summary dashboard for total number of products and orders

### Product Page
- If no products exist → show “Add Product” button
- If products exist → display product cards
- Each product supports edit/remove functionality

### Add/Edit Product Page
- Enter product title
- Upload/select product image
- Set product price

### Order Page
- If no orders → show “Add Order” button
- If orders exist → display list of orders with floating action button to add new
- Supports selecting orders for edit/remove

### Add/Edit Order Page
- Fill in customer information
- Select product from list
- Input final price
- Select order status

---

## How to Configure & Run

1. **Install Flutter SDK**  
   ➤ [Flutter install guide](https://docs.flutter.dev/get-started/install)  
   ➤ Check with: `flutter doctor`

2. **Clone Project from GitHub**
   bash
   git clone https://github.com/TzuHsuanLin-127322/Comp5450Challenge1.git
   cd Comp5450Challenge1

3. **Install Dependencies**
   flutter pub get

4. **Run the App**
 On Android/iOS Emulator:
    flutter run
 On Chrome (Web):
    flutter run -d chrome

**Project File Structure**
Comp5450Challenge1/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   └── pages/
│       ├── main_page.dart
│       ├── product_page.dart
│       ├── edit_product_page.dart
│       ├── order_page.dart
│       └── edit_order_page.dart
├── pubspec.yaml
└── README.md

**Screenshots**




**Notes**
----------------------------------------
- Developed in Android Studio with Flutter 3.x SDK
- Compatible with Android, iOS, and Web
- Challenge submitted as part of Comp-5450-SA 2025
