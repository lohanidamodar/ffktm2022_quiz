# Flutter Festival Kathmandu Quiz App
![GitHub Stars](https://img.shields.io/github/stars/lohanidamodar/ffktm2022_quiz?style=social)

A quiz app for the Flutter Festival Kathmandu built with [Flutter Web](https://flutter.dev) on frontend and [Appwrite](https://appwrite.io) on backend.

Live Preview: https://ffktm2022.codemagic.app

## Build Guide

This project needs Flutter installed and Appwrite project configured to run successfully. 
1.  To install flutter refer to this [page](). 
    To install appwrite refer to this [page]().

2. Change the Appwrite *project_id* and *endpoint* in `/lib/services/appwrite.dart`.

3. Setup database structure in Appwrite project 

4. Run `flutter pub get`.

5. Build
   - For Android: 
      ``` flutter build apk```

   - For Web: 
      ``` flutter build web```

## Database Document Structure
```
Questions collection
collectionId: questions
fields: 
question: string
options: array of string
answer: string

Scores Collection
collectionId: Scores
fields:
userId: string (id of the user who took the quiz)
score: int (total score obtained out of 10)
answers: string (json encoded string of an array [{"questionId": "id", "selected_answer": "answer", "correct": true or false} ...],
phone_number: string (required if we want to distribute prize)
```

## Screenshots

![ScreenShot 1](https://raw.github.com/lohanidamodar/ffktm2022_quiz/master/screenshots/1.png)
![ScreenShot 2](https://raw.github.com/lohanidamodar/ffktm2022_quiz/master/screenshots/2.png)
![ScreenShot 3](https://raw.github.com/lohanidamodar/ffktm2022_quiz/master/screenshots/3.png)
![ScreenShot 4](https://raw.github.com/lohanidamodar/ffktm2022_quiz/master/screenshots/4.png)

## License
Flutter Festival Kathmandu Quiz App is MIT licensed, as found in the [LICENSE](LICENSE) file.