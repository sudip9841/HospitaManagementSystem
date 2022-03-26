from django import forms
from userAuth.models import DoctorDetails, PatientDetails, NonRegisteredPatientDetails
from appointment.models import AppointmentBooking



class NonRegPatientAppointmentForm(forms.ModelForm):
    class Meta:
        model = AppointmentBooking
        fields = ['appointmentDate','appointmentTime']
        widgets = {
            'appointmentDate':forms.DateInput(format=('%m/%d/%Y'), attrs={'class':'form-control', 'placeholder':'Select a date', 'type':'date'}),
            'appointmentTime':forms.Select(attrs={'class':'form-control'})
            
        }




class RegPatientAppointmentForm(forms.ModelForm):
    class Meta:
        model = AppointmentBooking
        fields = ['appointmentDate','appointmentTime']
        widgets = {
            'appointmentDate':forms.DateInput(format=('%m/%d/%Y'), attrs={'class':'form-control', 'placeholder':'Select a date', 'type':'date'}),
            'appointmentTime':forms.Select(attrs={'class':'form-control'})
            
        }