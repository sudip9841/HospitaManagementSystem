import imp
from django.shortcuts import render, redirect
from django.views import View
from userAuth.forms import UserCreationForm, UserRegistrationForm
from django.contrib import messages
from userAuth.forms import PersonalDetailsForm
from userAuth.models import PersonalDetails
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import Group
# Create your views here.


@login_required
def getUserDashboard(request):
        try:
            prof = PersonalDetails.objects.get(user=request.user)
            return render(request,'userAuth/userDashHome.html',{'prof':prof})
        except:
            return render(request,'userAuth/userDashHome.html',{})
   

class UserRegistrationView(View):
    def get(self,request):
        registrationForm = UserRegistrationForm()
        return render(request, 'userAuth/signup.html',{'form':registrationForm})
    
    def post(self,request):
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            group = Group.objects.get(name='patient')
            group.user_set.add(user)
            messages.success(request, "User registered sucessfully")
        return render(request, 'userAuth/signup.html',{'form':form})


class EditProfile(View):

    def get(self,request):
        try:
            prof = PersonalDetails.objects.get(user=request.user)
            fullName = prof.fullName
            age = prof.age
            sex = prof.sex
            phone = prof.phone
            address = prof.address
            profile_pic = prof.profile_pic
            form = PersonalDetailsForm(initial={'fullName':fullName,'age':age,'sex':sex,'phone':phone,'address':address, 'profile_pic': profile_pic})
        except:
            form = PersonalDetailsForm()

        d = {'form':form}
        return render(request,'userAuth/editprofile.html',d)

    
    def post(self,request):
        try:
            profile = PersonalDetails.objects.get(user=request.user)
            form = PersonalDetailsForm(request.POST, request.FILES, instance=profile)
            if form.is_valid():
                form.save()
        except:
            form = PersonalDetailsForm(request.POST, request.FILES)
            if form.is_valid():
                form.instance.user = request.user #addong foreign key currente user instance to Profile model
                form.save()
        
        return redirect('/accounts/editprofile/')