# 🏠 Flutter Restaurant Demo App

<p align="center">
  <img src="https://bcoder24.s3-accelerate.amazonaws.com/piya/1760519694124~Screenshot1.jpg" alt="App Preview" width="350" />
</p>

A Flutter demo project built using **Dart**, **GetX** for state management, and **Dio** for API integration.  
This app displays a list of restaurants retrieved from an API and showcases clean architecture and reactive UI design.

---

## 🚀 Overview

This project demonstrates how to:

- Fetch data from REST APIs using Dio  
- Manage app state using GetX  
- Display restaurant data (name, address, rating, etc.) in a ListTile-based UI  
- Structure a scalable Flutter project following best practices  

---

## 🛠️ Tech Stack

| Category           | Technology               |
|--------------------|--------------------------|
| Framework          | Flutter                  |
| Language           | Dart                     |
| State Management   | GetX                     |
| Networking         | Dio                      |
| Architecture       | MVC pattern (GetX-based) |

---

## 📂 Project Structure

```plaintext
flutter_app/
├── lib/
│   ├── app/
│   │   ├── data/
│   │   │   ├── models/          # Data models (e.g., RestaurantModel)
│   │   │   └── providers/       # API providers/clients (e.g., ApiClient)
│   │   ├── modules/
│   │   │   ├── home_module/     # Feature module (e.g., home screen)
│   │   │   │   ├── bindings/    # GetX bindings
│   │   │   │   ├── controllers/ # GetX controllers (logic)
│   │   │   │   └── views/       # UI screens/widgets
│   │   └── routes/
│   │       ├── app_pages.dart   # Route definitions
│   │       └── app_routes.dart  # Route names
│   ├── core/
│   │   └── Assets.dart          # Centralized asset path management
│   └── main.dart                # Application entry point
└── pubspec.yaml                 # Project dependencies and asset declarations

