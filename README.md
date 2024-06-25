# Firebase Auth CRUD Social Media App

This Flutter application is a social media app that integrates Firebase for authentication and CRUD operations. It has been tested on web, Android, and Windows platforms.

## Features

- User Authentication (Sign up, Login, Logout)
- Create, Read, Update, Delete (CRUD) operations on posts
- Profile management
- Image upload and display
- Responsive design for multiple platforms

## Skills Used

- Flutter
- Dart
- Firebase Authentication
- Firebase Firestore
- Firebase Storage
- State Management (Cubit)
- Image Uploading and Compression Handling
- Working with Slivers
- Creating Shimmer Components

## Getting Started

### Prerequisites

- Flutter SDK
- Firebase account

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/elnaddar/firebase_auth_crud_social_media_app.git
    cd firebase_auth_crud_social_media_app
    ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Set up Firebase:
    - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
    - Add your app to the Firebase project for each platform (iOS, Android, Web)
    - Download the `google-services.json` file for Android and `GoogleService-Info.plist` file for iOS and place them in the respective directories.
    - For web, update the Firebase config in `index.html`.

4. Run the app:
    ```sh
    flutter run
    ```

## Folder Structure

```
lib/
├── auth/
│   ├── auth_cubit.dart
│   └── logout_widget.dart
├── components/
│   ├── app_cache_net_image.dart
│   ├── app_drawer.dart
│   ├── app_shimmer.dart
│   ├── form_button.dart
│   └── input_form_field.dart
├── cubits/
│   ├── like_cubit/
│   │   └── like_cubit.dart
│   ├── posts_cubit/
│   │   └── posts_cubit.dart
│   ├── post_loader_cubit/
│   │   └── post_loader_cubit.dart
│   └── user_cubit/
│       └── user_cubit.dart
├── helpers/
│   └── navigation_helper.dart
├── models/
│   ├── post_model.dart
│   └── user_model.dart
├── repository/
│   ├── auth_repository.dart
│   └── posts_repository.dart
├── services/
│   ├── api_service.dart
│   └── image_service.dart
├── utils/
│   └── src/
│       ├── constants.dart
│       └── utils.dart
├── views/
│   ├── errors/
│   │   └── error_view.dart
│   ├── home/
│   │   ├── home_view.dart
│   │   └── posts/
│   │       ├── posts_builder/
│   │       │   └── posts_builder.dart
│   │       └── post_view/
│   │           └── post_view.dart
│   ├── login/
│   │   ├── login_form/
│   │   │   └── login_form.dart
│   │   └── login_view.dart
│   ├── profile/
│   │   └── profile_view.dart
│   ├── register/
│   │   ├── register_form/
│   │   │   └── register_form.dart
│   │   └── register_view.dart
│   ├── users/
│   │   └── users_view.dart
│   └── verify_email/
│       └── verify_email_view.dart
├── firebase_options.dart
└── main.dart
```

## Key Files

- `main.dart`: Entry point of the application.
- `firebase_options.dart`: Firebase configuration options.
- `auth/auth_cubit.dart`: Business logic for authentication.
- `repository/`: Contains data repository files.
- `services/`: Includes service files for API and image handling.
- `views/`: Contains UI views and components.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any features or bug fixes.
