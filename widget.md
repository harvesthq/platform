# Harvest Widget Documentation

This embedded `<iframe>` allows you to embed a Harvest Timer form directly into your application. Create an `<iframe>` like this:

```html
<iframe src="https://platform.harvestapp.com/platform/timer?app_name=ExampleCompany&closable=false&permalink=https%3A%2F%2Fexample.com%2Fitem%2F1&external_item_id=1&external_item_name=Programming&external_group_id=2&external_group_name=TPS%20Reports">
</iframe>
```

## Parameters

**It is your responsibility to correctly encode these parameters.** If you’re building this URL in JavaScript, you’ll want to use [`encodeURIComponent`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent).

| Parameter                      | Description
|--------------------------------|-------------
| <pre>app_name (optional)</pre>             | The human-readable name of your application.
| <pre>external_item_id (required)</pre>     | A machine-identifier for the item in your application this timer is related to.
| <pre>external_item_name (optional)</pre>   | The human-readable name of the item in your application this timer is related to. This will be filled into the Notes field.
| <pre>external_group_id (optional)</pre>    | A machine-identifier for the group in your application that the item belongs to. If your application does not have a higher-level group, this may be omitted.
| <pre>external_group_name (optional)</pre>  | The human-readable name of the group that the item belongs to. Will allow for creating a Harvest Project of that name to track time to. If your application does not have a higher-level group, this may be omitted.
| <pre>permalink (required)</pre>            | A URL linking back to the item in your application this timer is related to. This will be displayed alongside your timer in Harvest.
| <pre>closable (optional)</pre>             | `true` or `false` indicating if Close or Cancel buttons should be rendered. Default:  `true`
| <pre>chromeless (optional)</pre>           | `true` or `false` indicating if the Harvest branding should be rendered. Default: `false`
| <pre>default_project_code (optional)</pre> | Pre-select the suggested project by its code. This has to be an exact match.*
| <pre>default_project_name (optional)</pre> | Pre-select the suggested project by its name. This has to be an exact match.*

`*` The project code and project name can be found in your Harvest Account under Projects while editing the targeted project:

<img width="700" alt="ProjectNameCode" src="https://user-images.githubusercontent.com/23469053/145894881-6508e91a-74f7-46cc-8012-5092986eea9f.png">

## Examples

#### Harvest Timer form with external item, external group, and default project

Parameters:

```javascript
{
  "app_name": "ExampleCompany",
  "external_item_id": 1337,
  "external_item_name": "Remove unused libraries",
  "external_group_id": 179,
  "external_group_name": "Q4 Projects: Cleanup Tech Debt",
  "default_project_code": "q4-projects-cleanup",
  "permalink": "https://example.com/projects/179/1337"
};
```

Embedded `<iframe>`:

```html
<iframe src="https://platform.harvestapp.com/platform/timer?app_name=ExampleCompany&permalink=https%3A%2F%2Fexample.com%2Fprojects%2F179%2F1337&external_item_id=1337&external_item_name=Remove%20unused%20libraries&external_group_id=179&external_group_name=Q4%20Projects%3A%20Cleanup%20Tech%20Debt&default_project_code=q4-projects-cleanup">
</iframe>
```

Timer UI:

<img width="700" alt="Timer" src="https://user-images.githubusercontent.com/23469053/175380097-648f5b22-e3ac-4b09-91d3-94dfcd99ce0c.png">


Timesheet in Harvest with Time Tracked from the Harvest Widget:

<img width="700" alt="Timesheet" src="https://user-images.githubusercontent.com/23469053/175379120-76b9e704-56ab-46d6-81ab-80416d1e5fdf.png">


#### Harvest Timer form with `chromeless` set as true and `closable` set as false

Parameters:

```javascript
{
  "app_name": "ExampleCompany",
  "external_item_id": 1337,
  "default_project_code": "q4-projects-cleanup",
  "permalink": "https://example.com/projects/179/1337",
  "closable": false,
  "chromeless": true
};
```

Embedded `<iframe>`:

```html
<iframe src="https://platform.harvestapp.com/platform/timer?app_name=ExampleCompany&permalink=https%3A%2F%2Fexample.com%2Fprojects%2F179%2F1337&external_item_id=1337&default_project_code=q4-projects-cleanup&closable=false&chromeless=true">
</iframe>
```

Timer UI:

<img width="700" alt="ChromelessTimer" src="https://user-images.githubusercontent.com/23469053/175378810-c24bd688-9b7b-46ac-971a-1ae08dfa6666.png">


## Resizing the Height *(optional)*

The height of the content within the frame changes as the user interacts with the timer form. Each time the height of the content changes, the `<iframe>` emits a cross-domain message with the new height (in pixels) of the content. Optionally listen to these messages and resize the `<iframe>` as needed:

```javascript
window.addEventListener("message", function (event) {
  if (event.origin != "https://platform.harvestapp.com") {
    return;
  }

  if (event.data.type == "frame:resize") {
    document.querySelector("iframe").style.height = event.data.value + "px";
  }
});
```
