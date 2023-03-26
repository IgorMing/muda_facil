# Muda Fácil App

App for learning flutter _(and maybe become a solution for house moving)_

> Here's a [link](https://app.diagrams.net/#G1ddqhjFzTeCn-ubGbUCgLDcDuqTYL2Z4N) to Some wireframes and basic screen navigation flow

## MVP TODOs

- [x] check how to get app's ThemeMode properly
- [x] implement reset password flow
- [x] get list of items from firebase firestore
- [x] filter out from autocomplete list all items that were already selected
- [x] add a way to include a comment/observation for each item of the list
- [x] do a visual diagram exposing the data distribution/architecture
- [x] change the way that we add observations. Use ExpansionTile instead. _(better UX)_
- [x] add a consistent first option to "add" the string that were not found
- [x] create review screen
- [x] show current moving order in home screen. _(create a separated widget to it)_
- [x] check the best way to treat date
- [x] make a better UI for the current order, and validate the UI if the order is null
- [x] navigate to items screen for editting the order
- [x] save user role on firebase on signup flow
- [x] add address flow
- [x] on confirming the review, persist it on firestore _(save it on a new sub collection called `orders/`, into the `users/` collection)_
- [x] remake the order creation flow to provide a good UX
- [x] show order items for a better UX
- [x] add moving date flow _(with platform adaptive datepicker)_
- [x] save the date on the flow only after clicking in confirm
- [x] add/update order in firestore
- [ ] prepare the moving order structure to have both status and "pix code"
- [ ] add a way to copy a pix value, for paying the moving order
- [ ] push notification when the order takes any feedback _(e.g. driver responded and the price is ready for approval)_
- [ ] when the payment gets done, we provide the driver's phone _(does that make sense? keep thinking...)_

- [ ] configure splash screen

## Less priority TODOs

- [ ] find items that are not in the list, and persist them into a different document _(add into a doc called `candidates` under items collection)_

- [ ] add a progress bar to the order

- [ ] add a way to the user change its name

- [ ] create an admin tab that can check new items on a separated list, and edit/approve it. _(Approve means: Remove it from `items/candidates` Add it to the document `items/list`)_

- [ ] separate items on groups, to make the user's lifes easier

- [ ] change focus based on which button was pressed _(for addresses)_

## Structural info

- put to the moving order structure
  - Req
    - origin address
    - destiny
    - items
    - status (which ones?)
  - Opt
    - flexible? _(bool)_
    - pix code?
    - declinedReason?

## Main flow

- new moving order
  - add origin address
  - add items -> _status(pending_destiny)_ -> HOME
  - add destiny -> HOME -> _status(waiting_driver)_
    - Here is where we do the manual work for finding a driver to work on that order
  - users sees home screen with _status(pending_approval)_
  - if user declines, open a input dialog for explaining why... and set the status to _status(declined)_
  - after user approves it, set _status(approved)_

## bug

- [x] when I add more than one item, and I try to add more items to one of them, both changes. Fix it!
