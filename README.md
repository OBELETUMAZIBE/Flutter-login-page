# 📱 Flutter Login & Registration Screen

> **Student:** Obeletu Mazibe  
> **GitHub:** [OBELETUMAZIBE](https://github.com/OBELETUMAZIBE)  
> **Repository:** [OBELETUMAZIBE/Flutter-Login-page](https://github.com/OBELETUMAZIBE/Flutter-Login-page)

---

## 📌 Project Overview

A single-file Flutter UI that combines a **Log In** and a **Create Account** screen behind an **animated sliding toggle**. Built as a school assignment using only the Flutter SDK (Material 3) — **no extra packages needed**.

The entire implementation lives in `lib/main.dart`.

---

## ✨ Features

### 🔐 Login Mode
- Email field with email keyboard type and autofill hint
- Password field with show/hide toggle
- "Forgot password?" link (UI placeholder)
- "Continue with Google" button (UI only)
- Form validation with inline error messages

### 📝 Registration Mode
- Full name field with autofill hint
- Email field
- Password field (min 8 characters) with show/hide toggle
- Confirm password field (must match password)
- Terms & Privacy text at the bottom

### 🎨 UI / UX
- Animated **sliding toggle** to switch between Login and Register
- Loading spinner on the submit button while a request is simulated
- Header collapses when the keyboard opens (form never squeezed)
- Scrollable layout with **max width of 440px** (works on tablets too)
- Custom **teal + marigold** colour palette via `AppColors` class
- Material 3 design with `FilledButton` and `OutlineInputBorder`

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| Flutter | Cross-platform UI framework |
| Dart | Programming language |
| Material 3 | UI design system |
| Android Studio | IDE used for development |

---

## 📁 Project Structure

```
kumazlogin_page/
├── lib/
│   └── main.dart          # Entire app: entry point, screens, widgets, validation
├── android/               # Android platform files
├── web/                   # Web platform files
├── test/
│   └── widget_test.dart   # Default Flutter tests
├── pubspec.yaml           # Project metadata and dependencies
└── README.md              # Project documentation
```

### Key Classes in `main.dart`

| Class / Member | Purpose |
|----------------|---------|
| `AppColors` | All colours used by the screen — change here to re-theme |
| `MyApp` | App entry point, sets Material 3 theme (teal seed) |
| `AuthScreen` / `_AuthScreenState` | Main screen: state, controllers, validation, submit logic |
| `_header()` | Logo, app name, and heading that changes with the mode |
| `_buildForm()` | Form fields, buttons, divider and terms text |
| `_fieldDecoration()` | Shared `InputDecoration` style for every `TextFormField` |
| `_ModeToggle` | The Log in / Create account switch with a sliding indicator |

---

## ✅ Validation Rules

| Field | Rule |
|-------|------|
| Full name | Required (registration only) |
| Email | Required, must contain `@` and `.` |
| Password | Required — min **8 characters** on registration, min **6** on login |
| Confirm password | Must exactly match the password (registration only) |

---

## 🚀 How to Run

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.7+
- Dart 2.17+
- Android Studio with Flutter & Dart plugins
- Android emulator or physical device

### Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/OBELETUMAZIBE/Flutter-Login-page.git
   cd Flutter-Login-page
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on Android (emulator or device):**
   ```bash
   flutter run
   ```

4. **Run on Web (Chrome):**
   ```bash
   flutter run -d chrome
   ```

> No changes to `pubspec.yaml` are needed — the app uses only the Flutter SDK.

---

## 🧠 Concepts Demonstrated

- **StatefulWidget & State management** — animated toggle, loading state, password visibility
- **Form & GlobalKey** — Flutter's built-in form validation system
- **TextEditingController** — capturing and reading all text field values
- **AnimatedCrossFade / AnimatedSwitcher** — smooth transition between login and register modes
- **Keyboard awareness** — header collapses when keyboard appears using `MediaQuery`
- **Material 3 design** — `FilledButton`, `OutlineInputBorder`, `ColorScheme.fromSeed`
- **Custom colour system** — `AppColors` class for centralised theming
- **Autofill hints** — `AutofillHints` for name, email and passwords
- **SnackBar feedback** — success and error messages to the user

---

## 🔌 Connecting a Real Backend

The screen simulates a request with `Future.delayed`. In `_submit()`, replace the `TODO` line with your own call:

```dart
// Example with Firebase Auth
if (_isLogin) {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _email.text.trim(),
    password: _password.text,
  );
} else {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _email.text.trim(),
    password: _password.text,
  );
}
```

Other `TODO` placeholders in the file:
- **Forgot password?** — navigate to your reset-password screen
- **Continue with Google** — connect your Google sign-in flow

---

## 🎨 Customisation

| What to change | Where |
|----------------|-------|
| Colours | `AppColors` class at the top of `main.dart` |
| App name | `'Your App'` string in `_header()` |
| Logo | Replace `Icon(Icons.hexagon_rounded)` with `Image.asset(...)` |
| Google icon | Swap the Material icon with the official Google logo asset |
| Font | Add under `fonts:` in `pubspec.yaml` and set `fontFamily` in `ThemeData` |
| Terms text | Edit the line at the bottom of the registration form |

---

## ⚠️ Notes

- Passwords and form values are held **only in memory** by the controllers and disposed in `dispose()`.
- Switching tabs **clears the form** and error messages but keeps the email address.
- The current auth result is only a SnackBar — **nothing is stored or sent** until you add your own backend.
- This project was created for **learning and assignment purposes**.

---<img width="960" height="540" alt="Screenshot 2026-11-03 155533" src="https://github.com/user-attachments/assets/9d7edf59-3178-47e7-9a7c-5d40f64ac3d7" />
<img width="960" height="540" alt="Screenshot 2026-11-03 155511" src="https://github.com/user-attachments/assets/7b774ab9-bbb2-46ce-a6bf-fa3dd1680825" />

