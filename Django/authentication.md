# 使用 Django自带的 登录验证模块
[Django 登录验证模块](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Django/Authentication)

####  新建一个项目：
    pyhton manage.py stratproject   locallibrary


#### 编辑 locallibrary/locallibrary/urls.py 添加如下一行

    #Add Django site authentication urls (for login, logout, password management)
    urlpatterns += [
        path('accounts/', include('django.contrib.auth.urls')),
    ]
    
###### 会自动集成django的登录验证模块：
    accounts/ login/ [name='login']
    accounts/ logout/ [name='logout']
    accounts/ password_change/ [name='password_change']
    accounts/ password_change/done/ [name='password_change_done']
    accounts/ password_reset/ [name='password_reset']
    accounts/ password_reset/done/ [name='password_reset_done']
    accounts/ reset/<uidb64>/<token>/ [name='password_reset_confirm']
    accounts/ reset/done/ [name='password_reset_complete']
    
#### 访问登录页面： http://127.0.0.1:8000/accounts/login/ 报错：
    Exception Type:    TemplateDoesNotExist
    Exception Value:    registration/login.html
    
    这是因为没有 locallibrary/templates/registration/  
    template 同 locallibrary/locallibrary 同级
    
    为了能找到此目录，需配置：locallibrary/locallibrary/settings.py
    TEMPLATES = [
    {
        ...
        'DIRS': ['./templates',],
        'APP_DIRS': True,
        ...
        
###### 新建登录页面：locallibrary/templates/registration/login.html
    {% extends "base_generic.html" %}

    {% block content %}

    {% if form.errors %}
    <p>Your username and password didn't match. Please try again.</p>
    {% endif %}

    {% if next %}
        {% if user.is_authenticated %}
        <p>Your account doesn't have access to this page. To proceed,
        please login with an account that has access.</p>
        {% else %}
        <p>Please login to see this page.</p>
        {% endif %}
    {% endif %}

    <form method="post" action="{% url 'login' %}">
    {% csrf_token %}

    <div>
      <td>{{ form.username.label_tag }}</td>
      <td>{{ form.username }}</td>
    </div>
    <div>
      <td>{{ form.password.label_tag }}</td>
      <td>{{ form.password }}</td>
    </div>

    <div>
      <input type="submit" value="login" />
      <input type="hidden" name="next" value="{{ next }}" />
    </div>
    </form>

    {# Assumes you setup the password_reset view in your URLconf #}
    <p><a href="{% url 'password_reset' %}">Lost password?</a></p>

    {% endblock %}


###### 此时会默认跳转到： http://127.0.0.1:8000/accounts/profile/  
    修改 locallibrary/locallibrary/settings.py
    # Redirect to home URL after login (Default redirects to /accounts/profile/)
    LOGIN_REDIRECT_URL = '/'
