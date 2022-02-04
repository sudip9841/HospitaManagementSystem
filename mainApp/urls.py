from django.urls import path
from mainApp import views
from django.conf.urls.static import static
from django.conf import settings

urlpatterns =[
    path('',views.displayHomePage,name='home')
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) 