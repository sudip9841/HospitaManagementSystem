from django.shortcuts import render
from userAuth.models import PatientDetails, DoctorDetails
from django.contrib.auth.models import Group
from django.template import RequestContext


# def handler404(request, exception, template_name="mainApp/404.html"):
#     response = render(template_name)
#     response.status_code = 404
#     return response


def displayHomePage(request):
    # if request.user.groups.filter(name__in=['doctor']).exists():
    #     print("yes")
    
    return render(request,'mainApp/index.html',{})


def findDoctor(request):
    if request.method == 'GET':
        doctors = DoctorDetails.objects.all()
        d = {'doctors':doctors}
        return render(request,'mainApp/finddoctor.html',d)

def doctorProfile(request):
    if request.method == 'GET':
        return render(request,'mainApp/doctorProfile.html',{})
