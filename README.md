# GetAlert

This is a flutter application which a user can use to save his emergency contacts ans send a help text to them by pressing a button.

## Getting Started

The application starts off with two options : 1) register  2) login

The registration is done using email and password (Firebase authentication)

#### Once a user logs into the app he stays logged in, the user need not login everytime he opens the app.

## Packages :



## Modules :

#### Home section :

Once a user successfully logs in he is taken to the main screen where there is a default message that the user can send.
The user can change the message if they want to.

#### Contact section :

Here the user can save contacts by entering the name and number of the person.
There is no lmits to the number of contacts.

When the user presses the send button the message is sent to all the contacts listed in the contact section.

### Storage :

All the contact info is stored in firestore using the cloud_firestore package.
All the contacts stored is user specific.

### Error handling :

The errors which might arise during registration or login Ex: weak password , invalid email etc is handled by a handleErrors file, which takes the error code and displays the error to the user.

### Note: The user can logout from his account anytime by pressing a button in the appbar.

