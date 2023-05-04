from django.urls import path
from .views import *

urlpatterns = [
    path("dashboard/", dashboard_view, name="dashboard"), # Template taht should have the map and sites 
    path("dashboard/administator/my_sites/", adminisistrator_sites_view, name="adminisistrator_sites"),
    path("dashboard/auditor/sites/", auditor_sites_view, name="auditor_sites"),
]
