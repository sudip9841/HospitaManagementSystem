# Generated by Django 3.1.4 on 2022-02-05 09:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('userAuth', '0002_auto_20220116_1402'),
    ]

    operations = [
        migrations.RenameField(
            model_name='personaldetails',
            old_name='sex',
            new_name='gender',
        ),
    ]
