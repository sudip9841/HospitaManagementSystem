from django.contrib import admin
from userAuth.models import PersonalDetails


@admin.register(PersonalDetails)
class AdminPersonalDetails(admin.ModelAdmin):
    list_display = ['id','user','fullName','age','sex','phone','address','department','profile_pic']
