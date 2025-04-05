# ramen-noodle-calculator
Dart/Flutter Code for the soon-to-be defunct Ramen Noodle Calculator in the [Android Play Store](https://play.google.com/store/apps/details?id=com.gonya707.noodlecalc). For the time being the app is up and running in web form [[here]](https://sensai7.github.io/ramen_noodle_calc/#/).

I make this code public since I haven't keep with Flutter development and I am completely unable to make the app work again with all the API and library changes, manifest changes and gradle structure changes. If you want to continue the development, port it from Flutter to other language, or have any interest in how the app worked, feel free to give it a try.

Here are some things that got suggested to me or I thought as future features/fixes:

 * __Add more flours:__ in the file `lib/flour.dart` there's a database of all the flours I've got information on protein content over the years. Most of these were kindly given to me via The Ramen Network discord server. Special thanks to dragon__pl for the Nisshin flours info.

 * __Add more nutritional values to the flour database:__ The database is organized in a map/dictionary form so it should be easy to add more nutritional values to each flour.

 * __Increase the number of flours from 3 to more:__ The very first thing I thought about this app was the interactive ternary plot to balance the mix of 3 flours and figure out what was the protein content, the rest of the app was built around this whole idea. Increasing the mix to more than 3, while useful, is a challenge in terms of user interface, you probably will need to add some "block" buttons to stop values from changin while you adjust other 2 or more values via a slider or ternary plot. 

 * __Add a way to calculate ratio of ions in Kansui using substitute salt, similar to the flour mix:__ Proposed by EP the chemist back in the day.

 * __Fix: make a way to make for saving/loading recipes the same in app and web app.__

 * __Fix: make a way to keep old recipes working when there's a flour database update:__ As it is coded now, if a new flour is added, the previously saved recipes could point to a wrong flour name.

 * __Fix: Change the DropdownMenu2 widgets to a more contemporary (and fast) widget:__ These widgets are by far the more performance consuming since they load the entire flour database, so as the database grows, it'll get more to load. This is usually no problem in the release versions but the debugging version gets really laggy. Also this is one of the widgets that I was unable to upgrade when trying to recompile the code.

 * __Add more adjuncts__

 * __Auto-generate category tags or noodle name:__ Based on the protein, hydration, adjuncts etc. Some tags could be generated like "Low hydration", "Spicy", or if the hydration/protein ratio falls into certain range, tags like "Chuuka soba style", "Hakata style", etc tags could be also created (check `images/protein.png`). Also if the user cannot think of a good name for the noodle recipe, the name could be auto-generated.

 * __Ways to earn money with this app:__ I was never interested in this but you can do it, if you manage to publish it. The most obvoious one would be to add advertising, but giving referal links to amazon etc. to buy the flours or kansui would be less intrusive.
