# Flowery Tracking App 🌹🏍️

## Overview

The **Flowery Tracking App** is a modern Flutter-based delivery management solution designed for drivers within the Flowery ecosystem.  
It empowers drivers to **receive**, **navigate**, and **complete** delivery tasks seamlessly — building a reliable connection between stores and customers.  

Developed with **scalability**, **speed**, and **real-time synchronization** in mind, the app integrates **Firebase Firestore** to keep driver and customer data perfectly aligned throughout the delivery process.  

The project also includes robust **localization support**, **dependency injection**, and automated **testing** and **CI/CD** pipelines for continuous quality assurance.  
Its architecture follows a **feature-driven**, **layered** structure — organizing logic into **presentation**, **domain**, and **data** layers — while connecting with both **REST APIs** and **Firebase Firestore** for smooth, live data flow.


---

## Tech Stack

- **Flutter** (UI)
- **Dart** (language)
- **State management:** `flutter_bloc` (Bloc/Cubit patterns)
- **Dependency injection:** `get_it` + `injectable` (generated `di.config.dart`)
- **Networking:** `dio` + `retrofit` (API clients & JSON serialization) 
- **Serialization / Codegen:** `json_serializable`, `build_runner` + code generation
- **Local storage / security:** `shared_preferences`, `flutter_secure_storage`
- **Other libraries:** `cached_network_image`, `flutter_svg`, `lottie`, `location`, `pin_code_fields`, `logger`, `pretty_dio_logger`, `equatable`, etc.
- **Testing:** `flutter_test`, `bloc_test`, `mockito` for unit & widget tests
- **CI / Quality:** GitHub Actions workflows for linting, SonarCloud, PR title checks, unit tests, and Fastlane for distribution
- **Firebase Firestore**: Real-time synchronization between driver and user apps.

---

## Architecture

The project follows a modern, layered and feature-driven architecture:

- **Feature-first layout** (e.g., `lib/features/<feature>/...`) — each feature contains its `data`, `domain`, and `presentation` layers.
- **Domain layer**: Entities and use-cases (pure Dart models & business rules).
- **Data layer**: DTOs, remote/local data sources, repositories, and mappers to domain entities.
- **Presentation layer**: Flutter UI using Bloc/Cubit for state management (views, pages, widgets).
- **Dependency injection**: `get_it` configured and code-generated via `injectable` (`di.config.dart`).
- **Internationalization**: ARB-based localization with `l10n.yaml` configuration (generated `app_localizations.dart`).

---

## Features 🌻🌼💐  

### Onboarding & Authentication  🚀
- **Onboarding Flow**: Introduction screens guiding drivers about the app purpose.  
- **Login / Apply**:  
  - Registered drivers can **log in** with email and password.  
  - New drivers can **apply** for registration through a dedicated flow.  
- **Forgot Password**: Reset password easily using email verification and OTP flow.  

---

### Order Management  📦  
- **Home Screen (Pending Orders)**:  
  - Displays a real-time list of available delivery orders.  
  - Drivers can **accept** an order directly from the list.  
  - Once accepted, the order is locked until delivered.  

- **Order Details Screen**:  
  - View detailed information including:  
    - **User Details**  
    - **Store Details**  
    - **Order Details**  
  - Direct navigation to map views:  
    - **Store Map**: Displays the route from the driver’s current location to the store.  
    - **User Map**: Displays the route from the store to the customer’s location.  

- **Accepted Orders**:  
  - Real-time updates from Firestore.  
  - The driver cannot accept new orders until the current one is delivered.  

---

### Completed & Canceled Orders  📜  
- **Orders History Screen**:  
  - Displays all **Completed** and **Canceled** orders.  
  - Each order includes detailed information such as user details, store details, and delivery time.  
  - Drivers can open any previous order to view its **Order Details Screen**.

---

### Profile & Settings  👤  
- **Profile Screen**:  
  - View and edit personal information (name, phone number, etc.).  
  - Change the app language between **English** and **Arabic**.  
  - Log out securely anytime.  

---

## Testing

- Run unit & widget tests:  
  ```bash
  flutter test
  ```

- Mocks are generated using `mockito` (see generated `*.mocks.dart` files).

- CI runs tests via GitHub Actions and also runs `flutter analyze` for static analysis.

---

## Folder Structure
```
lib/
├── config/                         # Global app configurations
│   ├── routing/                    # Navigation & route management
│   └── theme/                      # Light/Dark themes setup

├── core/                           # Shared base layer used by all features
│   ├── components/                 # Reusable custom widgets
│   ├── di/                         # Dependency Injection (Injectable setup)
│   ├── errors/                     # Failure models + Safe API call handler
│   ├── helpers/                    # Toasts, dialogs, spacing helpers, validators
│   ├── l10n/                       # Localization (EN/AR) files and setup
│   ├── network/                    # Networking base (Dio interceptors, client setup)
│   ├── providers/                  # Theme & locale providers
│   ├── services/                   # App level services (Token, Firebase, etc.)
│   └── utils/                      # App constants, keys, assets utilities

├── features/                       # Modular features (Fully independent)
│   ├── auth/
│   │   ├── data/
│   │   │   ├── data_source/        # Remote/Local data sources
│   │   │   ├── models/             # DTOs with json_serializable
│   │   │   └── repositories_impl/  # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/           # Business entities
│   │   │   ├── repositories/       # Repository contracts
│   │   │   └── usecases/           # Auth use cases
│   │   └── presentation/
│   │       ├── view_models/        # BLoC / Cubit state management
│   │       ├── screens/            # UI pages
│   │       └── widgets/            # Feature-specific widgets
│   │
│   ├── home/                       # Same structure for each feature
│   ├── product/
│   └── cart/

├── firebase_options.dart           # Firebase configuration file
└── main.dart                       # Application entry point

```

---

## How to Run the Project
1. Install Flutter (stable channel recommended)
2. Get dependencies:
```bash
flutter pub get
```
3. Generate code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
4. Run the app:
```bash
flutter run
```
5. Build an APK:
```bash
flutter build apk --release
```

---

## CI / CD
- GitHub Actions for linting, pull request title, branch name, unit testing, soner qube, building & distribution
- Fastlane workflow for Firebase App Distribution

---

## 📱 Screenshots

<div align="center">

<!-- Onboarding -->
<h3>Onboarding</h3>
<table>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/92cd2c71-a3a0-4e64-a288-e92ecf3f7eba" alt="onboarding_1"/></td>
  </tr>
</table>

<br/>

<!-- Login -->
<h3>Login</h3>
<table>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/e7e7e151-ab4e-46a1-a79a-19ecb84215be" alt="login"/></td>
  </tr>
</table>

<br/>

<!-- Apply Driver -->
<h3>Apply Driver</h3>
<table>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/4c56dc5c-ed8a-42dc-a076-b6697c48928d" alt="apply_driver_1"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/aab1fbb3-4b87-4d5e-9a49-e82d07cb53ab" alt="apply_driver_2"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/1d8b8812-2904-47f9-a2b2-195fe9ce0502" alt="apply_driver_3"/></td>
  </tr>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/019e120b-6cd5-42c8-a49d-d54c9e27e1d3" alt="apply_driver_4"/></td>
  </tr>
</table>

<br/>

<!-- Forgot Password -->
<h3>Forgot Password</h3>
<table>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/8e87ef92-97cc-4e2a-85ef-e10ff9f9fcbd" alt="forgot1"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/1db116be-4708-4e81-8b73-b764d7d62eb6" alt="code"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/013248f3-03e2-489e-8643-90865ecc6e84" alt="new_pass"/></td>
  </tr>
</table>

<br/>

<!-- Home Tab -->
<h3>Home Tab</h3>
<table>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/4760b1bc-b6be-4a8d-94e8-75cd4222f2db" alt="home_tab"/></td>
  </tr>
</table>

<br/>

<!-- Order Details -->
<h3>Order Details</h3>
<table>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/9cbb7267-b27f-4bf0-850e-8cca62d3ce4d" alt="order_details_1"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/ad103ddd-3aaa-4f96-a3d4-f4ca9fd0e14b" alt="order_details_2"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/f5558298-1e8a-41cc-ab86-da2b5728b849" alt="order_details_3"/></td>
  </tr>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/96b029ff-e34c-41c0-94e4-782abf6dbf3e" alt="order_details_4"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/8d290eb0-df53-4ab9-8849-511e6584507e" alt="order_details_5"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/6f56ead9-c1bc-4c9e-a571-1833a543cad9" alt="order_details_6"/></td>
  </tr>
</table>

<br/>

<!-- Orders Tab -->
<h3>Orders Tab</h3>
<table>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/63d6391f-67b6-48bf-b793-d72ed4ba9980" alt="orders_tab"/></td>
  </tr>
</table>

<br/>

<!-- Profile -->
<h3>Profile</h3>
<table>
  <tr>
    <td><img width="250" src="https://github.com/user-attachments/assets/a5e3a841-960b-4cc5-95e0-6ba826c20b90" alt="profile_1"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/0595e5df-b2fd-4bec-ad07-9effe954bf22" alt="profile_2"/></td>
    <td><img width="250" src="https://github.com/user-attachments/assets/10657c13-891b-4995-b30f-1b6d71c0c3b4" alt="profile_3"/></td>
  </tr>
</table>

</div>


---

## 👨‍💻 Contributors

- [Ahmed Fayed](https://github.com/AhmedFayed55)
- [Yahya Eltayeeb](https://github.com/YahyaEltayeeb)
- [Ahmed Rajeh](https://github.com/rajeh1032)
- [Mostafa Amer](https://github.com/MostafaAmer978)
- [Ahmed Yehia](https://github.com/ahmedyhia123)

---

### 👥 GitHub Avatars
<a href="https://github.com/AhmedFayed55"><img src="https://github.com/AhmedFayed55.png" width="60" /></a>
<a href="https://github.com/YahyaEltayeeb"><img src="https://github.com/YahyaEltayeeb.png" width="60" /></a>
<a href="https://github.com/rajeh1032"><img src="https://github.com/rajeh1032.png" width="60" /></a>
<a href="https://github.com/MostafaAmer978"><img src="https://github.com/MostafaAmer978.png" width="60" /></a>
<a href="https://github.com/ahmedyhia123"><img src="https://github.com/ahmedyhia123.png" width="60" /></a>


---

## License
Choose a license (MIT recommended)
