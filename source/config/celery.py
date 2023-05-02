from __future__ import absolute_import
from celery import Celery
import os
from config.settings import get_secret

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
RUN_DOCKERIZED = os.environ.get('RUN_DOCKERIZED')

REDIS_HOST = 'redis' if RUN_DOCKERIZED else '127.0.0.1'
REDIS_PASSWD = get_secret('REDIS_PASSWD') or None
REDIS_PORT = 6379

broker_url = f'redis://:{REDIS_PASSWD}@{REDIS_HOST}:{REDIS_PORT}' if REDIS_PASSWD else f'redis://{REDIS_HOST}:{REDIS_PORT}'


class CeleryConfig:
    enable_utc = True
    timezone = 'Europe/Bucharest'
    broker_url = broker_url
    backend_url = broker_url
    # imports = ('upload.tasks', 'main.tasks')

celery_app = Celery(namespace='app')
celery_app.config_from_object(CeleryConfig)
celery_app.autodiscover_tasks()


# from celery.schedules import crontab

# app.conf.beat_schedule = {
# "Periodic DB backup task": {
#         "task": "main.tasks.task_copy_content_and_bd",
#         # At midnight & every two hours between 0800 & 1600
#         "schedule": crontab(minute='0', hour='0,8-16/4')
#         # "schedule": crontab(minute='*/2')
#     },
#     "Periodic check disk usage of vm": {
#         "task": "main.tasks.is_disk_memory_more_then_80_percent",
#         # Every day, the most active hours, and every 4 hour
#         "schedule": crontab(minute='0', hour='0, 4, 8, 9, 10, 11, 12, 16, 20')
#     }
# }