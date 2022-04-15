from django.urls import path
from mainApp import views
from django.conf.urls.static import static
from django.conf import settings


urlpatterns =[
    path('',views.displayHomePage,name='home'),
    path('finddoctor/',views.findDoctor,name='finddoctor'),
    path('finddoctor/doctor/<int:id>',views.doctorProfile,name="doctorprofile"),
    path('predictdiseases/',views.PredictDiseases.as_view(),name='predictdiseases'),
    path('aboutus/',views.AboutView.as_view(),name='aboutus')
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) 