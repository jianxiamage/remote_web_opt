# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-04-02 09:04
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Ipaddr',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=128, verbose_name='IP\u7ec4')),
                ('status', models.IntegerField(blank=True, choices=[(1, '\u5728\u7ebf'), (2, '\u79bb\u7ebf'), (0, '\u672a\u77e5')], null=True, verbose_name='\u72b6\u6001')),
                ('remark', models.CharField(max_length=128, verbose_name='\u5907\u6ce8')),
                ('created_time', models.DateTimeField(auto_now_add=True, verbose_name='\u521b\u5efa\u65f6\u95f4')),
            ],
            options={
                'verbose_name': '\u4fe1\u606f',
                'verbose_name_plural': '\u4fe1\u606f',
            },
        ),
    ]
