from django.contrib import admin
from appointment.models import AppointmentBooking

# Register your models here.

@admin.register(AppointmentBooking)
class AdminAppointmentBooking(admin.ModelAdmin):
    list_display = ["id","patient","nonRegisteredPatient","doctor","appointmentDate","appointmentTime","appointmentStatus","paymentStatus"]