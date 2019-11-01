# 90s Phone Button Converter

While learnig how to program with Haskell, the guide I am reading proposes a challenge to practice data types, which is to build a program which converts button presses to either a tuple
or a list containig two tuples denoting a capital letter:


```Either (Char, Int) [('*', Int), (Char, Int)]``` 


The first aim of the excercise is to practice creating a data structure which captures the layout of the keypad.


Then create a series of functions which convert characters to the following:


* If lower case then return a tuple of (Pressed key, number of presses)
* If the Char is a number or special character such as "+_^" etc... then return a tuple of (Pressed key, number of presses)
* If the Char is an upper case letter then return a list of tuples of [(First pressed key *, number of presses), (Pressed key, number of presses)]
where * represents the first key pressed when denoting an upper case letter.


Phone keypad layout:


--------
[![xhHq4v.jpg.5b81e82e81bbe3677356d3d27196e1c9.jpg..jpg](https://s18.postimg.org/av8bdkq5l/xh_Hq4v_jpg_5b81e82e81bbe3677356d3d27196e1c9_jpg.jpg)](https://postimg.org/image/bxihw48yt/)

