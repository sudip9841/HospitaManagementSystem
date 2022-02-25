# Generated by Django 3.1.4 on 2022-02-14 14:27

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('userAuth', '0007_nonregisteredpatientdetails'),
    ]

    operations = [
        migrations.AlterField(
            model_name='nonregisteredpatientdetails',
            name='phone',
            field=models.BigIntegerField(unique=True, validators=[django.core.validators.MaxValueValidator(13), django.core.validators.MinValueValidator(10)]),
        ),
    ]