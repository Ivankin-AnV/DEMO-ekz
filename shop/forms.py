from django import forms
from .models import Headset, Order

class HeadsetForm(forms.ModelForm):
    class Meta:
        model = Headset
        fields = '__all__'


class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = ['headset', 'quantity', 'status']
