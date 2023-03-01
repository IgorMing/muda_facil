# muda_facil

App for learning flutter

## TODOs

- [x] check how to get app's ThemeMode properly
- [x] implement reset password flow
- [x] get list of items from firebase firestore
- [x] filter out from autocomplete list all items that were already selected
- [x] add a way to include a comment/observation for each item of the list
- [x] do a visual diagram exposing the data distribution/architecture
- [x] change the way that we add observations. Use ExpansionTile instead. _(better UX)_
- [x] add a consistent first option to "add" the string that were not found
- [x] create review screen
- [ ] on confirming the review, persist it on firestore _(save it on a new collection called `orders/`)_
- [ ] find items that are not in the list, and persist them into a different document
- [ ] create differences by user role _(create new users collection, and save the role data by user)_
- [ ] create an admin tab that can check new items on the separated list, and edit/approve it. _(Approve means: Add it to the document `items/candidates`)_

## bug

- [x] when I add more than one item, and I try to add more items to one of them, both changes. Fix it!
