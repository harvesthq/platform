# Harvest Platform Documentation

Here is a brief overview of how the Harvest Platform can work with your app.

## How does the Harvest Platform benefit your customers?
The Harvest Platform gives your customers a way to track time. Better yet, they never have to leave your application to do so. Just a few other reasons why your customers might love the Harvest Platform, in order of importance:

1. Timesheet entries in Harvest link back to projects/tasks in your app, so people can quickly see the full details of a specific time entry.  
![](https://www.getharvest.com/assets/platform/harvest-platform-harvest-2268ac5a9b1f5db6e988761d361b2e9d.png)
2. The titles of the projects/tasks in your app populate the notes field of a Harvest timer so that people don’t have to re-enter the details of their work.
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
- In our technical documentation, we say that the [permalink](https://github.com/harvesthq/platform/blob/master/Platform_Technical_FAQ.md#what-configuration-options-do-i-need-to-specify) is optional. Which is true, it is. But, linking Harvest time entries back to your app’s attributes is one of the top reasons why customers use the Harvest Platform integrations. Having this linkage makes the success of your integration all the more likely.
- We say that you can apply custom styles to the Harvest timer within your app, but we recommend that you use blue as the color to indicate a running timer. Our customers are used to this in the Harvest interface, so it won’t require any additional thought to understand when they have a timer running from your app.

**Ready to dive into the few technical details?** Click [here](https://github.com/harvesthq/platform/blob/Platform-Best-Practices/Platform_Technical_FAQ.md) for a technical FAQ or
[watch the video introduction](http://www.youtube.com/watch?v=5_fVPnH7VBU).
