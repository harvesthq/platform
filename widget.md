# Harvest Widget Documentation

This embedded `<iframe>` allows you to embed a Harvest Timer form directly into your application. Create an `<iframe>` like this:

```
<iframe
  src="https://platform.harvestapp.com/platform/timer?
    app_name=ExampleCompany&
    closable=false&
    permalink=https%3A%2F%2Fexample.com%2Fitem%2F1&
    external_item_id=1&
    external_item_name=Programming&
    external_group_id=2&
    external_group_name=TPS%20Reports">
</iframe>
```

## Parameters

**It is your responsibility to correctly encode these parameters.** If you’re building this URL in JavaScript, you’ll want to use [`encodeURIComponent`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent).

| Parameter                      | Description
|--------------------------------|-------------
| <pre>app_name</pre>             | The human-readable name of your application. Example: `Trello`
| <pre>external_item_id</pre>     | A machine-identifier for the item in your application this timer is related to. For example, a Trello Card ID: `Y7h4fW14`
| <pre>external_item_name</pre>   | The human-readable name of the item in your application this timer is related to. This will be filled into the Notes field. For example, a Trello Card Name: `Update%20image%20on%20landing%20page.`
| <pre>external_group_id</pre>    | A machine-identifier for the group that the item belongs to. If your application does not have a higher-level group, this may be omitted. For example, a Trello Board ID: `0FdAjinR`
| <pre>external_group_name</pre>  | The human-readable name of the group that the item belongs to. If your application does not have a higher-level group, this may be omitted. For example, a Trello Board Name: `Landing%20Pages%20Overhaul`
| <pre>permalink</pre>            | The URL to the item in your application this timer is related to. For example, a Trello Card URL: `https%3A%2F%2Ftrello.com%2Fc%2FY7h4fW14%2F61-update-image-on-landing-page`
| <pre>closable</pre>             | `true` or `false` indicating if Close or Cancel buttons should be rendered. Default:  `true`
| <pre>chromeless</pre>           | `true` or `false` indicating if the Harvest branding should be rendered. Default: `false`
| <pre>default_project_code</pre> | Pre-select the suggested project in the dropdown by its code. Has to be an exact match. Example: `GOOG123`
| <pre>default_project_name</pre> | Pre-select the suggested project in the dropdown by its name. Has to be an exact match. Example: `Project%20123%20for%20Google`


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
