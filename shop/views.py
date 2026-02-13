from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import Group
from .models import Headset, Order
from .forms import HeadsetForm, OrderForm


# Гостевой режим
def guest_view(request):
    headsets = Headset.objects.all()
    return render(request, 'guest.html', {'headsets': headsets})


# Список товаров (для авторизованных)
@login_required
def headset_list(request):
    headsets = Headset.objects.all()

    search = request.GET.get('search')
    sort = request.GET.get('sort')

    if search:
        headsets = headsets.filter(name__icontains=search)

    if sort == 'price':
        headsets = headsets.order_by('price')

    return render(request, 'headset_list.html', {'headsets': headsets})


# Создание товара (только админ)
@login_required
def headset_create(request):
    if not request.user.is_superuser:
        return redirect('headset_list')

    form = HeadsetForm(request.POST or None)
    if form.is_valid():
        form.save()
        return redirect('headset_list')

    return render(request, 'headset_form.html', {'form': form})


# Редактирование
@login_required
def headset_update(request, pk):
    if not request.user.is_superuser:
        return redirect('headset_list')

    headset = get_object_or_404(Headset, pk=pk)
    form = HeadsetForm(request.POST or None, instance=headset)

    if form.is_valid():
        form.save()
        return redirect('headset_list')

    return render(request, 'headset_form.html', {'form': form})


# Удаление
@login_required
def headset_delete(request, pk):
    if not request.user.is_superuser:
        return redirect('headset_list')

    headset = get_object_or_404(Headset, pk=pk)
    headset.delete()
    return redirect('headset_list')


# Заказы (менеджер и админ)
@login_required
def order_list(request):
    if request.user.groups.filter(name='Manager').exists() or request.user.is_superuser:
        orders = Order.objects.all()
    else:
        orders = Order.objects.filter(user=request.user)

    return render(request, 'order_list.html', {'orders': orders})


@login_required
def order_create(request):
    form = OrderForm(request.POST or None)

    if form.is_valid():
        order = form.save(commit=False)
        order.user = request.user
        order.save()
        return redirect('order_list')

    return render(request, 'order_form.html', {'form': form})


@login_required
def order_update(request, pk):
    order = get_object_or_404(Order, pk=pk)

    if not request.user.is_superuser:
        return redirect('order_list')

    form = OrderForm(request.POST or None, instance=order)

    if form.is_valid():
        form.save()
        return redirect('order_list')

    return render(request, 'order_form.html', {'form': form})
