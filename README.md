# VSKY Fullstack Restaurant Demo

A comprehensive fullstack restaurant management system demonstrating modern web and mobile development practices. This project showcases a complete technology stack including backend APIs, web frontend, mobile application, and database integration.

## 🚀 Project Overview

The VSKY Fullstack Demo is a restaurant management platform that allows users to:
- Browse and manage restaurant information
- Handle menu items and orders
- Real-time order processing via MQTT
- Cross-platform mobile access via Flutter
- Modern React-based web interface

## 🏗️ Architecture

This project follows a modern fullstack architecture with clear separation of concerns:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Flutter App   │    │  React Frontend │    │  Django Backend │
│   (Mobile)      │◄──►│   (Web Client)  │◄──►│   (REST API)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                        ┌─────────────────┐
                        │   PostgreSQL    │
                        │   (Database)    │
                        └─────────────────┘
```

## 🛠️ Technology Stack

### Backend
- **Framework**: Django & Django REST Framework
- **Language**: Python
- **Database**: PostgreSQL
- **Cache**: Redis
- **Real-time**: gRPC, MQTT (Eclipse Mosquitto)
- **Documentation**: Swagger/OpenAPI

### Frontend
- **Framework**: React (Create React App)
- **HTTP Client**: Axios
- **UI Feedback**: react-hot-toast
- **Language**: JavaScript/TypeScript

### Mobile
- **Framework**: Flutter
- **Language**: Dart
- **State Management**: GetX
- **HTTP Client**: Dio

### DevOps
- **Containerization**: Docker
- **Version Control**: Git

## 📁 Project Structure

```
vsky_fullstack-demo/
├── backend/                 # Django REST API server
│   ├── apps/               # Django applications
│   ├── restaurant_app/     # Main restaurant app
│   ├── orders/             # Order management
│   ├── menu_items/         # Menu item handling
│   ├── mysite/             # Django project settings
│   ├── requirements.txt    # Python dependencies
│   └── manage.py          # Django management script
├── frontend/               # React web application
│   ├── src/               # React source code
│   ├── public/            # Static assets
│   └── package.json       # Node.js dependencies
├── mobile/                 # Flutter mobile application
│   └── task5/             # Main Flutter project
├── database/               # Database configuration
└── README.md              # Project documentation
```

## ✨ Key Features

### Backend Features
- **Restaurant Management**: CRUD operations for restaurant data
- **Menu Management**: Dynamic menu items with translations
- **Order Processing**: Real-time order handling via MQTT
- **Revenue Analytics**: Automated revenue calculations
- **API Documentation**: Comprehensive REST API docs
- **Real-time Communication**: gRPC services for restaurant operations

### Frontend Features
- **Restaurant Listing**: Interactive restaurant browsing
- **Modal Forms**: Add new restaurants via user-friendly forms
- **Toast Notifications**: Real-time user feedback
- **Responsive Design**: Mobile-friendly interface

### Mobile Features
- **Cross-platform**: iOS and Android support
- **Restaurant Display**: List restaurants with ratings and details
- **State Management**: Reactive UI with GetX
- **API Integration**: Seamless backend connectivity

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose
- Git
- Node.js (for frontend development)
- Flutter SDK (for mobile development)
- Python 3.8+ (for backend development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://gitlab.com/Bcoder24/vsky_fullstack-demo.git
   cd vsky_fullstack-demo
   ```

2. **Backend Setup**
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   python manage.py migrate
   python manage.py runserver
   ```

3. **Frontend Setup**
   ```bash
   cd ../frontend
   npm install
   npm start
   ```

4. **Mobile Setup**
   ```bash
   cd ../mobile/task5/flutter_app
   flutter pub get
   flutter run
   ```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the backend directory:
```env
DEBUG=True
SECRET_KEY=your-secret-key
DATABASE_URL=postgresql://user:password@localhost:5432/restaurant_db
REDIS_URL=redis://localhost:6379/0
```

### Database Setup

The project uses PostgreSQL. Update your database configuration in `backend/mysite/settings.py` or use environment variables.

## 📱 API Endpoints

The backend provides RESTful APIs for:
- `GET/POST /api/restaurants/` - Restaurant management
- `GET/POST /api/menu-items/` - Menu item operations
- `GET/POST /api/orders/` - Order processing
- `GET /api/revenue/` - Revenue analytics

## 🔄 Real-time Features

- **MQTT Communication**: Order updates via MQTT broker
- **gRPC Services**: Restaurant service communication
- **WebSocket Ready**: Infrastructure for real-time web features

## 🧪 Testing

Run tests for each component:

```bash
# Backend tests
cd backend
python manage.py test

# Frontend tests
cd ../frontend
npm test

# Mobile tests
cd ../mobile/task5/flutter_app
flutter test
```

## 🚢 Deployment

### Docker Deployment
```bash
docker-compose up --build
```

### Individual Deployment
Each component can be deployed independently using their respective deployment strategies.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

- **Bcoder24** - *Project Creator*

## 🙏 Acknowledgments

- Django community for the excellent framework
- React team for the powerful frontend library
- Flutter team for cross-platform mobile development
- Open source community for various tools and libraries

---

**Note**: This is a demonstration project showcasing fullstack development practices and modern web/mobile technologies.
