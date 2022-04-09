
from django.shortcuts import render, redirect
from django.views import View
from graphviz import view
from userAuth.forms import NonRegisteredPatientDetailsForm
from userAuth.models import NonRegisteredPatientDetails, StaffDetails, DoctorDetails, PatientDetails
from appointment.forms import NonRegPatientAppointmentForm, RegPatientAppointmentForm
from appointment.models import AppointmentBooking
import datetime
from django.contrib import messages




#booking appointment view for the patient who doesnot have their account
class BookAppointmentNonRegPatientView(View):
    
    def get(self,request,id):
        if request.user.groups.filter(name__in=['staff']).exists():
            # currentTime = datetime.datetime.now()
            # print("current time",currentTime.hour)
            if id is not None:
                try:
                    nonRegPatient = NonRegisteredPatientDetails.objects.get(id=id)
                except:
                    return redirect('/accounts/viewPatients/')
                try:
                    p_prof = StaffDetails.objects.get(user=request.user)
                except:
                    p_prof=""
                
                form = NonRegPatientAppointmentForm()

                doctors = DoctorDetails.objects.all()
                d = {"p_prof":p_prof,'doctors':doctors,'nonRegPatient':nonRegPatient,'form':form}
                return render(request,'appointment/scheduleAppointment.html',d)
        
        return redirect('/')


    def post(self,request,id):
        id = request.POST.get('id')
        doctorName = request.POST.get('doctorName')
        appTime = request.POST.get('appointmentTime')
        print(appTime)
        currentTime = datetime.datetime.now()
        print("current time",currentTime.hour)

        dObj = DoctorDetails.objects.get(fullName=doctorName)
        form = NonRegPatientAppointmentForm(request.POST)
        if form.is_valid():
            date = form.cleaned_data['appointmentDate']
            todatDate = datetime.date.today()
            
            dateDiff = date-todatDate
            
            if(dateDiff.days<0 or dateDiff.days>6):
                messages.error(request,"The appoint date shouldnot be more than 6 days or less than from current date")
                try:
                    nonRegPatient = NonRegisteredPatientDetails.objects.get(id=id)
                except:
                    return redirect('/accounts/viewPatients/')
                try:
                    p_prof = StaffDetails.objects.get(user=request.user)
                except:
                    p_prof=""
                doctors = DoctorDetails.objects.all()
                d = {"p_prof":p_prof,'doctors':doctors,'nonRegPatient':nonRegPatient,'form':form}
                return render(request,'appointment/scheduleAppointment.html',d)


            appointmentTime= form.cleaned_data['appointmentTime']

            ap = AppointmentBooking.objects.filter(doctor=dObj,appointmentDate=date,appointmentTime=appointmentTime)

            #if there is already the appointment of the particular doctor on particular date and time then it will shows error message
            if ap:
                messages.error(request, "The appointment time is not available. Please choose the different date or time")
                try:
                    nonRegPatient = NonRegisteredPatientDetails.objects.get(id=id)
                except:
                    return redirect('/accounts/viewPatients/')
                try:
                    p_prof = StaffDetails.objects.get(user=request.user)
                except:
                    p_prof=""
                doctors = DoctorDetails.objects.all()
                d = {"p_prof":p_prof,'doctors':doctors,'nonRegPatient':nonRegPatient,'form':form}
                return render(request,'appointment/scheduleAppointment.html',d)

        if form.is_valid():
            form.instance.nonRegisteredPatient = NonRegisteredPatientDetails.objects.get(id=id)
            form.instance.doctor = DoctorDetails.objects.get(fullName=doctorName)
            form.instance.paymentStatus = "paid"
            form.save()

        return redirect('/accounts/viewPatients/')


# class view for booking an appointment fo registered patients 
class BookAppointmentRegisteredUser(View):

    def get(self,request):
        if request.user.groups.filter(name__in=['patient']).exists():
                try:
                    regPatient = PatientDetails.objects.get(user=request.user)
                    p_prof = PatientDetails.objects.get(user=request.user)
                except:
                    messages.error(request,"please fillup the user details form before booking an appointment")
                    return redirect('/accounts/editprofile')
                
                form = RegPatientAppointmentForm()

                doctors = DoctorDetails.objects.all()
                d = {"p_prof":p_prof,'doctors':doctors,'nonRegPatient':regPatient,'form':form}
                return render(request,'appointment/registeredUserAppointment.html',d)
        
        return redirect('/')

    
    def post(self,request):
        doctorName = request.POST.get('doctorName')
        dObj = DoctorDetails.objects.get(fullName=doctorName)
        form = RegPatientAppointmentForm(request.POST)
        if form.is_valid():
            date = form.cleaned_data['appointmentDate']
            todatDate = datetime.date.today()
            
            dateDiff = date-todatDate
            
            if(dateDiff.days<0 or dateDiff.days>6):
                messages.error(request,"The appoint date shouldnot be more than 6 days or less than from current date")
                try:
                    p_prof = PatientDetails.objects.get(user=request.user)
                except:
                    p_prof=""
                doctors = DoctorDetails.objects.all()
                d = {"p_prof":p_prof,'doctors':doctors,'form':form}
                return render(request,'appointment/registeredUserAppointment.html',d)

            appointmentTime= form.cleaned_data['appointmentTime']

            ap = AppointmentBooking.objects.filter(doctor=dObj,appointmentDate=date,appointmentTime=appointmentTime)

            #if there is already the appointment of the particular doctor on particular date and time then it will shows error message
            if ap:
                messages.error(request, "The appointment time is not available. Please choose the different date or time")
              
                try:
                    p_prof = PatientDetails.objects.get(user=request.user)
                except:
                    p_prof=""
                doctors = DoctorDetails.objects.all()
                d = {"p_prof":p_prof,'doctors':doctors,'form':form}
                return render(request,'appointment/registeredUserAppointment.html',d)

        if form.is_valid():
            form.instance.patient = PatientDetails.objects.get(user=request.user)
            form.instance.doctor = DoctorDetails.objects.get(fullName=doctorName)
            form.instance.paymentStatus = "pending"
            form.save()

        return redirect('/scheduleAppointment/myappointments')


class MyAppointment(View):
    def get(self,request):

        try:
            pd = PatientDetails.objects.get(user=request.user)
        except:
            messages.error(request,"please fillup the user details form before viewing appointments")
            return redirect('/accounts/editprofile')
        myAppointments = AppointmentBooking.objects.all().filter(patient=pd)

        try:
            p_prof = PatientDetails.objects.get(user=request.user)
        except:
            p_prof=""

        
        d = {'myAppointments':myAppointments,'p_prof':p_prof}
        return render(request,'appointment/myappointments.html',d)


def deleteUserAppointment(request,id):
    if request.user.groups.filter(name__in=['patient']).exists():
        if id is not None:
            app_id = id
            patient = PatientDetails.objects.get(user=request.user)
            
            appointment = AppointmentBooking.objects.get(id=app_id)
           

            if patient.user == appointment.patient.user:
                appointment.delete()
                return redirect('/scheduleAppointment/myappointments')
            return redirect('/scheduleAppointment/myappointments')
        return redirect('/scheduleAppointment/myappointments')
    
    return redirect('/')






