from datetime import date
from turtle import home
from django.shortcuts import redirect, render
from django.views import View
from graphviz import view
from userAuth.models import PatientDetails, DoctorDetails
from django.contrib.auth.models import Group
from django.template import RequestContext
import pandas as pd
import os
import pickle
from django.contrib import messages


# def handler404(request, exception, template_name="mainApp/404.html"):
#     response = render(template_name)
#     response.status_code = 404
#     return response


#load models

def loadModel():
    filename = os.path.dirname(os.path.abspath(__file__))+'//disPredModel'
    with open(filename,'rb') as f:
        mod = pickle.load(f)
    return mod


def loadSeverityDf():
    filename = os.path.dirname(os.path.abspath(__file__))+'//severityWeight'
    with open(filename,'rb') as f:
        mod = pickle.load(f)
    return mod



def displayHomePage(request):
    # if request.user.groups.filter(name__in=['doctor']).exists():
    #     print("yes")
    today = date.today()
    print(today)
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


class PredictDiseases(View):
    def get(self,request):
        sw = []
        severityWeight = loadSeverityDf()
        sw_size = severityWeight.index.size
        for i in range(sw_size):
            sw.append(severityWeight.iloc[i])
        d = {'fdiseasesactive' : "custom-active",'severityWeight':sw}
        return render(request,'mainApp/diseases.html',d)
    
    def post(self,request):

        sym1 = int(request.POST.get('sym-1'))
        sym2 = int(request.POST.get('sym-2'))
        sym3 = int(request.POST.get('sym-3'))
        sym4 = int(request.POST.get('sym-4'))
        sym5 = int(request.POST.get('sym-5'))
        sym6 = int(request.POST.get('sym-6'))
        sym7 = int(request.POST.get('sym-7'))
        sym8 = int(request.POST.get('sym-8'))
        sym9 = int(request.POST.get('sym-9'))
        sym10 = int(request.POST.get('sym-10'))

        sym_list = [sym1,sym2,sym3,sym4,sym5,sym6,sym7,sym8,sym9,sym10]
        knn = loadModel()
        res = knn.predict([sym_list])
        messages.success(request,res[0])
        return redirect('/predictdiseases')


class AboutView(View):
    def get(self,request):
        d = {'aboutactive' : "custom-active"}
        return render(request,'mainApp/aboutus.html',d)

