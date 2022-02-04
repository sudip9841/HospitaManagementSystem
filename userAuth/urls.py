from django.urls import path
from userAuth import views
from django.contrib.auth import views as auth_views
from userAuth.forms import LoginForm, ChangePasswordForm, MyPasswordResetForm, MySetPasswordForm


urlpatterns = [

    path('userDash/home/',views.getUserDashboard, name='userDashHome'),
    #user login
    path('login/',auth_views.LoginView.as_view(template_name='userAuth/login.html', authentication_form=LoginForm), name='login'),

    #user logout
    path('logout/', auth_views.LogoutView.as_view(template_name='mainApp/index.html'), name='logout'),

    #user registration
    path('registration/',views.UserRegistrationView.as_view(), name='signup'),

    #reset passowrd
    path('password-reset/', auth_views.PasswordResetView.as_view(template_name='userAuth/password_reset.html', form_class=MyPasswordResetForm), name='password_reset'),
    path('password-reset/done/',auth_views.PasswordResetDoneView.as_view(template_name='userAuth/password_reset_done.html'), name='password_reset_done'),
    path('password-reset-confirm/<uidb64>/<token>/',auth_views.PasswordResetConfirmView.as_view(template_name='userAUth/password_reset_confirm.html', form_class=MySetPasswordForm), name='password_reset_confirm'),
    path('password-reset-complete', auth_views.PasswordResetCompleteView.as_view(template_name='userAuth/password_reset_complete.html'), name='password_reset_complete'),

    #change password
    path('changepassword/', auth_views.PasswordChangeView.as_view(template_name='userAuth/changepassword.html', form_class=ChangePasswordForm, success_url='/accounts/changepassworddone/'), name='changepassword'),
    path('changepassworddone/',auth_views.PasswordChangeView.as_view(template_name='userAuth/changepassworddone.html'), name='changepassworddone'),

    path('editprofile/', views.EditProfile.as_view(), name='editprofile'),

]