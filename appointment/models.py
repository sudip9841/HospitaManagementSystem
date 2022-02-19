from django.db import models
from userAuth.models import PatientDetails, DoctorDetails, NonRegisteredPatientDetails

TIME_CHOICES = (
    (10,10),
    (11,11),
    (12,12),
    (1,1),
    (3,3),
    (4,4),
    (5,5),
    (6,6)
)

APPOINTMENT_STATUS_CHOICES = (
    ('booked','booked'),
    ('canceled','canceled')
)

PAYMENT_STATUS_CHOICES = (
    ('pending','pending'),
    ('paid','paid')
)



class AppointmentBooking(models.Model):
    patient = models.ForeignKey(PatientDetails, on_delete=models.CASCADE,blank=True,null=True)
    nonRegisteredPatient = models.ForeignKey(NonRegisteredPatientDetails, on_delete=models.CASCADE, blank=True,null=True)
    doctor = models.ForeignKey(DoctorDetails,on_delete=models.CASCADE)
    appointmentDate = models.DateField()
    appointmentTime = models.IntegerField(choices=TIME_CHOICES)
    appointmentStatus = models.CharField(choices=APPOINTMENT_STATUS_CHOICES, max_length=20, default="booked")
    paymentStatus = models.CharField(choices=PAYMENT_STATUS_CHOICES,max_length=20, default="pending")






