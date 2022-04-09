from statistics import mode
from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MaxValueValidator, MinValueValidator

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

    def __Str__(self):
        return self.fullName



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

    def __Str__(self):
        return self.fullName


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

    def __Str__(self):
        return self.fullName


#for non registered patient
class NonRegisteredPatientDetails(models.Model):
    fullName = models.CharField(max_length=50)
    age = models.PositiveIntegerField()
    gender = models.CharField(choices=GENDER_CHOICES, max_length=10)
    phone = models.BigIntegerField(unique=True)
    address = models.CharField(max_length=50)

    def __Str__(self):
        return self.phone


class TestReport(models.Model):
    patient = models.ForeignKey(PatientDetails, on_delete=models.CASCADE,blank=True,null=True)
    testName = models.CharField(max_length=100)
    testDate = models.DateTimeField(auto_now_add=True)
    testPic = models.ImageField(upload_to='testReport')



