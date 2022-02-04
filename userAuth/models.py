from statistics import mode
from django.db import models
from django.contrib.auth.models import User

GENDER_CHOICES = (
    ('M','Male'),
    ('F','Female'),
    ('O','Others'),
)

TYPE_CHOICES = (
    ('D','Doctor'),
    ('N','Nurse'),
    ('S','Staff'),
)

class PersonalDetails(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    fullName = models.CharField(max_length=50)
    age = models.PositiveIntegerField()
    sex = models.CharField(choices=GENDER_CHOICES, max_length=10)
    phone = models.BigIntegerField()
    address = models.CharField(max_length=50)
    department = models.CharField(max_length=50, blank=True, null=True)
    profile_pic = models.ImageField(upload_to='profilepic', blank=True, null=True)


