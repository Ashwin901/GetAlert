# GetAlert

This is a flutter application which a user can use to save his emergency contacts and send a help text to them by pressing a button.

### Task ID: Alarming_System_Mobile_App

### The apk file is present in the 'apk file' folder

## Getting Started

The application starts off with two options : 1) register  2) login

The registration is done using email and password (Firebase authentication)

#### Once a user logs into the app he stays logged in, the user need not login everytime he opens the app.

## Packages :

[firebase_auth: ^0.18.1+1](https://pub.dev/packages/firebase_auth)
Used for registering and logging in users.

[cloud_firestore: ^0.14.1+2](https://pub.dev/packages/cloud_firestore)
Used for storing the contacts of the users.

[firebase_core: ^0.5.0](https://pub.dev/packages/firebase_core)

[sms: ^0.2.4](https://pub.dev/packages/sms)
Flutter package which is used to send messages to the saved contacts

## Modules :

#### Home section :

Once a user successfully logs in he is taken to the main screen where there is a default message that the user can send.
The user can change the message if they want to.

#### Contact section :

Here the user can save contacts by entering the name and number of the person.
There is no lmits to the number of contacts.

When the user presses the send button the message is sent to all the contacts listed in the contact section.

## Storage :

All the contact info is stored in firestore using the cloud_firestore package.
All the contacts stored is user specific.

## Error handling :

The errors which might arise during registration or login Ex: weak password , invalid email etc is handled by a handleErrors file, which takes the error code and displays the error to the user.

### Note: 
The user can logout from his account anytime by pressing a button in the appbar.

