from django.urls import path
from .views import *

urlpatterns = [
    path("add_site/", add_site_view, name="add_site"), 
    path("edit_site/<int:id>/", edit_site_view, name="edit_site"),
    path("remove_site/<int:id>/", remove_site_view, name="remove_site")
]
