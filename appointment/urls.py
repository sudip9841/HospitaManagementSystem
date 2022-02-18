from django.urls import path
from appointment import views
from django.contrib.auth.decorators import login_required

urlpatterns=[
    path('',login_required(views.ScheduleAppointmentView.as_view()),name="scheduleAppointment")
]