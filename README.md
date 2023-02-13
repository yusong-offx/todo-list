# Todo-list
If you want to test, you have to install docker and flutter.   
And command below lines.
```shell
# In docker-compose file directory
docker compose up -d

# In flutter project directory
flutter run ./lib/main.dart
```

## Object
This is simple todo-list for showing my code style.   
This project use   
- flutter(android)
- fiber(Go framework)
- postgresql
- docker-compose
- swagger(yml)
- d2(for create schema graph)   

All codes are written by me.

## MVP
### User - Login/Sign-up
You can login and sign up at same textformfield.   
User's login_id is unique. (no duplicate)   
User's login_password save by bcrypt.
<details>
<summary>Refer images</summary>

<image src="./assets/login.png" width=300>
<image src="./assets/login-wrong.png" width=300>
<image src="./assets/login-signup.png" width=300>
<image src="./assets/login-signup-wrong.png" width=300>
</details>
<br>

### Todo - Post/Update/Delete
You can get todo-list order by not done, descending(newest) lastmodified_date.   
You can post, update, delete todo.

<details>
<summary>Refer images</summary>

<image src="./assets/home-post.png" width=300>
<image src="./assets/home-update-delete.png" width=300>
</details>
<br>

## Struct
![structure](./assets/struct.svg)

* All program service on container
* No webserver

## Details
Please refer below link.   
- [Flutter](./flutter/README.md)
- [Fiber](./bygo/README.md)
- [Postgresql](./postgresql/README.md)


*Fiber(Go) dockerfile build by multi-stage. (use alpine linux)   
*Postgresql dockerfile copy sql file and generate database.   
*About dockerfile you can check through this repo docker-compose.yml file.   
*You must not write all secrete key in code. This project is not for deploying.


## Future
---
- flutter
  - auto-login using preference.
  - various sort todo elements
  - auto refresh
- fiber
  - full text search / search function
  - write test code
  - swagger server
  - redis cache
  - todo paging
  - logger
- postgresql
  - full text search
  - try to elastic search
- docker-compose
  - migrate to k8s