# Generated by Django 3.1.4 on 2022-02-14 14:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('userAuth', '0008_auto_20220214_2012'),
    ]

    operations = [
        migrations.AlterField(
            model_name='nonregisteredpatientdetails',
            name='phone',
            field=models.BigIntegerField(unique=True),
        ),
    ]