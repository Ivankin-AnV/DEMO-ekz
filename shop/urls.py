from django.urls import path
from . import views

urlpatterns = [
    path('guest/', views.guest_view, name='guest'),
    path('headsets/', views.headset_list, name='headset_list'),
    path('headsets/create/', views.headset_create, name='headset_create'),
    path('headsets/update/<int:pk>/', views.headset_update, name='headset_update'),
    path('headsets/delete/<int:pk>/', views.headset_delete, name='headset_delete'),

    path('orders/', views.order_list, name='order_list'),
    path('orders/create/', views.order_create, name='order_create'),
    path('orders/update/<int:pk>/', views.order_update, name='order_update'),
]
