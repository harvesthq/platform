# Harvest and Basecamp Integration

The Harvest platform enables any web developer to bring time tracking into their application in less than an hour. 
The completed integration is not only easy to implement, it achieves a very seamless integration experience 
for the end-user. A Basecamp user will be able to track time to a Basecamp card. 

* Watch a demo: http://www.youtube.com/watch?v=3XvwvhWirU0
* You can also create a free Harvest trial for testing: https://www.getharvest.com/signup

Integrating requires just 3 simple steps.

### 1. Include the Harvest Platform JS Block

Loading the platform requires that the following block and configuration be
specified. Note that we've set two key variables to for Basecamp, namely "applicationName" and "permalink" (which enables Harvest to link back to Basecamp)

```html
<script>
  (function() {
    window._harvestPlatformConfig = {
      "applicationName": 'Basecamp',
      "permalink": 'https://basecamp.com/%ACCOUNT_ID%/projects/%PROJECT_ID%/todos/%ITEM_ID%'
    };
    var s = document.createElement("script");
    s.src = "https://platform.harvestapp.com/javascripts/generated/platform.js";
    s.async = true;
    var ph = document.getElementsByTagName("script")[0];
    ph.parentNode.insertBefore(s, ph);
  })();
</script>
```

### 2. Add a Harvest timer to each todo list item

The Harvest timer will be rendered alongside all todo
list items. This can be accomplished by appending the
button element to the todo.

```html
<div class="harvest-timer"
  data-account='{"id": accountId}'
  data-project='{"id": projectId, "name": projectName}'
  data-item='{"id": itemId, "name": itemName}'>
</div>
```

**Note:** Currently, Harvest timers will only be
displayed for incomplete items. We detect completeness by
searching for an element with class `complete` within the
todo item element.

### 3. Add Harvest timer to new list items

The Harvest platform will detect items at page load, but
we need to receive a JavaScript event in order to
associate timers with new elements on the page.

In order to associate a new timer, the following event
can be fired when a new item is created in the DOM.

```js
var harvestData = {
  type: 'harvest-event:timers:add',
  element: newElement,
}

$("#harvest-messaging").trigger(harvestData)
```
