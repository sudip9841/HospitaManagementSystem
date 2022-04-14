
from django import views
from django.shortcuts import render, redirect
from django.views import View
import appointment
from userAuth.forms import  UserRegistrationForm
from django.contrib import messages
from userAuth.forms import PatientDetailsForm, DoctorDetailsForm, StaffDetailsForm, NonRegisteredPatientDetailsForm,TestReportForm
from userAuth.models import GENDER_CHOICES, PatientDetails, DoctorDetails, StaffDetails, NonRegisteredPatientDetails, TestReport
from appointment.models import AppointmentBooking
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth.models import Group
import datetime
from datetime import timedelta
from django.utils import timezone
from reportlab.pdfgen import canvas

# Create your views here.

def printReport(patientName,doctorName):
    pass


@login_required
def getUserDashboard(request):
        try:
            if request.user.groups.filter(name__in=['patient']).exists():
                p_prof = PatientDetails.objects.get(user=request.user)

                return render(request,'userAuth/userDashHome.html',{'p_prof':p_prof})

            elif request.user.groups.filter(name__in=['doctor']).exists():
                d_prof = DoctorDetails.objects.get(user=request.user)

                return render(request,'userAuth/userDashHome.html',{'d_prof':d_prof}) 
            
            elif request.user.groups.filter(name__in=['staff']).exists():
                s_prof = StaffDetails.objects.get(user=request.user)

                return render(request,'userAuth/userDashHome.html',{'s_prof':s_prof}) 
        except:
            # print(datetime.date)
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
        #if the active user is patient
        if request.user.groups.filter(name__in=['patient']).exists():
            try:
                prof = PatientDetails.objects.get(user=request.user)
                fullName = prof.fullName
                age = prof.age
                gender = prof.gender
                phone = prof.phone
                address = prof.address
                profile_pic = prof.profile_pic
                form = PatientDetailsForm(initial={'fullName':fullName,'age':age,'gender':gender,'phone':phone,'address':address, 'profile_pic': profile_pic})
            except:
                form = PatientDetailsForm()

            
            try:
                p_prof = PatientDetails.objects.get(user=request.user)
            except:
                p_prof=""

            d = {'form':form,'p_prof':p_prof}
            return render(request,'userAuth/editprofile.html',d)


        elif request.user.groups.filter(name__in=['doctor']).exists():
            try:
                prof = DoctorDetails.objects.get(user=request.user)
                fullName = prof.fullName
                age = prof.age
                gender = prof.gender
                phone = prof.phone
                address = prof.address
                department = prof.department
                experience = prof.experience
                education = prof.education
                profile_pic = prof.profile_pic
                form = DoctorDetailsForm(initial={'fullName':fullName,'age':age,'gender':gender,'phone':phone,'address':address,'department':department,'experience':experience,'education':education, 'profile_pic': profile_pic})
            except:
                form = DoctorDetailsForm()
            
    
            try:
                d_prof = DoctorDetails.objects.get(user=request.user)
            except:
                d_prof=""

            d = {'form':form,'d_prof':d_prof}

            return render(request,'userAuth/editprofile.html',d)


        elif request.user.groups.filter(name__in=['staff']).exists():
            try:
                prof = StaffDetails.objects.get(user=request.user)
                fullName = prof.fullName
                age = prof.age
                gender = prof.gender
                phone = prof.phone
                address = prof.address
                department = prof.department
                profile_pic = prof.profile_pic
                form = StaffDetailsForm(initial={'fullName':fullName,'age':age,'gender':gender,'phone':phone,'address':address,'department':department,'profile_pic': profile_pic})
            except:
                form = StaffDetailsForm()

            try:
                s_prof = StaffDetails.objects.get(user=request.user)
            except:
                s_prof=""

            d = {'form':form,'s_prof':s_prof}

            return render(request,'userAuth/editprofile.html',d)
        

    
    def post(self,request):
        if request.user.groups.filter(name__in=['patient']).exists():
            try:
                profile = PatientDetails.objects.get(user=request.user)
                form = PatientDetailsForm(request.POST, request.FILES, instance=profile)
                if form.is_valid():
                    form.save()
            except:
                form = PatientDetailsForm(request.POST, request.FILES)
                if form.is_valid():
                    form.instance.user = request.user #adding foreign key currente user instance to Profile model
                    form.save()


        elif request.user.groups.filter(name__in=['doctor']).exists():
            try:
                profile = DoctorDetails.objects.get(user=request.user)
                form = DoctorDetailsForm(request.POST, request.FILES, instance=profile)
                if form.is_valid():
                    form.save()
            except:
                form = DoctorDetailsForm(request.POST, request.FILES)
                if form.is_valid():
                    form.instance.user = request.user #adding foreign key currente user instance to Profile model
                    form.save()

        
        elif request.user.groups.filter(name__in=['staff']).exists():
            try:
                profile = StaffDetails.objects.get(user=request.user)
                form = StaffDetailsForm(request.POST, request.FILES, instance=profile)
                if form.is_valid():
                    form.save()
            except:
                form = StaffDetailsForm(request.POST, request.FILES)
                if form.is_valid():
                    form.instance.user = request.user #adding foreign key currente user instance to Profile model
                    form.save()
            
        return redirect('/accounts/editprofile/')



class AddNonRegisterPatientView(View):
    def get(self,request):
        form = NonRegisteredPatientDetailsForm()
        try:
            p_prof = StaffDetails.objects.get(user=request.user)
        except:
            p_prof=""

        d = {"p_prof":p_prof,'form':form,'sAddPatient':'custom-active'}
        return render(request,'userAuth/addNonRegisterPatient.html',d)
    
    def post(self,request):
        form = NonRegisteredPatientDetailsForm(request.POST)
        try:
            p_prof = StaffDetails.objects.get(user=request.user)
        except:
            p_prof=""

        if form.is_valid():
            form.save()
            # return redirect(request,'/viewPatients/')
            messages.success(request, "User Added sucessfully sucessfully")
            form = NonRegisteredPatientDetailsForm()
        d = {"p_prof":p_prof,'form':form,'sAddPatient':'custom-active'}
        return render(request,'userAuth/addNonRegisterPatient.html',d)



class ViewPatientsView(View):
    def get(self,request):
        
        try:
            p_prof = StaffDetails.objects.get(user=request.user)
        except:
            p_prof=""

        try:
            nPatientDetails = NonRegisteredPatientDetails.objects.all()
            d = {'nPatientDetails':nPatientDetails}
        except:
            pass
            d ={}
        d['p_prof'] = p_prof
        d['sViewPatientActive'] = "custom-active"
        return render(request,'userAuth/viewPatients.html',d)


@login_required
def deleteNonRegUser(request,id):
    if request.user.groups.filter(name__in=['staff']).exists():
        if id is not None:
            try:
                u = NonRegisteredPatientDetails.objects.get(id=id)
                u.delete()
                return redirect('/accounts/viewPatients/')
            except:
                return redirect('/accounts/viewPatients/')

    return redirect('/')

class UpdateNonRegUserView(View):
    def get(self,request,id):

        if request.user.groups.filter(name__in=['staff']).exists():
            if id is not None:
                try:
                    nonRegPatient = NonRegisteredPatientDetails.objects.get(id=id)
                    fullName = nonRegPatient.fullName
                    age = nonRegPatient.age
                    gender = nonRegPatient.gender
                    phone = nonRegPatient.phone
                    address = nonRegPatient.address
                    id = nonRegPatient.id

                    form = NonRegisteredPatientDetailsForm(initial={'fullName':fullName,'age':age,'gender':gender,'phone':phone,'address':address})
                    try:
                        d_prof = StaffDetails.objects.get(user=request.user)
                    except:
                        d_prof=""
                    d = {'form':form,'d_prof':d_prof,'id':id}

                    return render(request,'userAuth/updateNonRegisterPatient.html',d)
                except:
                    return redirect('/accounts/viewPatients/')
        return redirect('/')
    

    def post(self,request,id):
        id = request.POST['id']
        npd = NonRegisteredPatientDetails.objects.get(id=id)
        form = NonRegisteredPatientDetailsForm(request.POST, instance=npd)

        if form.is_valid():
            form.save()
            return redirect('/accounts/viewPatients/')
        try:
            d_prof = StaffDetails.objects.get(user=request.user)
        except:
            d_prof=""
        d = {'form':form,'d_prof':d_prof,'id':id}

        return render(request,'userAuth/updateNonRegisterPatient.html',d)


class ViewDoctorLists(View):
    def get(self,request):
        if request.user.groups.filter(name__in=['staff']).exists():
            doctors = DoctorDetails.objects.all()
            try:
                d_prof = StaffDetails.objects.get(user=request.user)
            except:
                d_prof=""
            d = {'d_prof':d_prof,'doctors':doctors,'sViewDoctorActive':'custom-active'}

            return render(request,'userAuth/viewDoctors.html',d)

        return redirect('/')

class ViewDoctorAppointment(View):
    def get(self,request,id,day):
        if request.user.groups.filter(name__in=['staff']).exists():
            if id is not None and ((day <=7 and day>=1) and day is not None):
                try:
                    p_prof = StaffDetails.objects.get(user=request.user)
                except:
                    p_prof=""
                # tomorrow = datetime.datetime.now() + timedelta(days=2)
                # tomorrowAppointment = AppointmentBooking.objects.all().filter(appointmentDate=tomorrow)
                # print(tomorrowAppointment)
                # print(tomorrow.day - datetime.datetime.now().day)
                date = datetime.datetime.now() + timedelta(days=day-1)
                try:
                    todayAppointment = AppointmentBooking.objects.all().filter(appointmentDate=date,doctor=DoctorDetails.objects.get(id=id)).order_by('appointmentTime')
                except:
                    return redirect("/")
                if request.user.groups.filter(name__in=['staff']).exists():
                    doctor = DoctorDetails.objects.get(id=id)
                
                    d = {'doctor':doctor,'p_prof':p_prof,'todayAppointment':todayAppointment}

                    return render(request,'userAuth/viewDoctorAppointment.html',d)

                return redirect('/')

            return redirect('/')
            
        return redirect('/')


class ViewDoctorMyAppointment(View):
    def get(self,request,day):
        if request.user.groups.filter(name__in=['doctor']).exists():
            if day <=7 and day is not None:
                try:
                    p_prof = DoctorDetails.objects.get(user=request.user)
                except:
                    p_prof=""
                date = datetime.datetime.now() + timedelta(days=day-1)
                try:
                    todayAppointment = AppointmentBooking.objects.all().filter(appointmentDate=date,doctor=DoctorDetails.objects.get(user=request.user)).order_by('appointmentTime')
                except:
                    return redirect("/")

                d = {'p_prof':p_prof,'todayAppointment':todayAppointment}

                return render(request,'userAuth/viewDoctorMyAppointment.html',d)
                
            return redirect('/')

        return redirect('/')



class ViewPatientProfile(View):
    def get(self,request,id):
      if request.user.groups.filter(name__in=['doctor']).exists() | request.user.groups.filter(name__in=['staff']).exists():
            form = TestReportForm()
            try:
                patientObj = PatientDetails.objects.get(id=id)
            except:
                return redirect('/')
            if request.user.groups.filter(name__in=['doctor']).exists():
                try:
                    p_prof = DoctorDetails.objects.get(user=request.user)
                except:
                    p_prof=""
            else:
                try:
                    p_prof = StaffDetails.objects.get(user=request.user)
                except:
                    p_prof=""
            
            try:
                testReports = TestReport.objects.all().filter(patient=patientObj).order_by('-testDate')
            except:
                testReports=""
           
            d = {'p_prof':p_prof,'patient':patientObj,'testReports':testReports,'form':form}
            return render(request,'userAuth/patientProfile.html',d)


      return redirect('/')    

    def post(self,request,id):
        if request.user.groups.filter(name__in=['staff']).exists():
            form = TestReportForm(request.POST, request.FILES)
            if form.is_valid():
                patId = request.POST.get('patientId')
                patObj = PatientDetails.objects.get(id=patId)
                form.instance.patient = patObj
                form.save()
                return redirect("/accounts/patientProfile/{}".format(id))

        return redirect('/')
        


class ViewAllRegPatients(View):
    def get(self,request):

        if request.user.groups.filter(name__in=['staff']).exists():

            try:
                p_prof = StaffDetails.objects.get(user=request.user)
            except:
                p_prof=""

            try:
                nPatientDetails = PatientDetails.objects.all()
                d = {'nPatientDetails':nPatientDetails}
            except:
                pass
                d ={}
            d['p_prof'] = p_prof
            d['sViewRegPatientActive'] = "custom-active"
            return render(request,'userAuth/viewRegPatients.html',d)
        
        return redirect('/')


class ViewTestReport(View):
    def get(self,request):

        if request.user.groups.filter(name__in=['patient']).exists():
            try:
                patientObj = PatientDetails.objects.get(user = request.user)
            except:
                messages.error(request,"please fillup the user details form before viewing appointments")
                return redirect('/accounts/editprofile')
            
            testReports = TestReport.objects.all().filter(patient=patientObj).order_by('-testDate')
            try:
                p_prof = PatientDetails.objects.get(user=request.user)
            except:
                p_prof=""

            d = {'p_prof':p_prof,'testReports':testReports}

            return render(request,'userAuth/testresults.html',d)

        
        return redirect('/')


@login_required
def deleteReport(request,id,uid):
    if request.user.groups.filter(name__in=['staff']).exists():
        if id is not None:
            try:
                u = TestReport.objects.get(id=id)
                u.delete()
                return redirect('/accounts/patientProfile/{}'.format(uid))
            except:
                return redirect('accounts/viewRegPatients')
        return redirect('/')

    return redirect('/')


@login_required
def clearDue(request,id,dId):
    if request.user.groups.filter(name__in=['staff']).exists():
        if id is not None and dId is not None:
            try:
                appointment = AppointmentBooking.objects.get(id=id)
                appointment.paymentStatus='paid'
                appointment.save()
                return redirect('/accounts/viewDoctorAppointment/{}/1'.format(dId))
            except:
                return redirect('/accounts/viewDoctorAppointment/{}/1'.format(dId))

        return redirect('/accounts/viewDoctorAppointment/{}/1'.format(dId))
    return redirect('/')


@login_required
def cancelAppointment(request,id,dId):
    if request.user.groups.filter(name__in=['staff']).exists():
        if id is not None and dId is not None:
            try:
                appointment = AppointmentBooking.objects.get(id=id)
                appointment.delete()
                return redirect('/accounts/viewDoctorAppointment/{}/1'.format(dId))
            except:
                return redirect('/accounts/viewDoctorAppointment/{}/1'.format(dId))

        return redirect('/accounts/viewDoctorAppointment/{}/1'.format(dId))
    return redirect('/')




        








