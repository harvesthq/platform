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
    "permalink": "https://example.com/items/%ITEM_ID%"
  };
</script>
<script async src="https://platform.harvestapp.com/assets/platform.js"></script>
```

The script will handle it from here!

If you need to add a Harvest Button after the script has loaded, see [Adding Buttons After Loading](#adding-buttons-after-loaded).

## Configuration Options

### Global Configuration

These global configuration settings are set on the `window._harvestPlatformConfig` object:

| Parameter                  | Description
|----------------------------|-------------
| <pre>applicationName (required)</pre> | String. The human-readable name of your application.
| <pre>skipStyling (optional)</pre>     | Boolean. `true` or `false` indicating if you’d like the default styles applied to timer elements. Default: `false`
| <pre>permalink (*required)</pre>      | String. A URL linking back to your application. This will be displayed alongside your timer in Harvest.

### Timer DOM Element Configuration

These settings are set on each timer DOM element as attributes:

| Attribute                 | Description
|---------------------------|-------------
| <pre>data-item (required)</pre>       | Object. A JSON object containing `id` and `name` properties representing the item in your application this timer is related to. `id` will populate `%ITEM_ID%` in the `permalink` global configuration setting. `name` will be filled into the Notes field of the timer dialog.
| <pre>data-group</pre>      | Object. A JSON object containing `id` and `name` properties representing the group in your application that this item belongs to. `id` will populate `%GROUP_ID%` in the `permalink` global configuration setting. `name` will allow for creating a Harvest Project of that name to track time to. 
| <pre>data-account (optional)</pre>    | Object. A JSON object containing an `id` property — used only to populate `%ACCOUNT_ID%` in the `permalink` global configuration setting. If you are not using `%ACCOUNT_ID%`, there is no need to set this attribute. The account ID is tied to a personal access token which can be created or found at https://id.getharvest.com/developers 
| <pre>data-default (optional)</pre>    | Object. A JSON object containing a `project_name` or `project_code` property — used to pre-select a suggested project by either its name or code. This has to be an exact match.**
| <pre>data-permalink (*required)</pre> | String. A URL linking back to the item in your application this timer is related to. This will be displayed alongside your timer in Harvest.

`*` You must have either `permalink` in your global configuration settings, or `data-permalink` in your timer's attributes. Use the former if you only want to add one timer element or if you want all timer elements to have the same permalink. Use the latter if you want to have multiple timer elements with unique permalinks.

`**` The project code and project name can be found in your Harvest Account under Projects while editing the targeted project:

<img width="685" alt="ProjectNameCode" src="https://user-images.githubusercontent.com/23469053/145632213-223e8822-cf17-49da-b496-fced6f70c791.png">

## Examples

#### Multiple Unstyled Buttons With Data Group

Timer DOM elements:

```html
<div class="harvest-timer"
  data-item='{"id":1337,"name":"Remove unused libraries"}'
  data-group='{"id":179,"name":"Q4 Projects: Cleanup Tech Debt"}'
  data-permalink='https://example.com/projects/179/1337'>
</div>
```

```html
<div class="harvest-timer"
  data-item='{"id":1338,"name":"Add more testing"}'
  data-group='{"id":179,"name":"Q4 Projects: Cleanup Tech Debt"}'
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

Timer UI:

<img width="500" alt="DataGroup" src="https://user-images.githubusercontent.com/23469053/175624106-c3545d76-22f4-4681-905e-284b1e1b0400.png">

Timesheet in Harvest with Time Tracked from the Harvest Button:

<img width="500" alt="DataGroupTimesheet" src="https://user-images.githubusercontent.com/23469053/175625194-1ba17ac4-788f-4edf-a706-beeed5858577.png">

Timesheet permalink:

<img width="339" alt="DataGroupPermalink" src="https://user-images.githubusercontent.com/23469053/145631967-5f6572b6-5e84-4246-94ff-978a9844e1ec.png">


#### Single Styled Button With Data Default

Timer DOM element:

```html
<div class="harvest-timer"
  data-item='{"id":1337,"name":"Remove unused libraries"}'
  data-default='{"project_code":"q4-projects-cleanup"}'>
</div>
```

Global configuration settings:

```javascript
window._harvestPlatformConfig = {
  "applicationName": "ExampleCompany",
  "permalink": "https://example.com/projects/1337"
};
```

Timer UI:

<img width="500" alt="DataDefault" src="https://user-images.githubusercontent.com/23469053/175630649-1b81660e-5fcd-44d1-92d8-51533d6c5a28.png">


Timesheet permalink:

<img width="354" alt="DataDefaultPermalink" src="https://user-images.githubusercontent.com/23469053/145632047-02b4cf5e-e39d-4f1f-9be5-c957c0556c76.png">


#### Single Styled Button Using Ids to Populate Permalink

Timer DOM element:

```html
<div class="harvest-timer"
  data-item='{"id":1337,"name":"Remove unused libraries"}'
  data-group='{"id":179,"name":"Q4 Projects: Cleanup Tech Debt"}'
  data-account='{"id":"1278453"}'>
</div>
```

Global configuration settings:

```javascript
window._harvestPlatformConfig = {
  "applicationName": "ExampleCompany",
  "permalink": "https://example.com/%ACCOUNT_ID%/%GROUP_ID%/%ITEM_ID%"
};
```

Timesheet permalink:

<img width="332" alt="PopulatedPermlink" src="https://user-images.githubusercontent.com/23469053/145632101-be3ec71f-63a1-476e-a260-f1f403ea5149.png">


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
