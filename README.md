# Platform Documentation

## JavaScript include tag

The first step to integrating Harvest time tracking into your app involves
placing our JavaScript include tag into your HTML. The best placement for this
is right at the bottom of your document, just before the closing `</body>` tag.

Here's what the include tag should look like. The
[configuration](#configuration) will need to be altered for your app.

```html
<script>
  (function() {
    window._harvestPlatformConfig = {
      "applicationName": "Example App",
      "permalink": "http://example.com/projects/%PROJECT_ID%/items/%ITEM_ID%",
    };
    var s = document.createElement('script');
    s.src = '//platform.harvestapp.com/javascripts/generated/platform.js';
    s.async = true;
    var ph = document.getElementsByTagName('script')[0];
    ph.parentNode.insertBefore(s, ph);
  })();
</script>
```

### Configuration

Options:

- **applicationName** (string): The name of your app. This will be displayed in
  Harvest to identify the link between Harvest project and your app. *Example:
  "MyTodoApp"*
- **permalink** (string): The permalink structure used for your
  app's items. We will replace certain variables. *Example: TODO*

## HTML

The only HTML element you'll need to insert into your page is a div with the
class of `harvest-timer`. You'll need to insert one wherever you want a timer.
For example, in a todo app, you'd need a `harvest-timer` div for each todo in a
list.

	<div class="harvest-timer"></div>
	
You need to add some [data attributes](#dataattributes) to get things fully
working, though.

### Data attributes

The timer element requires that both `data-project` and `data-item` attributes
be added in order to properly identify the item associated with the timer. For
services like Basecamp, a `data-account` attribute is also required. All
attributes are represented by a JSON string.

```html
<div class="harvest-timer" 
  data-account='{"id":42"}'
  data-project='{"id":42,"name":"Harvest Platform"}'
  data-item='{"id":1337,"name":"Write documentation"}'>
</div>
```

#### data-account

`data-account` is a JSON object with data about the account associated with a
particular timer. This is necessary for products like Basecamp, where all
projects exist within the context of an account.

Attributes:

- **id (string**: the unique ID associated with a specific user.

#### data-project

`data-project` is a JSON object with data about the project associated with a
particular timer.

Attributes:

- **id (string)**: the unique ID of the project. Can by any string (with a
  maxlength of 255)
- **name (string)**: the name of the project. Can by any string (with a
  maxlength of 255)

#### data-item

`data-item` is a JSON object with data about the todo item associated with a
particular timer.

Attributes:

- **id (string)**: the unique ID of the item. Can by any string (with a
  maxlength of 255)
- **name (string)**: the name of the item. Can by any string (with a maxlength
  of 255)

### Custom CSS

Sometimes, you might wish to add your own styles to a timer element rather than
using those provided by Harvest.  In order to signal to the Harvest Platform
that styling should be skipped, you need only to set the `skipStyling`
attribute to `true` within the configuration block.

```js
window._harvestPlatformConfig = {
  "applicationName": "Skipping the Style",
  "skipStyling": true
};
```

## Events

Once the Harvest Platform has been initialized, it becomes reliant on events
from the client in order to render timers to the DOM. All of these events
should be fired through the `#harvest-messaging` element. Currently, the
platform supports events of type `CustomEvent` and `jQuery.Event`.

- **harvest-event:ready** - The `ready` event is fired by the platform itself
  and indicates that everything has been initialized. **Note: This event is
  fired on the `body` element, since the listening client cannot listen to the
  `#harvest-messaging` element until it exists.**

- **harvest-event:timers:add** - The `timers:add` event can be used when one or
  more `harvest-timer` elements exist in the DOM and require an iframe
  listener.

    Attributes:
    
    - **element**: The HTMLElement that should be treated as a Harvest timer
