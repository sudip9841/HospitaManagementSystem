from django.urls import path
from appointment import views
from django.contrib.auth.decorators import login_required

urlpatterns=[
    path('bookAppointment/<int:id>',login_required(views.BookAppointmentNonRegPatientView.as_view()),name="bookAppointmentNonReg"),
    path('bookreguserappointment',login_required(views.BookAppointmentRegisteredUser.as_view()),name="bookreguserappointment"),
    path('myappointments',login_required(views.MyAppointment.as_view()),name="myappointments")

]