from django.shortcuts import render, redirect
from django.views import View
from userAuth.models import StaffDetails, DoctorDetails

# Create your views here.


class ScheduleAppointmentView(View):
    def get(self,request):

        try:
            p_prof = StaffDetails.objects.get(user=request.user)
        except:
            p_prof=""
        doctors = DoctorDetails.objects.all()

        d = {"p_prof":p_prof,"sAppointmentActive":"custom-active",'doctors':doctors}
        return render(request,'appointment/scheduleAppointment.html',d)

    def post(self,request):
        patientName = request.POST.get('patientName')
        doctorName = request.POST.get('doctorName')
        appointmentDate = request.POST.get('appointmentDate')
        appointmentTime = request.POST.get('appointmentTime')

        print("patient name is {}, doctor name is {}, appointment date is {} and time is {}".format(patientName,doctorName,appointmentDate,appointmentTime))

        return redirect('/scheduleAppointment/')
