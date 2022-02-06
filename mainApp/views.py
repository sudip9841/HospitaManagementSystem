from turtle import home
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
    homeactive="custom-active"
    return render(request,'mainApp/index.html',{"homeactive":homeactive})


def findDoctor(request):
    if request.method == 'GET':
        doctors = DoctorDetails.objects.all().order_by('department')
        fdoctoractive = "custom-active"
        d = {'doctors':doctors,'fdoctoractive':fdoctoractive}
        return render(request,'mainApp/finddoctor.html',d)

def doctorProfile(request,id=None):

    if request.method == 'GET':
        fdoctoractive = "custom-active"
        if id is not None:
            try:
                doctor = DoctorDetails.objects.get(id=id)
                return render(request,'mainApp/doctorProfile.html',{'doctor':doctor,'fdoctoractive':fdoctoractive})
            except:
                return render(request,'mainApp/doctorProfile.html',{'fdoctoractive':fdoctoractive})
        else:
            return render(request,'mainApp/doctorProfile.html',{'fdoctoractive':fdoctoractive})
