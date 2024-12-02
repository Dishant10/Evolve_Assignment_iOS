# Evolve iOS Assignment

### Installation

Download .zip file or clone this project firstly, Then -

Install json-server

```swift
npm install -g json-server
```
In this repo there's one db.json file which will back this server as response
Then go to the directory where this file is and run this command in terminal to make a basic json-server

```swift
json-server --watch db.json --port 4000
```


Now open my assignment project and hit run in Xcode or press Command + R

The app should now be running

### App overview - 

* Using the json file provided in the assignment document I've created my own json server using npm (Node package manager).
* I've modified the json file a bit to support pagination and filtering.
* All the required features have been implemented such as Pagination, searching, filtering.
* One bonus features is also impleted - offine support. If the URL to the localhost is wrong or if there's no connection or maybe some other reason, the cached or locally saved list of items will be displayed but other features such as searching or filtering won't work
  
### Assumptions made - 

* I'm filtering based on problems locally rather than calling API and feteching for response every time, this method seemed faster and efficient. 


### Demo videos

Uploading drive links to videos that can demonstrate the app

1. https://drive.google.com/file/d/1J941maktXIX8Llw3vDIY_DuHpI6_DNg7/view?usp=sharing


2. https://drive.google.com/file/d/1ZOHuNXOoFoEL68RITVp5IxOXblsIhNHT/view?usp=sharing









