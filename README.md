# Integrating with Harvest

<table>
  <thead>
    <tr>
      <th>Harvest Button</th>
      <th>Harvest Widget</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td width="50%">
        <a href="button.md"><img src="http://cl.ly/image/0q0W1H003p1n/Image%202015-06-15%20at%204.00.36%20PM.png" alt="Screenshot of the Harvest Button in action"></a>
      </td>
      <td width="50%">
        <a href="widget.md"><img src="http://cl.ly/image/2p0r2c251I2w/Image%202015-06-16%20at%2011.31.29%20AM.png" alt="Screenshot of the Harvest Widget in action"></a>
      </td>
    </tr>
    <tr>
      <td>The Harvest Button is a script that runs within your application to provide a clock icon that, when clicked, shows a modal dialog with a form to track time in Harvest. <a href="button.md">Get started!</a></td>
      <td>The Harvest Widget is a frame that is loaded by your application that contains a form to track time in Harvest. <a href="widget.md">Get started!</a></td>
    </tr>
  </tbody>
</table>

## User Authentication

There is no additional configuration within your application for selecing a Harvest account or user. The user’s browser session is used to find what Harvest user is currently logged in — or, if no Harvest users are logged in, a login form is presented instead of the time tracking form when it is displayed.

## Harvest Project and Task Suggestion

Harvest will take the information you provide about the item the user is tracking time against to suggest a Harvest Project and Task that we think the user is most likely to use. You cannot set the Harvest Project and Task shown by default explicitly.

The Harvest Project and Task suggested is based on what time has already been tracked to this item in your application. If no time has been tracked to this item yet, then the suggestion is based off the group that the item is a part of in your application. If the group also has no time tracked, a Harvest Project that was created from the time tracking form will be considered.

## Browser Support

Both the Harvest Button and the Harvest Widget support [the same browsers that Harvest supports](https://www.getharvest.com/help/supported-browsers).
