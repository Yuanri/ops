## django.views.generic

### modes.py

    from django.db import models
    
    class Book(models.Model):
        title = models.CharField(max_length=200)
        author = modelsCharField(max_length=200)
        summary = models.TextField(max_length=1000, help_text="Enter a brief description of the book")
        isbn = models.CharField('ISBN', max_length=13,
               help_text='13 Character <a href="https://www.isbn-international.org/content/what-isbn">ISBN number</a>')
        genre = models.CharField(max_length=200)
        language = models.CharField(max_length=200)

        def __str__(self):
            return self.title
        

### 1、generic.ListView
##### 编辑views.py

    from django.views import  generic
    from .models import *

    class BookListView(generic.ListView):
        model = Book
     
##### 编辑urls.py

    from django.urls import  path
    from . import views

    urlpatterns=[
        path('books/', views.BookListView.as_view(), name='books'),
    ]

##### 编辑template html文件
默认使用名称 mode_name_list.html，如此处名称为：book_list.html

    {% extends "base_generic.html" %}
    {% block content %}
        <h1>Book List</h1>

        {% if book_list %}
        <ul>

          {% for book in book_list %}
          <li>
            <a href="{{ book.get_absolute_url }}">{{ book.title }}</a> ({{book.author}})

          </li>
          {% endfor %}

        </ul>
        {% else %}
          <p>There are no books in the library.</p>
        {% endif %}       
    {% endblock %}

### 2、generic.DetailView
##### 便捷views.py 新增如下：

    class BookDetailView(generic.DetailView):
        model = Book
    
##### urls.py 中urlpatterns 变更为

    urlpatterns=[
        path('books/', views.BookListView.as_view(), name='books'),
        path('book/<int:pk>', views.BookDetailView.as_view(), name='book-detail'),
    
    
##### template 文件：book_detail.html

    {% extends "base_generic.html" %}
    {% block content %}
        <h1>Book List</h1>
        {% if book_list %}
        <ul>
          {% for book in book_list %}
          <li>
            <a href="">{{ book.title }}</a> ({{book.author}})
          </li>
          {% endfor %}
        </ul>
        {% else %}
          <p>There are no books in the library.</p>
        {% endif %}       
    {% endblock %}

 
 
#### 3、分页功能
修改 views.py

    class BookListView(generic.ListView):
        model = Book
        paginate_by = 10      #分页


修改： base_generic.html 在 {% block content %}{% endblock %} 下面添加如下内容：

    {% block content %}{% endblock %}
    {% block pagination %}
      {% if is_paginated %}
          <div class="pagination">
              <span class="page-links">
                  {% if page_obj.has_previous %}
                      <a href="{{ request.path }}?page={{ page_obj.previous_page_number }}">previous</a>
                  {% endif %}
                  <span class="page-current">
                      Page {{ page_obj.number }} of {{ page_obj.paginator.num_pages }}.
                  </span>
                  {% if page_obj.has_next %}
                      <a href="{{ request.path }}?page={{ page_obj.next_page_number }}">next</a>
                  {% endif %}
              </span>
          </div>
      {% endif %}
    {% endblock %} 
    
    
### 其他自定义
##### 自定义返回结果

    class BookListView(generic.ListView):
        model = Book
        
        def get_queryset(self):   
            return Book.objects.all()[:5]
 
 
 
    context_object_name    #自定义返回对象，替换默认 book_list
    template_name          #替换默认template/book_list.html 


            
        
