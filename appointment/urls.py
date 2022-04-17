from django.urls import path
from appointment import views
from django.contrib.auth.decorators import login_required

urlpatterns=[
    path('bookAppointment/<int:id>',login_required(views.BookAppointmentNonRegPatientView.as_view()),name="bookAppointmentNonReg"),
    path('bookreguserappointment',login_required(views.BookAppointmentRegisteredUser.as_view()),name="bookreguserappointment"),
    path('myappointments',login_required(views.MyAppointment.as_view()),name="myappointments"),
    path('deleteuserappointment/<int:id>',views.deleteUserAppointment,name="deleteuserappointment"),
    path('api/verify_payment',views.verify_payment,name='verify_payment'),
    path('printinvoice/<int:id>',views.printInvoice,name='printinvoice')
]