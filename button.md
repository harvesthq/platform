# Harvest Button Documentation

The Harvest Button works by running a script that handles creating elements and their respective behavior.

Add Harvest Button placeholders to your application where appropriate:

```html
<div class="harvest-timer"
  data-item='{"id":1337,"name":"Write documentation"}'>
</div>
```

Then, drop this `<script>` into your application:

```javascript
<script>
  window._harvestPlatformConfig = {
    "applicationName": "ExampleCompany",
    "permalink": "https://example.com/item/%ITEM_ID%"
  };
</script>
<script async src="https://platform.harvestapp.com/assets/platform.js"></script>
```

The script will handle it from here!

If you need to add a Harvest Button after the script has loaded, see [Adding Buttons After Loading](#adding-buttons-after-loaded).

## Configuration Options

These global configuration settings are set on the `window._harvestPlatformConfig` object:

| Parameter                  | Description
|----------------------------|-------------
| <pre>applicationName</pre> | The human-readable name of your application. Example: `Trello`
| <pre>skipStyling</pre>     | `true` or `false` indicating if you’d like the default styles applied to timer elements. Default: `false`

These settings are set on each timer DOM element as attributes:

| Attribute                 | Description
|---------------------------|-------------
| <pre>data-item</pre>      | A JSON object containing `id` and `name` properties representing the item in your application this timer is related to. The `name` property will be filled into the Notes field of the timer dialog. For example, a Trello Card: `{"id":"Y7h4fW14","name":"Update image on landing page."}`
| <pre>data-group</pre>     | A JSON object containing `id` and `name` properties representing the group in your application that this item belongs to. If your application does not have a higher-level group, this may be omitted. For example, a Trello Board: `{"id":"0FdAjinR","name":"Landing Pages Overhaul"}`
| <pre>data-account</pre>   | A JSON object containing an `id` property — used only to populate `%ACCOUNT_ID%` in the `permalink` configuration setting. If you are not using `%ACCOUNT_ID%`, there is no need to set this attribute.
| <pre>data-default</pre>   | A JSON object containing a `project_name` or `project_code` property — used to pre-select a suggested project by either its name or code. This has to be an exact match. For example: `{"project_code":"GOOG123"}` or `{"project_name":"Project 123 for Google"}`
| <pre>data-permalink</pre> | A URL linking back to the item in your application this timer is related to. This will be displayed alongside your timer in Harvest.

## Detecting When Loaded

When the Harvest Buttons are ready for use, an event named `harvest-event:ready` will be triggered on the `<body>` element. To subscribe to this event:

```javascript
// Using jQuery:
$("body").on("harvest-event:ready", function () {
  console.log("Harvest Buttons are ready.");
});

// Using Standard JavaScript:
document.body.addEventListener("harvest-event:ready", function () {
  console.log("Harvest Buttons are ready.");
});
```

## Adding Buttons After Loaded

Harvest Button elements added to the page after the script has loaded won’t be immediately recognized. To trigger the script to load new timers:

```javascript
// Using jQuery:
$("#harvest-messaging").trigger({
  type: "harvest-event:timers:add",
  element: $("#newly-added-timer")
});

// Using Standard JavaScript:
var event = new CustomEvent("harvest-event:timers:add", {
  detail: { element: document.querySelector("#newly-added-timer") }
});
document.querySelector("#harvest-messaging").dispatchEvent(event);
```
