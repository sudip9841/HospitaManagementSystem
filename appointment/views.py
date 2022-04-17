
from importlib.metadata import PathDistribution
from django.shortcuts import render, redirect
from django.views import View
from userAuth.forms import NonRegisteredPatientDetailsForm
from userAuth.models import NonRegisteredPatientDetails, StaffDetails, DoctorDetails, PatientDetails
from appointment.forms import NonRegPatientAppointmentForm, RegPatientAppointmentForm
from appointment.models import AppointmentBooking
import datetime
from django.contrib import messages
from django.db.models import Q

import requests
import json 
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required

import os
from reportlab.pdfgen import canvas



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
            # .filter(appointmentDate__gte=datetime.date.today())
        myAppointments = AppointmentBooking.objects.all().filter(patient=pd).filter(appointmentDate__gte=datetime.date.today()).filter(paymentStatus='pending').order_by('-id')

        myPastAppointments = AppointmentBooking.objects.all().filter(patient=pd).filter(appointmentDate__lte=datetime.date.today()).order_by('-id')
        myPaidAppointments = AppointmentBooking.objects.all().filter(patient=pd).filter(appointmentDate__gte=datetime.date.today()).filter(paymentStatus='paid').order_by('-id')

        try:
            p_prof = PatientDetails.objects.get(user=request.user)
        except:
            p_prof=""

        
        d = {'myAppointments':myAppointments,'p_prof':p_prof,'myPastAppointments':myPastAppointments,'myPaidAppointments':myPaidAppointments}
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


# for payment 
@csrf_exempt
def verify_payment(request):
   data = request.POST
   product_id = data['product_identity']
   token = data['token']
   amount = data['amount']

   url = "https://khalti.com/api/v2/payment/verify/"
   payload = {
   "token": token,
   "amount": amount
   }
   headers = {
   "Authorization": "Key test_secret_key_e8bbef30858745a6bb4551514eec92a4"
   }
   

   response = requests.post(url, payload, headers = headers)
   
   response_data = json.loads(response.text)
   status_code = str(response.status_code)

   if status_code == '400':
      response = JsonResponse({'status':'false','message':response_data['detail']}, status=500)
      return response

   import pprint 
   pp = pprint.PrettyPrinter(indent=4)
   pp.pprint(response_data)
   pd = PatientDetails.objects.get(user=request.user)
   AppointmentBooking.objects.all().filter(patient=pd).filter(paymentStatus='pending').update(paymentStatus='paid')

   return JsonResponse(f"Payment Done !! With IDX. {response_data['user']['idx']}",safe=False)


@login_required
def printInvoice(request,id):
    if request.user.groups.filter(name__in=['patient']).exists():
        try:
            app = AppointmentBooking.objects.get(id=id)
        except:
            return redirect('/scheduleAppointment/myappointments')
        if app.patient.user == request.user and app.paymentStatus=='paid':
            d={
                'appointmentId':app.id,
                'doctorName':app.doctor.fullName,
                'appointmentDate':app.appointmentDate,
                'appointmentTime':app.appointmentTime,
                'patientName':app.patient.fullName,
                'doctorDepartment':app.doctor.department,
                'phone':app.patient.phone
            }
        else:
            return redirect('/scheduleAppointment/myappointments')

        # Create the HttpResponse object with the appropriate PDF headers.
        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = 'filename="invoice.pdf"'
        
        # save_name = os.path.join(os.path.expanduser("~"), "Downloads/", "invoice.pdf")
        c = canvas.Canvas(response,pagesize=(200,250),bottomup=0)
        # Logo Section
        # Setting th origin to (10,40)
        c.translate(10,40)
        # Inverting the scale for getting mirror Image of logo
        c.scale(1,-1)
        # Inserting Logo into the Canvas at required position
        # c.drawImage("hospital_logo.PNG",0,0,width=50,height=20)
        # Title Section
        # Again Inverting Scale For strings insertion
        c.scale(1,-1)
        # Again Setting the origin back to (0,0) of top-left
        c.translate(-10,-40)
        # Setting the font for Name title of company
        c.setFont("Helvetica-Bold",10)
        # Inserting the name of the company
        c.drawCentredString(100,20,"Nepal Hospital Pvt Ltd")
        # Changing the font size for Specifying Address
        c.setFont("Helvetica-Bold",5)
        c.drawCentredString(100,35,"Naxal, Kathmandu")
        # Changing the font size for Specifying GST Number of firm
        c.setFont("Helvetica-Bold",6)

        # Line Seprating the page header from the body
        c.line(5,45,195,45)
        # Document Information
        # Changing the font for Document title
        c.setFont("Courier-Bold",8)
        c.drawCentredString(100,55,"OPD Payment Invoice")

        # This Block Consist of Costumer Details

        c.setFont("Times-Bold",5)
        c.drawRightString(45,70,"Invoice. : {}".format(d['appointmentId']))
        c.drawRightString(76,80,"Date, Time : {},{}".format(d['appointmentDate'],d['appointmentTime']))
        c.drawRightString(70,90,"Patient : {}".format(d['patientName']))
        c.drawRightString(160,70,"Doctor : {}".format(d['doctorName']))
        c.drawRightString(160,80,"Department : {}".format(d['doctorDepartment'][:15]))
        c.drawRightString(70,100,"Phone No. : {}".format(d['phone']))
        # This Block Consist of Item Description
        c.roundRect(15,108,170,130,10,stroke=1,fill=0)
        c.line(15,120,185,120)
        c.drawCentredString(25,118,"SR No.")
        c.drawCentredString(75,118,"DESCRIPTION")
        c.drawCentredString(125,118,"Price")
        c.drawCentredString(173,118,"TOTAL")
        # Drawing table for Item Description
        c.line(15,210,185,210)
        c.line(35,108,35,220)
        c.line(115,108,115,220)
        c.line(160,108,160,220)
        # Declaration and Signature
        c.line(15,220,185,220)
        c.line(100,220,100,238)

        c.drawString(20,130,"1")
        c.drawString(40,130,"OPD Bill Payment")
        c.drawString(120,130,"200")
        c.drawString(165,130,"200")




        c.drawString(20,225,"We declare that above mentioned")
        c.drawString(20,230,"information is true.")
        c.drawString(20,235,"(This is system generated invoive)")
        c.drawRightString(165,227,"Payment Status: Paid")
        c.drawRightString(180,235,"Authorised by Nepal Hospital")
        # End the Page and Start with new
        c.showPage()
        # Saving the PDF
        c.save()
        return response

    # printing invoice logic for staff
    elif request.user.groups.filter(name__in=['staff']).exists():
        try:
            app = AppointmentBooking.objects.get(id=id)
        except:
            return redirect('/accounts/viewDoctorsList')
        if app.paymentStatus=='paid':
            if app.patient:
                d={
                    'appointmentId':app.id,
                    'doctorName':app.doctor.fullName,
                    'appointmentDate':app.appointmentDate,
                    'appointmentTime':app.appointmentTime,
                    'patientName':app.patient.fullName,
                    'doctorDepartment':app.doctor.department,
                    'phone':app.patient.phone
                }
            else:
                d={
                    'appointmentId':app.id,
                    'doctorName':app.doctor.fullName,
                    'appointmentDate':app.appointmentDate,
                    'appointmentTime':app.appointmentTime,
                    'patientName':app.nonRegisteredPatient.fullName,
                    'doctorDepartment':app.doctor.department,
                    'phone':app.nonRegisteredPatient.phone
                }
        else:
            return redirect('/accounts/viewDoctorsList')

        # Create the HttpResponse object with the appropriate PDF headers.
        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = 'filename="invoice.pdf"'
        
        # save_name = os.path.join(os.path.expanduser("~"), "Downloads/", "invoice.pdf")
        c = canvas.Canvas(response,pagesize=(200,250),bottomup=0)
        # Logo Section
        # Setting th origin to (10,40)
        c.translate(10,40)
        # Inverting the scale for getting mirror Image of logo
        c.scale(1,-1)
        # Inserting Logo into the Canvas at required position
        # c.drawImage("hospital_logo.PNG",0,0,width=50,height=20)
        # Title Section
        # Again Inverting Scale For strings insertion
        c.scale(1,-1)
        # Again Setting the origin back to (0,0) of top-left
        c.translate(-10,-40)
        # Setting the font for Name title of company
        c.setFont("Helvetica-Bold",10)
        # Inserting the name of the company
        c.drawCentredString(100,20,"Nepal Hospital Pvt Ltd")
        # Changing the font size for Specifying Address
        c.setFont("Helvetica-Bold",5)
        c.drawCentredString(100,35,"Naxal, Kathmandu")
        # Changing the font size for Specifying GST Number of firm
        c.setFont("Helvetica-Bold",6)

        # Line Seprating the page header from the body
        c.line(5,45,195,45)
        # Document Information
        # Changing the font for Document title
        c.setFont("Courier-Bold",8)
        c.drawCentredString(100,55,"OPD Payment Invoice")

        # This Block Consist of Costumer Details

        c.setFont("Times-Bold",5)
        c.drawRightString(45,70,"Invoice. : {}".format(d['appointmentId']))
        c.drawRightString(76,80,"Date, Time : {},{}".format(d['appointmentDate'],d['appointmentTime']))
        c.drawRightString(70,90,"Patient : {}".format(d['patientName']))
        c.drawRightString(160,70,"Doctor : {}".format(d['doctorName']))
        c.drawRightString(160,80,"Department : {}".format(d['doctorDepartment'][:15]))
        c.drawRightString(70,100,"Phone No. : {}".format(d['phone']))
        # This Block Consist of Item Description
        c.roundRect(15,108,170,130,10,stroke=1,fill=0)
        c.line(15,120,185,120)
        c.drawCentredString(25,118,"SR No.")
        c.drawCentredString(75,118,"DESCRIPTION")
        c.drawCentredString(125,118,"Price")
        c.drawCentredString(173,118,"TOTAL")
        # Drawing table for Item Description
        c.line(15,210,185,210)
        c.line(35,108,35,220)
        c.line(115,108,115,220)
        c.line(160,108,160,220)
        # Declaration and Signature
        c.line(15,220,185,220)
        c.line(100,220,100,238)

        c.drawString(20,130,"1")
        c.drawString(40,130,"OPD Bill Payment")
        c.drawString(120,130,"200")
        c.drawString(165,130,"200")




        c.drawString(20,225,"We declare that above mentioned")
        c.drawString(20,230,"information is true.")
        c.drawString(20,235,"(This is system generated invoive)")
        c.drawRightString(165,227,"Payment Status: Paid")
        c.drawRightString(180,235,"Authorised by Nepal Hospital")
        # End the Page and Start with new
        c.showPage()
        # Saving the PDF
        c.save()
        return response
    else:
        return redirect('/')





