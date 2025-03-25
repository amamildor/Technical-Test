## Environment
+ Xcode 16.2
+ iOS 17.0 or later

## Datas
+ Images are loaded from https://picsum.photos
+ Hardcoded Users

## Architecture
+ MVVM + Clean Architecture

## External Dependencies
+ none

## Implemented Features
- **Story List Screen**
    - Display a list of stories (pagination required: infinite number of stories, even if the data repeats). The rest of the screen doesn’t matter, it can be blank.
    - Each story should be visually identifiable as **seen or unseen**.
- **Story View Screen**
    - Users can navigate between the story list and individual stories.
    - Stories should have a **like/unlike** functionality.
    - Get inspired by Instagram (gestures, buttons, etc.).
- **States**
    - The user can like a story. **Seen/unseen states** should be explicit.
      
## Missing Features
- **Story List Screen**
    - The UI and Model are ready to differentiate **seen or unseen** but it is not handled
- **States**
    - The UI and Model are ready to handle **like/unlike**, but it is not persisted
- **Persistence**
    - The states should **persist across app sessions**.

 ## Technical notes
 - I created small reusable views
 - I keep View body compact by using @ViewBuilder
 - I'm using AsyncImage : allows cache / loading / and error handling
 - I'm using Enum with associated values to handle components used in AsyncImage phase (empty, success, failure)
 - I implemented gestures when viewing Story images:
   - swipe to left / right to change user
   - long press to pause animation
   - tap to navigate between story images
