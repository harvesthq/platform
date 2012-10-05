# Harvest and Trello Integration

### Including the Harvest Platform

Loading the platform requires that the following block and configuration be
specified.

```html
<script>
  (function() {
    window._harvestPlatformConfig = {
      "applicationName": "Trello",
      "permalink": "https://trello.com/card/%PROJECT_ID%/%ITEM_ID%",
      "skipStyling": true,
    };
    var s = document.createElement("script");
    s.src = "https://platform.harvestapp.com/javascripts/generated/platform.js";
    s.async = true;
    var ph = document.getElementsByTagName("script")[0];
    ph.parentNode.insertBefore(s, ph);
  })();
</script>
```

### Adding a Harvest timer to a Trello todo

The Harvest timer is currently rendered in the Actions list. Natively, this can
be accomplished by adding the following markup to the list.

```html
<a class="harvest-timer button-link js-add-trello-timer">
  <span class="trello-timer-icon"></span>
  Track time...
</a>
```

Additionally, each timer element should contain `data-project` and `data-item`
elements. These contain JSON strings representing board and card data.

```html
<a class="harvest-timer" 
  data-project='{"id": boardId, "name": boardName}'
  data-item='{"id": cardId, "name": cardDescription}'>
</a>

```

While Trello natively handles hover events on the button, it is unaware of the
timer icon. It can be restyled by adding the `hover` class.

```js
$(".harvest-timer")
  .on("mouseenter", function() {
    $(".trello-timer-icon").addClass("hover")
  })
  .on("mouseleave", function() {
    $(".trello-timer-icon").removeClass("hover")
  });
```

The platform will poll Harvest for the running timer and subsequently append
the `running` class to any button associated with that timer. The UI can poll
for the timer with that class and style its icon accordingly.

```js
setInterval(function() {
  if ($(".js-add-trello-timer").hasClass("running")) {
    $(".trello-timer-icon").addClass("running");
  else {
    $(".trello-timer-icon").removeClass("running");
  }
}, 500);
```

The button itself is styled differently when its timer is running. This style
matches the one Trello uses for `mouseenter` events.

```css
.js-add-trello-timer.running {
  background: #2887bd;
  background: -moz-linear-gradient(top, #2887bd 0%, #1f6993 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #2887bd), color-stop(100%, #1f6993));
  background: -webkit-linear-gradient(top, #2887bd 0%, #1f6993 100%);
  background: -o-linear-gradient(top, #2887bd 0%, #1f6993 100%);
  background: -ms-linear-gradient(top, #2887bd 0%, #1f6993 100%);
  background: linear-gradient(top, #2887bd 0%, #1f6993 100%);
  color: white;
}
```

The following styles are used for changing the Harvest timer icon based on the
state of its button.

```css
.trello-timer-icon {
  background-image: url(https://platform.harvestapp.com/images/platform/trello-timer-icon.png);
  background-repeat: no-repeat;
  background-position: 4px -83px;
  display: inline-block;
  position: relative;
  height: 18px;
  width: 18px;
  margin: 0 0 -3px 0;
}

.trello-timer-icon.hover, .trello-timer-icon.running {
  background-position: 4px -122px;
}
```
