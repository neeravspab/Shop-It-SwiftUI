# Shop-It-SwiftUI
Shopit is ecommerce native iOS app using Firebase, Swift 5, Xcode 14 with SwftUI, and iOS 15. Demonstrating the Firebase Cloud Firestore real time database.

# SetUp
1) Install CocoaPods<br />
    -> You can utilize gem, rvm ruby, brew and others, or you can obtain the compiled macOS app from https://cocoapods.org<br />
    -> Or You can add Google Firebase Pakage from File<br />
    -> Add Packages...<br />
2) Setup Your Own Firebase Account<br />
3) Create a Firebase Project for this App<br />
    -> Login to your Firebase account<br />
    -> Locate the console<br />
    -> Locate the action to create a new project<br />
    -> Project Name: Enter name <br />
4) Add Firebase to Your iOS App -- In the Firebase console, you should see a project overview screen for your new project -- select the action to add an iOS app to your Firebase project<br />
  -> App Details - iOS Bundle ID: There is a dependency on the Bundle Identifier in the Xcode project -- either enter your bundle ID here and update in your Xcode project<br />
  -> Config File: In this step, you'll download the required GoogleService-Info.plist file<br />
  -> Move that file to the root directory of this sample project<br />
5) Open your own firebase project from console and create New FireStore Database<br />
6) Create Collection Name "Banners" and add few image URL with the key name "image"<br />
7) Create another collection name "Products".<br />
    -> Add few products data with below listed keys. <br />
       -> category - "Clothes"<br />
       -> description - "Product description"<br />
       -> image - "Image URL"<br />
       -> pname - "Product name"<br />
       -> price - "Price (Ex.-29.99)"<br />
       -> qty - "Quentity of product"<br />
       -> rating - "rating of prodcut out of 5"<br />
8) Run the app
  
  
  
