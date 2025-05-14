# Challenge_1_mobile_store_maker

## Group 4 Members
-1290162    Kuttin, Samuel Elliot -> Investigate Shopify / Wireframe 
-1276906    Lee, Wei-An -> Documentation 
-1255561    Lian, Tianhua -> Home Page 
-1273233    Lin, Tzu-Hsuan -> Order List Page 
-1266613    Lin, Zhixiang -> Product List Page 
-1307010    Liu, Jun -> MVVM Architecture 
-1267834    Liu, Yingqi -> Add / Edit Product 
-1271467    Mahirwe, Yves Byukusenge -> Dependency Injection 
-1275569    Mehta, Manav Samirbhai -> Add/Edit Order 
-1275544    Naeem, Muhammad Nouman -> UIUX

**GitHub Project Link** 
[https://github.com/TzuHsuanLin-127322/Comp5450Challenge1](https://github.com/TzuHsuanLin-127322/Comp5450Challenge1)


## Project Description
This app was developed as part of Group 4's challenge for the Comp-5450-SA 2025 course: “A framework for building mobile stores (like Shopify)”

Our project simulates an e-commerce application framework modelled after Shopify. It includes product management and order management with simple navigation, suitable for further expansion into an action store with more features.

## 🔗 Wireframe (Miro)
[Click here to view our design on Miro](https://miro.com/app/board/uXjVI4bQr3Y=/?share_link_id=476837536289)






## App Structure & Features
### Main Page
Users can quickly find products, monitor sales, store summary, and spot pending orders. Everything on the Home page is powered by real-time order and product data. 
Header Bar: Store button to open settings drawer, store name, alerts icon button to open alert page.
Bottom Navigation Bar: Switch between Home Page, Product Page, Order Page and open Menus overlay sheet.
Scrollable Body:
Search Bar to open the Search page.
Sales Dashboard Card displays an interactive sales chart to show sales trends over different timeframes.
Filter chips (Today, Yesterday, This Week, This Month). 
Summary text showing the period’s total sales and orders.
Line chart of sales over time (hours or days).
Messages Panel shows the number of pending orders or “All caught up!” if there is no pending order. Clicking on the panel opens the Order page.
Store Summary Card for total sales and total number of products and orders.
Recently Sold Product Grid shows a responsive grid (2-column for phone, 4-column for wider screen) of product cards (image thumbnail + name + price).
### Product Page
This section documents the UI screens and core logic that make up the Product feature set.
Search Bar: Real-time search that filters the product list as the user types a name.
Product List:
Each item displays a thumbnail (80×80), product name, and price
Rounded thumbnail corners (8 px), image auto-cropped to fit
Long names wrap automatically or show ellipsis if too long
Popup Menu:
Edit: Opens the Edit Product page
Delete: Removes the selected product from the list
Floating Action Button: A “＋” button at the bottom-right corner to add a new product.
Empty-State Prompt: If the list is empty, a centered “Add product” button encourages users to create their first item.
### Add/Edit Product Page
Enter product title
The title is entered via a text field in the ProductFormPage.
Changes to the title are handled in real-time by the ProductViewModel.
The title is validated and synced with the Product model.
Upload/select product image
Users can upload or select images using the ImagePicker.
Users can add new images or remove existing ones.
Images are stored as file paths and displayed in a grid.
Set product price
Users can enter both the product price and compare price
The price fields ensure valid numeric inputs.
### Order Page
If no orders → show “Add Order” button
If orders exist → display a list of orders with a floating action button to add new
Supports selecting orders for edit/remove
### Add/Edit Order Page
Fill in customer information
Select product from list
Input final price
Select order status


## How to Configure & Run
### Install Flutter SDK
➤ Flutter install guide
➤ Check with: flutter doctor

### Clone Project from GitHub 
```bash
git clone https://github.com/TzuHsuanLin-127322/Comp5450Challenge1.git
cd Comp5450Challenge1
```

### Install Dependencies 
```bash
flutter pub get
```

### Run the App 
➤On Android/iOS Emulator: flutter run 
➤On Chrome (Web): flutter run -d chrome

## Project File Structure 
```plaintext
lib
├── data
│   ├── repository
│   │   └── order_repository.dart
│   └── services
│   	├── mock_order_service.dart
│   	└── order_service.dart
├── main.dart
├── model
│   ├── base
│   │   └── http_service_result.dart
│   ├── bill_item_model.dart
│   ├── cart_model.dart
│   ├── cart_product_model.dart
│   ├── currency_model.dart
│   ├── customer_info_model.dart
│   ├── fakeData
│   │   └── fake_order_list_model.dart
│   ├── order_list_model.dart
│   ├── order_model.dart
│   └── product_model.dart
├── providers
│   └── cart_provider.dart
├── services
│   ├── order_service.dart
│   └── product_service.dart
├── ui
│   ├── edit_products
│   │   ├── add_product_page.dart
│   │   ├── edit_product_page.dart
│   │   ├── product_form_page.dart
│   │   └── product_view_model.dart
│   ├── home_view_model.dart
│   ├── main_page.dart
│   ├── orders
│   │   ├── orderDetail
│   │   │   ├── order_detail_page.dart
│   │   │   └── order_detail_view_model.dart
│   │   ├── orders_page.dart
│   │   └── orders_view_model.dart
│   ├── others
│   │   ├── add_store_page.dart
│   │   ├── alerts_page.dart
│   │   ├── dashboard_page.dart
│   │   └── search_page.dart
│   ├── products
│   │   ├── product_list_page.dart
│   │   └── product_list_view_model.dart
│   └── widgets
│   	├── dashboard_card.dart
│   	├── menu_sheet.dart
│   	└── settings_drawer.dart
└── utils
	├── api_status.dart
	└── string_formatter.dart
```
