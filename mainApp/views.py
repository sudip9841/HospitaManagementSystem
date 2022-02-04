from django.shortcuts import render

# Create your views here.


def displayHomePage(request):
    return render(request,'mainApp/index.html',{})