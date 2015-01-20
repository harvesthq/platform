# Harvest Platform Documentation

For a brief overview of the Harvest Platform and how it can be implemented, learn more [here](http://www.getharvest.com/platform) and 
[watch the video introduction](http://www.youtube.com/watch?v=5_fVPnH7VBU).

## How does the Harvest Platform benefit your customers?
The Harvest Platform gives your customers a way to track time. Better yet, they never have to leave your application to do so. Just a few other reasons why your customers might love the Harvest Platform, in order of importance:

1. Timesheet entries in Harvest link back to projects/tasks in your app, so people can quickly see the full details of a specific time entry.
2. The titles of the projects/tasks in your app populate the Notes field of a Harvest timer so that people don’t have to re-enter the details of their work.
3. For each of your app’s projects/tasks, the Harvest timer pre-selects the last project/task that a person tracked time to. This ensures that people are consistent with their time tracking in Harvest, and means less clicks to get to work.
4. All time tracked to that project/task shows up at the bottom of the Harvest Platform modal. This lets people quickly see how much time they’ve spent on a project/task without ever having to leave your app.

## How does the Harvest Platform benefit you?
You don’t have to reinvent time tracking! You can stay focused on developing your core product and let us take care of time tracking, reporting, and invoicing. Your users will also stay inside your app when tracking time, making for a nice user experience.

You’re spared from complex API calls. You don’t have to understand how time is tracked via Harvest, what projects and tasks are, or who has permissions to do what. This is all done for you—all you have to do is add the Harvest timer to your interface with some simple JavaScript and HTML.

## What types of apps typically implement the Harvest Platform?
The most common apps that use the Harvest Platform are project management and issue tracking applications. These integrations have been highly successful, because their customers value being able to track time with minimal clicks, and tie back time entries to specific projects/tasks. 

- **Project Management**: Basecamp, Trello, Asana, Flow, Glip, Teamwork
- **Issue Tracking**: DoneDone

That’s not to say that it doesn’t make sense with other applications, too! These are just the ones who’ve added the Harvest Platform so far.

## How do customers use the time they track via the Harvest Platform?
It varies by customer. But the two main Harvest features that customers will use with their time tracked via the Harvest Platform are invoicing and reporting. Some customers need to bill their clients for the time they track via your application, whether they’re managing projects or providing customer support. Other customers just use this time data internally to see where their time is being spent, gauge profitability, or monitor employee performance.

## What should you know before working on implementing the Harvest Platform with your app?
- In our technical documentation, we say that the [permalink](https://github.com/harvesthq/platform#what-configuration-options-do-i-need-to-specify) is optional. Which is true, it is. But, linking Harvest time entries back to your app’s attributes is one of the top reasons why customers use the Harvest Platform integrations. Having this linkage makes the success of your integration all the more likely.
- We say that you can apply custom styles to the Harvest timer within your app, but we recommend that you use blue as the color to indicate a running timer. Our customers are used to this in the Harvest interface, so it won’t require any additional thought to understand when they have a timer running from your app.


## FAQ

1. [How can I add the Harvest Platform to my application?](#include)
2. [What configuration options do I need to specify?](#config)
3. [How can I add timers to my items?](#timers)
4. [How can I add timers to new items?](#events)
5. [How does Harvest know which project to associate with my items?](#association)
6. [How can I add custom styles to timers in my application?](#styling)
7. [Will the Harvest Platform detect when timers are started and stopped from within Harvest itself?](#running)
8. [What browsers does the Harvest Platform support?](#browser-support)

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

<a name="config"></a>
## What configuration options do I need to specify?

The following options can be specified when [including the Harvest
Platform](#include) in your application.

- **applicationName** - name of your application. This is used to identify
  associations between your application and projects within Harvest.

- **permalink** _(optional)_ - template used for items in your application. This
  is processed along with the [data attributes](#attributes) you provide to
  build a unique permalink for each item.

- **skipStyling** _(optional)_ - whether or not to use the default
  timer styles provided by Harvest. If you wish to [provide your own
  styles](#styling), just set this to `true`.

- **skipJquery** _(optional)_ - whether or not to load Harvest's jQuery in the
  Harvest Platform load sequence. If you prefer to use your own and avoid a
  second HTTP request, set this to `true`. **Note: If using a version of jQuery
  older than the one used in the Harvest Platform (v1.7.2), you may experience
  issues.

<a name="timers"></a>
## How can I add timers to my items?

When the Harvest Platform is initialized, it searches for all elements with
class `harvest-timer` and links each to an entry in Harvest.

To add timers to your items, insert an HTML element with class
`harvest-timer` wherever you wish to display timers in your application. To
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

Each attribute is represented by a JSON object. Just escape your strings with
`JSON.stringify`, and we'll unescape them on our end.

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
  
    **Note:** This is fired on the `body` element since `#harvest-messaging`
    won't exist until the platform has been initialized.

- **harvest-event:timers:add** - used when one or more `harvest-timer` elements
  exist in the DOM and require association. This includes an `element`
  attribute to represent the `harvest-timer` object.

<a name="association"></a>
## How does Harvest know which project to associate with the groups in my application?

Harvest will use the company, the third-party domain, and the third-party
project ID to associate a third-party project with one of its own.  Once time
has been tracked to a third-party project, Harvest will remember the
association for other users.

**Note:** The Harvest Platform will strip the "www" subdomain, so users can
access the same projects regardless of whether or not they use the subdomain to
access your application.

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

<a name="running"></a>
## Will the Harvest Platform detect when timers are started and stopped from within Harvest itself?

Yes. The Harvest Platform will check for the running timer in Harvest every 30
seconds and then change UI elements accordingly.

<a name="browser-support"></a>
## What browsers does the Harvest Platform support?

The Harvest Platform supports Internet Explorer 9 and later, and the latest versions of Chrome, Firefox, and Safari.
