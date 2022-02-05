from django.contrib import admin
from userAuth.models import PatientDetails, DoctorDetails, StaffDetails


@admin.register(PatientDetails)
class AdminPersonalDetails(admin.ModelAdmin):
    list_display = ['id','user','fullName','age','gender','phone','address','profile_pic']


@admin.register(DoctorDetails)
class AdminDoctorDetails(admin.ModelAdmin):
    list_display = ['id','user','fullName','age','gender','phone','address','department','experience','education','profile_pic']


@admin.register(StaffDetails)
class AdminDoctorDetails(admin.ModelAdmin):
    list_display = ['id','user','fullName','age','gender','phone','address','department','profile_pic'] 