from statistics import mode
from django.db import models
from django.contrib.auth.models import User

GENDER_CHOICES = (
    ('M','Male'),
    ('F','Female'),
    ('O','Others'),
)

DOCTOR_DEPARTMENT_CHOICES = (
    ('neurosciences','neurosciences'),
    ('cardiovascular-medicine','cardiovascular-medicine'),
    ('pulmonology','pulmonology'),
    ('obstetrics-and-gynecology','obstetrics-and-gynecology'),
    ('orthopaedics','orthopaedics'),
    ('oncolog','oncolog'),
    ('dermatology','dermatology'),
    ('diabetes-and-endocrinology','diabetes-and-endocrinology'),
    ('ear-nose-throat-ent','ear-nose-throat-ent'),
    ('eye-care','eye-care'),
    ('gastroenterology','gastroenterology'),
    ('nutrition-and-dietetic','nutrition-and-dietetic'),
    ('nephrology','nephrology'),
    ('physiotherapy','physiotherapy'),
    ('urology','urology'),
)

STAFF_DEPARTMENT_CHOICES = (
    ('cashier','cashier'),
    ('call-center','call-center'),
)

#for patient
class PatientDetails(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    fullName = models.CharField(max_length=50)
    age = models.PositiveIntegerField()
    gender = models.CharField(choices=GENDER_CHOICES, max_length=10)
    phone = models.BigIntegerField()
    address = models.CharField(max_length=50)
    profile_pic = models.ImageField(upload_to='profilepic', blank=True, null=True)



#for doctor
class DoctorDetails(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    fullName = models.CharField(max_length=50)
    age = models.PositiveIntegerField()
    gender = models.CharField(choices=GENDER_CHOICES, max_length=10)
    phone = models.BigIntegerField()
    address = models.CharField(max_length=50)
    department = models.CharField(choices=DOCTOR_DEPARTMENT_CHOICES, max_length=50)
    experience =models.TextField()
    education = models.TextField()
    profile_pic = models.ImageField(upload_to='doctorprofilepic', blank=True, null=True)


#for staff
class StaffDetails(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    fullName = models.CharField(max_length=50)
    age = models.PositiveIntegerField()
    gender = models.CharField(choices=GENDER_CHOICES, max_length=10)
    phone = models.BigIntegerField()
    address = models.CharField(max_length=50)
    department = models.CharField(choices=STAFF_DEPARTMENT_CHOICES, max_length=50)
    profile_pic = models.ImageField(upload_to='staffprofilepic', blank=True, null=True)


