
from django.shortcuts import render, redirect
from django.views import View
from userAuth.forms import NonRegisteredPatientDetailsForm
from userAuth.models import NonRegisteredPatientDetails, StaffDetails, DoctorDetails
from appointment.forms import NonRegPatientAppointmentForm
from appointment.models import AppointmentBooking
import datetime
from django.contrib import messages


# Create your views here.


class BookAppointmentNonRegPatientView(View):
    
    def get(self,request,id):
        if request.user.groups.filter(name__in=['staff']).exists():
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


    def post(self,request,id):
        id = request.POST.get('id')
        doctorName = request.POST.get('doctorName')
        dObj = DoctorDetails.objects.get(fullName=doctorName)
        form = NonRegPatientAppointmentForm(request.POST)
        if form.is_valid():
            date = form.cleaned_data['appointmentDate']
            # date = datetime.datetime.strptime(date_str, "%Y-%m-%d").date()
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
            form.save()

        return redirect('/accounts/viewPatients/')