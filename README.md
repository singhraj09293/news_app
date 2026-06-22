# Newzly 📰
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%2B%20Firestore-FFCA28?logo=firebase&logoColor=black)
![License](https://img.shields.io/badge/license-MIT-green)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)
> Stay ahead of the headlines.

A modern Flutter news app delivering real-time news with a clean dark UI, smart search, and seamless bookmarking.

---

## ✨ Features

- 🔐 **Auth** — Email & Google Sign In via Firebase Auth
- 📰 **Live Feed** — Real-time headlines powered by NewsAPI
- 🔍 **Search** — Instantly search any topic
- 🔖 **Bookmarks** — Save articles to Firestore, swipe to delete
- 📤 **Share** — Share articles directly from the app
- 📸 **Profile** — Upload photo via Cloudinary, update display name
- 🌙 **Dark UI** — Clean, minimal dark theme
- 🔄 **Pull to Refresh** — Always up to date

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | Flutter |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| News Data | NewsAPI |
| HTTP Client | Dio |
| Image Hosting | Cloudinary |
| Image Picker | image_picker |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Firebase project with Auth + Firestore enabled
- [NewsAPI](https://newsapi.org) key
- [Cloudinary](https://cloudinary.com) account

### Setup

1. **Clone the repo**
```bash
   git clone https://github.com/yourusername/newzly.git
   cd newzly
```

2. **Install dependencies**
```bash
   flutter pub get
```

3. **Configure Firebase**
```bash
   flutterfire configure
```
   This generates `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).

4. **Add environment variables**

   Create a `.env` file in the project root:
```env
   NEWS_API_KEY=your_newsapi_key
   CLOUDINARY_CLOUD_NAME=your_cloud_name
   CLOUDINARY_UPLOAD_PRESET=your_upload_preset
```

5. **Run the app**
```bash
   flutter run
```

---

## 📁 Project Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   └── theme/
├── features/
│   ├── auth/
│   ├── news/
│   ├── bookmarks/
│   └── profile/
└── shared/
    ├── models/
    └── widgets/
```

---

## 📄 License

MIT © 2024 [Raj Singh](https://github.com/singhraj09293)