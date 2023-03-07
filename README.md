# muda_facil

App for learning flutter

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

- [ ] make a better UI for the current order, and validate the UI if the order is null
- [ ] on confirming the review, persist it on firestore _(save it on a new sub collection called `orders/`, into the `users/` collection)_
- [ ] find items that are not in the list, and persist them into a different document _(add into a doc called `candidates` under items collection)_
- [ ] create differences by user role _(create new users collection, and save the role data by user)_
- [ ] prepare the moving order structure to have both status and "pix code"
- [ ] add a way to copy a pix value, for paying the moving order
- [ ] push notification when the order takes any feedback _(e.g. driver responded and the price is ready for approval)_
- [ ] when the payment gets done, we provide the driver's phone _(does that make sense? keep thinking...)_

## Less priority TODOs

- [ ] create an admin tab that can check new items on the separated list, and edit/approve it. _(Approve means: Remove it from `items/candidates` Add it to the document `items/list`)_

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
