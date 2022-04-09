from django.contrib import admin
from userAuth.models import PatientDetails, DoctorDetails, StaffDetails,NonRegisteredPatientDetails, TestReport


@admin.register(PatientDetails)
class AdminPersonalDetails(admin.ModelAdmin):
    list_display = ['id','user','fullName','age','gender','phone','address','profile_pic']


@admin.register(DoctorDetails)
class AdminDoctorDetails(admin.ModelAdmin):
    list_display = ['id','user','fullName','age','gender','phone','address','department','experience','education','profile_pic']


@admin.register(StaffDetails)
class AdminDoctorDetails(admin.ModelAdmin):
    list_display = ['id','user','fullName','age','gender','phone','address','department','profile_pic'] 


@admin.register(NonRegisteredPatientDetails)
class AdminNonRegisteredPersonalDetails(admin.ModelAdmin):
    list_display = ['id','fullName','age','gender','phone','address']


@admin.register(TestReport)
class AdminTestReport(admin.ModelAdmin):
    list_display = ['id','patient','testName','testDate','testPic']