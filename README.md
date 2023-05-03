<h1 align="left">DRF React & Redux Boilerplate</h1>

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![CircleCI](https://dl.circleci.com/status-badge/img/gh/faisalnazik/Django-React-Redux-Boilerplate/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/faisalnazik/Django-React-Redux-Boilerplate/tree/main)
[![Maintainability](https://api.codeclimate.com/v1/badges/1dc1d840640dad52e38f/maintainability)](https://codeclimate.com/github/faisalnazik/Django-REST-Framework-React-BoilerPlate/maintainability)

![](image/README/1650208713974.png)![1671452013971](image/README/1671452013971.png)

## Frontend ⭐

- Minimal Template with neccessary components✔
- Configured Redux Store✔
- Auto formatted with Prettier ✔
- React with functional components and hooks ✔
- Forms Validation with Formik ✔
- Login , example to understand the JWT auth ✔
- Server Errors Handling✔

## Backend🛠

![](image/README/1650278750325.png)![1671452027931](image/README/1671452027931.png)

- Django REST framework for a powerful API ✔
- Django ORM for interacting with the database✔
- Authentication With JWT (Register, Sign In) ✔
- Throttle setup ✔
- Testing with Pytest ✔
- Extra password hashers like `Argon2PasswordHasher` Recommend by official django docs. ✔

## Motivation 🎯

- A quickstart django react boilerplate with updated dependecies to start with react project.
- Material UI usage⭐

## How to Run locally 🚀

### Backend

- Install requirements after creating and activating virtual environement

    $ pip install -r requirements/local.txt

- Currently SQLite is configured, you can change it with any other as well. Then run

    $ python manage.py makemigrations
        $ python3 manage.py migrate

    To run tests:
        $ pytest

    API Documentation will be available at http://localhost:8000/api/v1/schema/redoc/

    Admin available at`http://localhost:8000/admin/`

### Frontend

    - Install dependencies in frontend app using following commands in separate terminal
    - First make sure you have installed Node.js, v18.12.1. while upgrading this setup.

    For More info https://nodejs.org/en/

    - Then run following commands in frontend dir

    $ yarn install
    $ yarn start

    -  React app available at`http://localhost:3000/`

👉 [Github Pages](https://faisalnazik.github.io/Django-REST-Framework-React-BoilerPlate/)

## ⭐️ Support

Give a ⭐️ if this project helped you!

## License ©

[The MIT License](LICENSE)


PROJECT STRUCTURE:

1.config: This app will contain the main settings and configurations of the project, such as settings.py, urls.py, and wsgi.py.

2. websites: This app will handle the CRUD operations related to the websites. It will include models such as Site, WebsiteHistory, Location, etc. The views will handle the requests related to adding, updating, and deleting sites, as well as requesting and displaying scan results.

3. accounts: This app will handle user authentication and authorization. It will include models such as User, Group, and Permission. The views will handle user registration, login, and logout, as well as managing user accounts and permissions.

4. dashboard: This app will provide the dashboard views for each type of user. It will include views such as UnauthenticatedDashboard, AdministratorDashboard, and AuditorDashboard. Each dashboard will display different information based on the user type, such as the status of all sites for unauthenticated users, and the status of the administrator's own sites for administrators.

5. api: This app will provide the API views for the project, allowing external services to access and interact with the project data. It will include views such as SiteListAPIView and ScanResultCreateAPIView.


Autorizareweb/  
|-- config/  
|   |-- __init__.py  
|   |-- settings.py  
|   |-- urls.py  
|   |-- wsgi.py  
|-- websites/  
|   |-- __init__.py  
|   |-- admin.py  
|   |-- apps.py  
|   |-- models.py  
|   |-- views.py  
|   |-- urls.py  
|-- accounts/  
|   |-- __init__.py  
|   |-- admin.py  
|   |-- apps.py  
|   |-- models.py  
|   |-- views.py  
|   |-- urls.py  
|-- dashboard/  
|   |-- __init__.py  
|   |-- admin.py  
|   |-- apps.py  
|   |-- models.py  
|   |-- views.py  
|   |-- urls.py  
|-- api/  
|   |-- __init__.py  
|   |-- admin.py  
|   |-- apps.py  
|   |-- views.py  
|   |-- urls.py  
  
|-- manage.py  
  
