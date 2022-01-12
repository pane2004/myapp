# Installation

## Clone Repository

Clone this app's repository:

```
git clone https://github.com/pane2004/myapp.git
```

## Initialize Flutter
Flutter uses Dart, google's programming language. 

1. install [Flutter](https://docs.flutter.dev/get-started/install)

2. add flutter to your system path

3. open a git bash terminal

4. run ```flutter doctor```

5. follow the instructions in the console until all requirements are met

6. run ```flutter pub get``` to install neccessary dependencies

7. execute the ```install.bat``` file by double clicking (installs the binary needed to process ML model)

## Google Cloud
This application uses various google cloud APIs

For android, create a ```AndroidManifest.xml``` file in the ```android/app/src/main``` directory, and place your Android key for Firebase and API key for Google Cloud Storage

For IOS, create a ```AndroidManifest.xml``` file, and place your IOS key for Firebase and API key for Google Cloud Storage

## Connection

Once all databases are connected, and flutter is installed, the app can be connected to an android device or emulator. 

1. Connect your android device with USB debugging enabled or start up an android emulator. Please note that the app utilizes firebase authentication, which requires access to the google play store. We recommend utilizing an emulated Google Pixel 2, which has confirmed support for the emulated playstore. 

2. In your git bash terminal, head into the root directory of the entire folder. 

3. Run ```flutter run```

## Alternative

As observed, due to the nature of flutter, the setup process is quite complex. For testing purposes, you can also just download the application from the google play store:
WasteWizard++ (still needs App Store approval). 










