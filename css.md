# Reset box-sizing

```css
html { 
  box-sizing: border-box; 
}

*, 
*:before, 
*:after { 
  box-sizing: inherit; 
}

img {
  box-sizing: content-box;
}
```


## 60 FPS Scrolling

```javascript
var body = document.body,
    timer;

window.addEventListener('scroll', function() {
  clearTimeout(timer);
  if(!body.classList.contains('disable-hover')) {
    body.classList.add('disable-hover')
  }
  
  timer = setTimeout(function(){
    body.classList.remove('disable-hover')
  },500);
}, false);
```

```css
.disable-hover,
.disable-hover * {
  pointer-events: none !important;
}
```
