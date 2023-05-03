import os
import json
from django.core.exceptions import ImproperlyConfigured
from os.path import dirname

BASE_DIR = dirname(dirname(os.path.abspath(__file__)))
CONTENT_DIR = os.path.join(BASE_DIR, 'content')

RUN_DOCKERIZED = os.environ.get('RUN_DOCKERIZED')
IS_PRODUCTION = os.environ.get('IS_PRODUCTION')

if IS_PRODUCTION:
    from .conf.production.settings import *
else:
    from .conf.development.settings import *

with open(os.path.join(BASE_DIR, 'secrets.json')) as secrets_file:
    secrets = json.load(secrets_file)

def get_secret(setting, secrets_dict=secrets):
    """Get secret setting or fail with ImproperlyConfigured"""
    try:
        return secrets_dict[setting]
    except KeyError:
        raise ImproperlyConfigured("Set the {} setting".format(setting))
    
SECRET_KEY = get_secret('PROD_SECRET_KEY') if IS_PRODUCTION else get_secret('DEV_SECRET_KEY')

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    # Vendor apps
    'bootstrap4',
    # 'crispy_forms',
    # 'rest_framework',

    # Application apps
    'main',
    'accounts',
    'websites',
    'dashboard',
    'config'
]

ROOT_URLCONF = 'config.urls'
WSGI_APPLICATION = 'config.wsgi.application'

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(CONTENT_DIR, 'templates'),
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                # 'app.context_processors.equipments_links',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# TODO: Use something similar to use Docker secrets
# POSTGRES_PASSWORD_FILE = os.environ.get('POSTGRES_PASSWORD_FILE', default=None)
# POSTGRES_PASSWORD = None
# if POSTGRES_PASSWORD_FILE:
#     with open(POSTGRES_PASSWORD_FILE) as pwdFileHandle:
#         POSTGRES_PASSWORD = pwdFileHandle.read()
#         print("***********", POSTGRES_PASSWORD)

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('POSTGRES_NAME'),
        'USER': os.environ.get('POSTGRES_USER'),
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD'),
        'TIME_ZONE': 'Europe/Bucharest',
        'HOST': 'db_postgres',
        'PORT': '5432'
    } if RUN_DOCKERIZED else {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        'TIME_ZONE': 'Europe/Bucharest'
    }
}

DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'
MESSAGE_STORAGE = 'django.contrib.messages.storage.cookie.CookieStorage'

ENABLE_USER_ACTIVATION = True
DISABLE_USERNAME = False
LOGIN_VIA_EMAIL = False
LOGIN_VIA_EMAIL_OR_USERNAME = True
LOGIN_REDIRECT_URL = '/'
LOGIN_URL = 'accounts:log_in'
USE_REMEMBER_ME = False

# Session security settings
SESSION_COOKIE_AGE = 60 * 60  # This sets the expiry time of the session cookie to 3600 seconds (1 HOUR)
SESSION_COOKIE_SECURE = True  # Tells the browser to ensure the session cookie is only sent under an HTTPS connection (anti-sniffing)
SESSION_SAVE_EVERY_REQUEST = True  # This resets timeout counter for the session cookie on every new request (only expire request after 1h of inactivity)

SIGN_UP_FIELDS = ['first_name', 'last_name', 'email', 'password1', 'password2']
if DISABLE_USERNAME:
    SIGN_UP_FIELDS = ['first_name', 'last_name', 'email', 'password1', 'password2']

USE_I18N = False
USE_L10N = False
LANGUAGE_CODE = 'en'
USE_TZ = True
TIME_ZONE = 'Europe/Bucharest'

STATIC_ROOT = os.path.join(CONTENT_DIR, 'static')
STATIC_URL = '/static/'

MEDIA_ROOT = os.path.join(CONTENT_DIR, 'media')
USERS_MEDIA_ROOT = os.path.join(CONTENT_DIR, 'users_media')
MEDIA_URL = '/media/'

STATICFILES_DIRS = [
    os.path.join(CONTENT_DIR, 'assets'),
]

### Mail settings
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
# EMAIL_HOST = get_email('EMAIL_HOST')
# EMAIL_PORT = get_email('EMAIL_PORT')
# DEFAULT_FROM_EMAIL = get_email('DEFAULT_FROM_EMAIL')
# STAFF_RECIPIENT_ADDR = get_secret('STAFF_RECIPIENT_ADDR_PROD') if IS_PRODUCTION else get_secret(
#     'STAFF_RECIPIENT_ADDR_DEV')
EMAIL_USE_TLS = False


### Private storage settings
# INSTALLED_APPS += (
#     'private_storage',
# )

# PRIVATE_STORAGE_FOLDER = 'users_media'
# PRIVATE_STORAGE_ROOT = os.path.join(CONTENT_DIR, PRIVATE_STORAGE_FOLDER)
# PRIVATE_STORAGE_AUTH_FUNCTION = 'upload.models.is_superuser_or_staff_or_owner'  # Custom auth function based on suepruser + staff + current user

# Logging settings
LOGS_DIR = os.path.join(BASE_DIR, 'logs')
# LOGGING = {
#     'version': 1,
#     'disable_existing_loggers': False,
#     'formatters': {
#         'verbose': {
#             'format': '{levelname} {asctime} {module} {message}',
#             'style': '{',
#         },
#         'simple': {
#             'format': '{levelname} {message}',
#             'style': '{',
#         },
#     },
#     'handlers': {
#         'debug_handler': {
#             'level': 'DEBUG',
#             'class': 'logging.FileHandler',
#             'filename': os.path.join(LOGS_DIR, 'debug.log'),
#             'formatter': 'verbose'
#         },
#         'accounts_handler': {
#             'level': 'INFO',
#             'class': 'logging.FileHandler',
#             'filename': os.path.join(LOGS_DIR, 'accounts.log'),
#             'formatter': 'verbose'
#         },
#         'upload_handler': {
#             'level': 'INFO',
#             'class': 'logging.FileHandler',
#             'filename': os.path.join(LOGS_DIR, 'upload.log'),
#             'formatter': 'verbose'
#         },
#         'celery_tasks_handler': {
#             'level': 'INFO',
#             'class': 'logging.FileHandler',
#             'filename': os.path.join(LOGS_DIR, 'celery_tasks.log'),
#             'formatter': 'verbose'
#         },
#         'celery_beat_handler': {
#             'level': 'INFO',
#             'class': 'logging.FileHandler',
#             'filename': os.path.join(LOGS_DIR, 'celery_beat.log'),
#             'formatter': 'verbose'
#         },
#         'mail_admins': {
#             'level': 'ERROR',
#             'class': 'django.utils.log.AdminEmailHandler'
#         }
#     },
#     'loggers': {
#         'django': {
#             'handlers': ['debug_handler'],
#             'level': 'DEBUG',
#             'propagate': True,
#         },
#         'accounts': {
#             'handlers': ['accounts_debug_handler'],
#             'level': 'DEBUG',
#             'propagate': True,
#         },
#         'accounts': {
#             'handlers': ['accounts_handler'],
#             'level': 'INFO',
#             'propagate': True,
#         },
#         'upload': {
#             'handlers': ['upload_debug_handler'],
#             'level': 'DEBUG',
#             'propagate': True,
#         },
#         'upload': {
#             'handlers': ['upload_handler'],
#             'level': 'INFO',
#             'propagate': True,
#         },
#         'celery_tasks': {
#             'handlers': ['celery_tasks_handler'],
#             'level': 'INFO',
#             'propagate': True,
#         },
#         'celery_beat': {
#             'handlers': ['celery_beat_handler'],
#             'level': 'INFO',
#             'propagate': True,
#         },
#     }
# }

