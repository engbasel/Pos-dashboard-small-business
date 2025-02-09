# 🛒 POS Flutter Project

A **Point of Sale (POS) system** built using Flutter, featuring database management, PDF generation, localization, and more.

---
## 🚀 Features
✅ **Custom Widgets** – Buttons, text fields, and drawers for a consistent UI/UX  
✅ **Database Integration** – Uses SQLite for data storage & management  
✅ **PDF Generation** – Create & print order details as PDFs  
✅ **Localization** – Multi-language support for widgets & screens  
✅ **User Management** – CRUD operations for users  
✅ **Order Management** – Manage orders using a DataTable  
✅ **Settings Screen** – Configurable application settings  
✅ **Logging** – User action logs with delete functionality  

---
## 📌 Commit History Highlights

### 🗓️ July 13, 2024
- 🔹 **Removed Custom Widgets**: `CustomButton`, `CustomDrawer` removed & updated imports.
- 🔹 **Desktop Layout Update**: Moved `CustomDrawer`, added `AppBar` to `Scaffold`.
- 🔹 **UI Edits**: Enhanced UI elements & improvements.

### 🗓️ July 12, 2024
- 🔹 **Database Helper Refactor**: Renamed variables & updated method names in `LoginSQL_helper`.
- 🔹 **Widget Updates**: Replaced `DesktopLayout` with `LoginView` as `home` widget.
- 🔹 **Input Formatting**: Applied formatters & keyboard types to `CustomTextField`.
- 🔹 **PDF & Printing**: Integrated PDF generation & printing in `OrderDetailsScreen`.

### 🗓️ July 11, 2024
- 🔹 **Localization**: Added multi-language support across widgets & views.
- 🔹 **Refactoring**: Improved code readability & maintainability.
- 🔹 **User Management**: Introduced user logs view with delete functionality.

### 🗓️ July 10, 2024
- 🔹 **Screen Size Logging**: Updated desktop breakpoints & added logging in `main.dart`.
- 🔹 **Dependencies**: Integrated `sqflite` & `path_provider`.

---
## 🛠️ Getting Started

### 📌 Prerequisites
- **Flutter SDK**
- **Dart SDK**

### 📥 Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/engbasel/Pos-dashboard-small-business.git
   ```
2. Navigate to the project directory:
   ```sh
   cd Pos-dashboard-small-business
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```

### ▶️ Running the App
To launch the application, use:
```sh
flutter run
```

---
## 📂 Directory Structure
```
lib/
├── core/
│   ├── db/
│   ├── utils/
├── features/
│   ├── client/
│   ├── login/
│   ├── notifications/
│   ├── overview/
│   ├── responsev_dashboard/
│   ├── returns_invoices/
│   ├── settings/
├── l10n/
├── main.dart
```

---
## 🤝 Contributions
Contributions are welcome! Please **fork the repository** and submit a **pull request** for any improvements or new features.

---
## 📜 License
This project is licensed under the **MIT License**.

---
## 🙌 Acknowledgements
- 🚀 [Flutter](https://flutter.dev/)
- 📦 [SQLite](https://www.sqlite.org/index.html)
- 🔗 [sqflite](https://pub.dev/packages/sqflite)
