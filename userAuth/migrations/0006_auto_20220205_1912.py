# Generated by Django 3.1.4 on 2022-02-05 13:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('userAuth', '0005_doctordetails_staffdetails'),
    ]

    operations = [
        migrations.AlterField(
            model_name='staffdetails',
            name='department',
            field=models.CharField(choices=[('cashier', 'cashier'), ('call-center', 'call-center')], max_length=50),
        ),
    ]
