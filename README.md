# Harvest Platform Documentation

For a brief overview of the Harvest Platform and how it can be implemented,
[watch the video introduction](http://www.youtube.com/watch?v=5_fVPnH7VBU).

## FAQ

1. [How can I add the Harvest Platform to my application?](#include)
2. [What configuration options do I need to specify?](#config)
3. [How can I add timers to my items?](#timers)
4. [How can I add timers to new items?](#events)
5. [How can I add custom styles to timers in my application?](#styling)

<a name="include"></a>
## How can I add the Harvest Platform to my application?

To add the Harvest Platform to your application, include the following
JavaScript block in your HTML. Be sure to check out the full list of
[configuration options](#config).

```html
<script>
  (function() {
    window._harvestPlatformConfig = {
      "applicationName": "Example App",
      "permalink": "http://example.com/%ACCOUNT_ID%/projects/%PROJECT_ID%/items/%ITEM_ID%"
    };
    var s = document.createElement('script');
    s.src = '//platform.harvestapp.com/assets/platform.js';
    s.async = true;
    var ph = document.getElementsByTagName('script')[0];
    ph.parentNode.insertBefore(s, ph);
  })();
</script>
```

**Note:** If you'd like to review the uncompressed JavaScript used for the
Harvest Platform before including it on your page, check out the [original
file](https://platform.harvestapp.com/javascripts/generated/platform.js).

<a name="config"></a>
## What configuration options do I need to specify?

The following options can be specified when [including the Harvest
Platform](#include) in your application.

- **applicationName** - name of your application. This is used to identify
  associations between your application and projects within Harvest.

- **permalink** _(optional)_ - template used for items in your application. This
  is processed along with the [data attributes](#attributes) you provide to
  build a unique permalink for each item.

- **skipStyling** _(optional)_ - whether or not the use the default
  timer styles provided by Harvest. If you wish to [provide your own
  styles](#styling), just set this to `true`.

<a name="timers"></a>
## How can I add timers to my items?

When the Harvest Platform is initialized, it searches for all elements with
class `harvest-timer` and links each to an entry in Harvest.

To add timers to your items, insert an HTML element with class
`harvest-timer` wherever you wish you display timers in your application. To
associate the timer with an item, you'll need to specify a few
[attributes](#attributes).

**Note:** Only elements that exist in the DOM when the Harvest Platform is
loaded will be associated. To associate new items, you can [fire a JavaScript
event](#events) containing information about the new element.

```html
  <div class="harvest-timer"></div>
```

<a name="attributes"></a>
### Attributes

Each timer element contains attributes that allow Harvest to link back to items
in your application using permalinks. For Harvest to properly track time to an
item, both `data-project` and `data-item` attributes are required. For products
in which projects and items exist within the context of an account (e.g.
Basecamp), a `data-account` attribute should also be specified.

```html
<div class="harvest-timer" 
  data-account='{"id":42"}'
  data-project='{"id":42,"name":"Harvest Platform"}'
  data-item='{"id":1337,"name":"Write documentation"}'>
</div>
```

<a name="events"></a>
## How can I add timers to new items?

When you add a new item in your application, you'll need to fire a JavaScript
event to let the Harvest Platform know that a new element needs association.
Currently, the platform supports events of type `CustomEvent` and
`jQuery.Event`.

```javascript
var harvestEvent = {
  type: "harvest-event:timers:add",
  element: $(".harvest-timer").last()
}

$("#harvest-messaging").trigger(harvestEvent);
```

### Event Types

- **harvest-event:ready** - fired by the platform itself to acknowledge that
  everything has been loaded.
  
    **Note:** This is fired on the `body` element,
    since `#harvest-messaging` won't exist until the platform has been
    initialized.

- **harvest-event:timers:add** - used whene one or more `harvest-timer` element
  exists in the DOM and requires association. This includes an `element`
  attribute to represent the `harvest-timer` object.

<a name="styling"></a>
## How can I add custom styles to timers in my application?

The Harvest Platform will provide a default style for `harvest-timer` elements
and the `harvest-timer-icon` embedded within each. This will append a `styled`
class to all timer elements and their children. By specifying the `skipStyling`
attribute in your [configuration](#config), you can use your own styles.

Adding a style to the `harvest-timer` class will apply to the timer when it is
not running in Harvest. When the timer is running, the `running` class will be
added to the element representing the running timer and all of its child
elements.

To provide a custom style for the timer icon, just add a style for the
`harvest-timer-icon` class.
