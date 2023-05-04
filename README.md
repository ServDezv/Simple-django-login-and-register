[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Maintainability](https://api.codeclimate.com/v1/badges/1dc1d840640dad52e38f/maintainability)](https://codeclimate.com/github/faisalnazik/Django-REST-Framework-React-BoilerPlate/maintainability)

![](image/README/1650208713974.png)![1671452013971](image/README/1671452013971.png)

## Frontend ⭐

-Django Templates<br>
-Bootstrap 5 

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



PROJECT STRUCTURE:

1.config: This app will contain the main settings and configurations of the project, such as settings.py, urls.py, and wsgi.py.

2. websites: This app will handle the CRUD operations related to the websites. It will include models such as Site, WebsiteHistory, Location, etc. The views will handle the requests related to adding, updating, and deleting sites, as well as requesting and displaying scan results.

3. accounts: This app will handle user authentication and authorization. It will include models such as User, Group, and Permission. The views will handle user registration, login, and logout, as well as managing user accounts and permissions.

4. dashboard: This app will provide the dashboard views for each type of user. It will include views such as UnauthenticatedDashboard, AdministratorDashboard, and AuditorDashboard. Each dashboard will display different information based on the user type, such as the status of all sites for unauthenticated users, and the status of the administrator's own sites for administrators.

5. api: This app will provide the API views for the project, allowing external services to access and interact with the project data. It will include views such as SiteListAPIView and ScanResultCreateAPIView.

Autorizareweb/ # Main configuration and setting for app  
|-- config/  
| &nbsp;|-- __init__.py  
| &nbsp;|-- settings.py  
| &nbsp;|-- urls.py  
| &nbsp;|-- wsgi.py  
|-- websites/ # CRUD websites operations, scans, status    
| &nbsp;   |-- __init__.py  
| &nbsp;   |-- admin.py  
| &nbsp;   |-- apps.py  
| &nbsp;   |-- models.py  
| &nbsp;   |-- views.py  
| &nbsp;   |-- urls.py  
|-- accounts/   # Define user roles, authentification, permissions  
| &nbsp;   |-- __init__.py  
| &nbsp;   |-- admin.py  
| &nbsp;   |-- apps.py  
| &nbsp;   |-- models.py  
| &nbsp;   |-- views.py  
| &nbsp;   |-- urls.py  
|-- dashboard/   # Views and dashboards for different type of users (auditors, admins, normal users)  
| &nbsp;   |-- __init__.py  
| &nbsp;   |-- admin.py  
| &nbsp;   |-- apps.py  
| &nbsp;   |-- models.py  
| &nbsp;   |-- views.py  
| &nbsp;   |-- urls.py  

|-- manage.py  
