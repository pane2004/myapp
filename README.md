[![CodeFactor](https://www.codefactor.io/repository/github/pane2004/myapp/badge)](https://www.codefactor.io/repository/github/pane2004/myapp)
# WasteWizard++

Our project aimed to tackle a core environmental issue that has plagued communities, city planners, and environmental activists for decades: proper waste disposal. 

WasteWizard++ is an intuitive machine-learning powered mobile application compatible with IOS and Android that helps users identify the correct (and environmentally conscious) way of disposing their waste products. 


## Inspiration

While our local WasteWizard applications are extremely helpful, we noticed a major conundrum: since it is a text-based database, one must already be able to classify the item before checking if it is recycling or not. To eliminate this friction, we created the WasteWizard++ mobile application. All the user has to do is click two buttons on their phone, and they will be able to classify their waste item as Recycling, Garbage, Compost, or Hazardous Waste. 

## Features

- Exclusive Model: WasteWizard++ uses an in-house Tensorflow lite Machine Learning Model trained on our own dataset of more than 5000 household item images 
- Extremely Efficient: our model is highly optimized for mobile devices, to the point where all classification is done ON THE MACHINE as opposed to the cloud. This allows our application to return a classification in less than 300ms
- Firebase Backend: intuitive Firestore database allows us to securely store all user information dynamically on the cloud, and allows the user to retrieve their entire scan history at anytime and on any device. No sneaky backups are kept, which means that the user can permanently delete all of their image data in the click of a button. 
- Fast Engine: Application was developed using the Flutter rendering engine, dramatically improving app performance over React native.

## Tech Stack

- Frontend: Flutter (renders to IOS and Android devices from a single codebase)
- Backend: Firebase Firestore
- Storage: Firebase Storage
- Machine Learning: Tensorflow, Tensorflow Lite

## Learn More

To read a full log of our production process, or read user documentation, please go to the respective directory. 

## Problems

- IOS: The application theoretically works in IOS, but we are unable to test it due to the constraint of not owning a macOS device. 

## Application Demo

Due to the nature of our application, we have created an in depth demo of all functions in case no android device can be used to test the program. 

[![WasteWizard++ Full User DEmo](https://yt-embed.herokuapp.com/embed?v=yNw7NB4Ar8I)](https://www.youtube.com/watch?v=yNw7NB4Ar8I)


