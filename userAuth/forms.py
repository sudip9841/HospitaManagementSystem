import imp
from django import forms
from django.contrib.auth.models import User
from userAuth.models import PersonalDetails
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, UsernameField, PasswordChangeForm, PasswordResetForm, SetPasswordForm
from django.utils.translation import gettext, gettext_lazy as _
from django.contrib.auth import password_validation


class UserRegistrationForm(UserCreationForm):
    username = forms.CharField(label="Username", widget=forms.TextInput(attrs={'class':'form-control'}))
    password1 = forms.CharField(label="Password",widget=forms.PasswordInput(attrs={"class":'form-control'}))
    password2 = forms.CharField(label="Confirm Password", widget=forms.PasswordInput(attrs={'class':'form-control'}))
    email = forms.CharField(label="Email",required=True, widget=forms.EmailInput(attrs={'class':'form-control'}))

    class Meta:
        model = User
        fields = ['username','email','password1','password2']


class LoginForm(AuthenticationForm):
    username = UsernameField(widget=forms.TextInput(attrs={'autofocus':True, 'class':'form-control'}))
    password = forms.CharField(label=_('Password'), 
    strip=False, 
    widget=forms.PasswordInput(attrs={'autocomplete':'current-password','class':'form-control'}))


class ChangePasswordForm(PasswordChangeForm):
    old_password = forms.CharField(label=_("Old Password"),
    strip=False, widget=forms.PasswordInput(attrs={'autocomplete':'current-password', 'autofocus':True, 'class':'form-control'}))

    new_password1 = forms.CharField(label=_("New Password"), strip=False, 
    widget=forms.PasswordInput(attrs={'autocomplete':'new-password','class':'form-control'}),
    help_text=password_validation.password_validators_help_text_html())

    new_password2 = forms.CharField(label=_("Confirm New Password"), strip=False,
    widget=forms.PasswordInput(attrs={'autocomplete':'new-password','class':'form-control'}))


class MyPasswordResetForm(PasswordResetForm):
    email = forms.EmailField(label=_("Email"), max_length=254,
    widget=forms.EmailInput(attrs={'autocomplete':'email', 'class':'form-control'}))


class MySetPasswordForm(SetPasswordForm):
    
    new_password1 = forms.CharField(label=_("New Password"), strip=False, 
    widget=forms.PasswordInput(attrs={'autocomplete':'new-password','class':'form-control'}),
    help_text=password_validation.password_validators_help_text_html())

    new_password2 = forms.CharField(label=_("Confirm New Password"), strip=False,
    widget=forms.PasswordInput(attrs={'autocomplete':'new-password','class':'form-control'}))

class DateInput(forms.DateInput):
    input_type = 'date'

class PersonalDetailsForm(forms.ModelForm):
    class Meta:
        model = PersonalDetails
        fields = ['fullName','age','sex','phone','address','profile_pic']
        widgets = {'fullName':forms.TextInput(attrs={'class':'form-control'}),
                    'age':forms.NumberInput(attrs={'class':'form-control'}),
                    'sex':forms.Select(attrs={'class':'form-control'}),
                    'phone':forms.NumberInput(attrs={'class':'form-control'}),
                    'address':forms.TextInput(attrs={'class':'form-control'}),
                    'profile_pic':forms.ClearableFileInput(attrs={'class':'form-control'})}