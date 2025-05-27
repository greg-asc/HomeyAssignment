# Homey Coding Assignment

This is my implementation of the coding assignment for Homey.

## Live App

This app has been deployed Heroku. To access it, please navigate to
[this page](https://homey-assignment-591c09908289.herokuapp.com/projects/1/conversation_events)
and log in with these credentials: `user1@homey.co.uk SecretPassword1234!`


## Initial Questions

This is a selection of questions to demonstrate my usual approach to building a
product such as this.

Q: What’s the expected volume of comments and status changes?
A: This will vary, but the chat should be designed to handle hundreds of
entries.

Q: Single-Table Inheritance or separate tables/models?
A: For the sake of this task let's use STI, prioritising the linear history.
STI doesn't scale particularly well if we tried adding more subclasses in the
future. An alternative solution would be to have separate tables but
aggregating the complete chat history with comments, status changes, and
potentially other events could require complex joins

Q: Are there specific formatting requirements for comments?
A: Markdown support should be enough.

Q: Should the conversation history be ordered chronologically?
A: Yes, with the most recent activity at the top.

Q: Do we need threads in replies?
A: No, let's keep it flat/linear for simplicity.

Q: Are we aiming for near real-time updates (WebSockets/Turbo) or should we
just poll periodically?
A: Let's use Turbo for now and leave a more sophisticated implementation for
later.

Q: Do we need to assign owners to projects?
A: We might need that in the future. For the sake of simplicity


## Overview

I'm using Devise for basic user authentication. There are view components for
comments, status updates, and the project header containing key project info; a
form object to encapsulate some core business logic (after some thought I maybe
should have created an interactor for that) The seeds script contains a short
example conversation.  After the initial data modelling step, I realised that I
wasn't going to get everything done the way I initially hoped, I tried marking
those areas in the code with `TODO`s, there's also the unused Reaction model
with its Reactable concern (for polymorphism) that I didn't build a UI for (but
it's included in the seeds script to demonstrate the basic idea).  3 hours is
definitely not a lot so to save time used AI to generate the Tailwind classes
and also for generating example comments, to make the conversation look
realistic.


## Other Ideas for Later

Considering this task was limited to ~3 hours, I had to be strategic about what
to implement and how. Given enough time however, these are the ideas I think
would be worth exploring to improve the performance, UX, etc.

- notifications, e.g. sending emails about status changes;
- Pundit for limiting access to conversations (e.g. based on project
  membership) and/or certain actions (e.g. only project owners can update
  status);
- tagging users in replies, especially useful in a linear chat;
- the ability to edit comments (this could be time-limited);
- reactions UI - 
- infinite scroll with Turbo and Pagy - only load the most recent comments and
  status changes, then scroll to load history.
