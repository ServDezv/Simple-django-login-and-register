import warnings

warnings.simplefilter('error', DeprecationWarning)

DEBUG = True
ALLOWED_HOSTS = ['127.0.0.1', 'localhost']

RESTORE_PASSWORD_VIA_EMAIL_OR_USERNAME = False
ENABLE_ACTIVATION_AFTER_EMAIL_CHANGE = True

SERVER_EMAIL = 'admin@localhost'