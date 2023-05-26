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
- [x] add a way to use RefreshIndicator on my order
- [x] prepare the moving order structure to have status
- [x] make general review screen
- [x] delete a pending order
- [x] add a way to refresh the entire current order
- [x] add a way to ask for help, after sending an order
- [x] show different content if order is pending and if it's waiting for a driver
- [x] after we get a driver, we should display the driver information
  - [x] provide a way to decline it _(show a input modal to a brief explanation why)_
  - [x] provide a way to approve it _(here, after the price being set, we can generate a pix code and let it ready to be used, after the user approves it)_
- [x] add a way to copy a pix value, for paying the moving order
- [x] fix general issues on signin/signout
- [x] fix UI issues on Android
- [x] show different tabs based on the access role
- [ ] when the payment gets done, we provide the driver's phone _(does that make sense? keep thinking...)_
- [x] listen for order data changes
- [x] double check the entire flow, from the initial to finish
- [x] add a step on the sign up flow to put the whatsapp number
- [x] improve the profile screen
- [x] configure splash screen _(maybe a rework on this will be necessary later)_
- [x] create admin screens layouts on draw.io
- [x] implement initial menu _(admin)_
- [x] create a list of orders, being able to set information and send the budget value _(admin)_
- [x] check if the order is waiting for driver or for payment _(second part of the flow that requires an admin approval)_

  - [x] if waiting for driver, open a proper modal for fill these informations
  - [x] add a logical check either for what is the current status, and consider the background color by that.

- [x] create an admin tab

- [ ] _(admin feat)_ check new items on a separated list, and edit/approve it. _(Approve means: Remove it from `items/candidates` Add it to the document `items/list`)_

- [ ] apply new UI for the user order _(following draw.io' design)_

## Less priority TODOs

- [ ] configure push notifications and send one when the order takes any feedback _(e.g. driver responded and the price is ready for approval)_

- [ ] find items that are not in the list, and persist them into a different document _(add into a doc called `candidates` under items collection)_

- [ ] add a progress bar to the order

- [ ] add a way to the user change its name

- [ ] separate items on groups, to make the user's lifes easier

- [ ] change focus based on which button was pressed _(for addresses)_

- [ ] make profile fields editable

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
  - [x] start the flow -> OrderStatus = pending
  - [x] add all required information _(origin, destiny, date and items)_
  - [ ] if user declines, open a input dialog for explaining why... and set the status -> OrderStatus = declined
  - [ ] on confirming the review, set it -> OrderStatus = waiting_driver
    - Here is where we do the manual work for finding a driver to work on that order
    - a driver accepts that trip, and sends the proposal -> OrderStatus = waiting_approval
  - [ ] user approves the order -> OrderStatus = waiting_payment_code
    - Another manual part of the flow, is creating a pix code and put it into the order
    - Generating the code, and pasting it into the firestore directly, we change the status -> OrderStatus = waiting_payment
  - [ ] after the payment gets concluded -> OrderStatus = approved
    - now just wait for the date and make the moving gets done!

## bug

- [x] when I add more than one item, and I try to add more items to one of them, both changes. Fix it!
