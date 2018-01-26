## Django  ModuleForm 

### 模型表单示例

##### 编辑 ：models.py
    from django.db import models
    from django import forms

    class BlogPost(models.Model):
      title=models.CharField(max_length=200)
      body=models.TextField()
      timestamp=models.DateTimeField()

    class BlogPostForm(foms.ModelForm):
      class Meta:
        model = BlogPost
        exclude=('timestamp')
    
    
##### 使用ModelForm 来生成 HTML 表单
    <form action="/blog/create/" method="POST">
        {% csrf_token %}
        <table>{{ form }} </table><br>
        <input type="submit" />
    </form>

      form.as_p 以<p>...</p> 分割文本
      form.as_ul 以<li> 列表元素显示

##### 更新视图函数，将ModelForm 发送至模板
    return render_to_response('archive.html',{'form':BlogPostForm()}, RequestContext(request))

##### 处理 MOdelForm 数据
    def create_blogpost(request):
        if request.method == 'GET':
            form = BlogPostForm()
        else:
            form = BlogPostForm(request.POST)
            if form.is_valid():
                post = form.save(commit=False)
                post.timestamp=datetime.now()
                post.save()
                return HttpResponseRedirect(reverse('post_detail', kwargs={'post_id': post.id}))

        return render(request, 'post/post_form_upload.html', { 'form': form, })
  
  
