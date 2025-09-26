# Firebase Configuration Setup

## Steps to get your Firebase configuration:

1. Go to https://console.firebase.google.com
2. Select your project
3. Click gear icon → Project Settings
4. Go to "General" tab
5. Scroll to "Your apps" section

## Android Configuration:
- Copy values from your Android app in Firebase Console
- Replace in `firebase_options.dart` under `android` section

## iOS Configuration:
- Copy values from your iOS app in Firebase Console  
- Replace in `firebase_options.dart` under `ios` section

## Required Fields:
- apiKey
- appId  
- messagingSenderId
- projectId
- storageBucket

## Firestore Database Setup:
1. Go to Firestore Database in Firebase Console
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location
5. Database will be created with open rules for testing

## Current firebase_options.dart has placeholder values that need to be replaced!