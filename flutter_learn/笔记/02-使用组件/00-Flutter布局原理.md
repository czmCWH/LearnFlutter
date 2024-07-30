

StatelessWidget 和 StatefulWidget 是 组合类 的控件，因此他不负责绘制，本质上是通过 RenderObjectWidget 实现布局。在 RenderObjectWidget 中有个 createRenderObject() 方法返回 RenderObject 对象，RenderObject 实际负责实际的 layout() 和 paint()


<https://zhengzeqin.netlify.app/2022/04/16/四）Flutter-布局详解/>
<https://juejin.cn/post/6897012238318895117#heading-7>