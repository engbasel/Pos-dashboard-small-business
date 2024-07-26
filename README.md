
# POS Flutter Project

This project is a Point of Sale (POS) system built using Flutter. The application includes various features such as database management, PDF generation, localization, and more.

## Features

- **Custom Widgets**: Includes custom buttons, text fields, and drawers for a consistent UI/UX.
- **Database Integration**: Uses SQLite for storing and managing data.
- **PDF Generation**: Generates and prints PDF documents for order details.
- **Localization**: Supports multiple languages for various widgets and screens.
- **User Management**: Features for adding, deleting, and displaying user information.
- **Order Management**: CRUD operations for orders, with orders displayed in a DataTable.
- **Settings Screen**: Configurable settings for the application.
- **Logging**: User logs with delete functionality for tracking actions.

## Commit History Highlights

### July 13, 2024
- **Removed Custom Widgets**: Removed `CustomButton` and `CustomDrawer` widgets, and updated imports to reflect their new locations.
- **Desktop Layout Update**: Moved `CustomDrawer` and added `AppBar` to `Scaffold` in `DesktopLayout`.
- **UI Edits**: Various UI updates and improvements.

### July 12, 2024
- **Database Helper Refactor**: Renamed variables and updated method names in `LoginSQL_helper` and `database_helper_productsTable`.
- **Widget Updates**: Swapped `home` widget in `PosSystem` from `DesktopLayout` to `LoginView`.
- **Input Formatting**: Added input formatters and keyboard types to `CustomTextField` widgets.
- **PDF and Printing**: Added PDF generation and printing functionality to `OrderDetailsScreen`.

### July 11, 2024
- **Localization**: Added localization support for various widgets and views, including `CustomDrawer`, `UserLogsView`, and `UserList`.
- **Refactoring**: Various refactors to improve code readability and maintainability.
- **User Management**: Added user logs view with delete functionality.

### July 10, 2024
- **Screen Size Logging**: Updated breakpoint for desktop layout in `DashboardView` and added screen size logging in `main.dart`.
- **Dependencies**: Added `sqflite` and `path_provider` dependencies and modified macOS plugin registration.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

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

### Running the App

To run the application, use the following command:
```sh
flutter run
```

### Directory Structure

```
lib/
├── core/
│   ├── db/
│   ├── utils/
├── features/
│   ├── client/
│   ├── login/
│   ├── Notifications/
│   ├── overview/
│   ├── responsev_dashboard/
│   ├── ReturnsInvoices/
│   ├── settings/
├── l10n/
├── main.dart
```

## Contributions

Contributions are welcome! Please fork the repository and submit a pull request for any improvements or new features.

## License

This project is licensed under the MIT License.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [SQLite](https://www.sqlite.org/index.html)
- [sqflite](https://pub.dev/packages/sqflite)

---


