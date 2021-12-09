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
    "permalink": "https://example.com/item-1337"
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
| <pre>applicationName (required)</pre> | String. The human-readable name of your application.
| <pre>skipStyling (optional)</pre>     | Boolean. `true` or `false` indicating if you’d like the default styles applied to timer elements. Default: `false`
| <pre>permalink (*required)</pre>      | String. A URL linking back to your application. This will be displayed alongside your timer in Harvest.

These settings are set on each timer DOM element as attributes:

| Attribute                 | Description
|---------------------------|-------------
| <pre>data-item (required)</pre>       | Object. A JSON object containing `id` and `name` properties representing the item in your application this timer is related to. The `name` property will be filled into the Notes field of the timer dialog.
| <pre>data-group (optional)</pre>      | Object. A JSON object containing `id` and `name` properties representing the group in your application that this item belongs to. `name` will allow for creating a Harvest Project of that name to track time to. If your application does not have a higher-level group, this may be omitted.
| <pre>data-account (optional)</pre>    | Object. A JSON object containing an `id` property — used only to populate `%ACCOUNT_ID%` in the `permalink` configuration setting. If you are not using `%ACCOUNT_ID%`, there is no need to set this attribute.
| <pre>data-default (optional)</pre>    | Object. A JSON object containing a `project_name` or `project_code` property — used to pre-select a suggested project by either its name or code. This has to be an exact match.**
| <pre>data-permalink (*required)</pre> | String. A URL linking back to the item in your application this timer is related to. This will be displayed alongside your timer in Harvest.

`*` You must have either `permalink` in your global configuration settings, or `data-permalink` in your timer/s attributes. Use the former if you only want to add one timer element or if you want all timer elements to have the same permalink. Use the latter if you want to have multiple timer elements with unique permalinks.

`**` The project code and project name can be found in your Harvest Account under projects:

<img width="668" alt="Screen Shot 2021-12-09 at 2 55 44 PM" src="https://user-images.githubusercontent.com/23469053/145486505-631b7d1b-da1e-4d03-8f86-cfe6d781b8e3.png">

## Examples

#### Multiple Unstyled Buttons With Data Group

Timer DOM elements:

```html
<div class="harvest-timer"
  data-item='{"id":1337,"name":"Remove unused libraries"}'
  data-group='{"id":179","name":"Q4 Projects: Cleanup Tech Debt"}'
  data-permalink='https://example.com/projects/179/1337'>
</div>
```

```html
<div class="harvest-timer"
  data-item='{"id":1338,"name":"Add more testing"}'
  data-group='{"id":179","name":"Q4 Projects: Cleanup Tech Debt"}'
  data-permalink='https://example.com/projects/179/1338'>
</div>
```

Global configuration settings:

```javascript
window._harvestPlatformConfig = {
  "applicationName": "ExampleCompany",
  "skipStyling": true
};
```

#### Single Styled Button With Data Default

Timer DOM element:

```html
<div class="harvest-timer"
  data-item='{"id":1337,"name":"Remove unused libraries"}'
  data-default='{"project-code":"q4-projects-cleanup}'>
</div>
```

Global configuration settings:

```javascript
window._harvestPlatformConfig = {
  "applicationName": "ExampleCompany",
  "permalink": "https://example.com/projects/1337"
};
```

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
