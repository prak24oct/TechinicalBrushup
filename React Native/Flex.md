# The Full React Native Layout Cheat Sheet

## flexDirection
* ### ‘column’/’column-reverse’/’row’/’row-reverse’
* Defines the direction of the main axis. Opposite to the web, React Native default flexDirection is column.


## flex 
* flex will define how your items are going to “fight” over the available space along your primary axis.
* Space will be divided according to each element flex property.

## justifyContent
* #### ‘flex-start’/’flex-end’/’center’/’space-between’/’space-around’
* Determines the distribution of children along the primary axis
* The default value is flex-start


## alignItems
* #### ‘flex-start’, ‘flex-end’, ‘center’, ‘stretch’
* Align items along the cross axis. So in a default view, it will control the horizontal alignment of items.
* stretch wouldn’t work if you have a specific width
* If you don’t have a specific width flex-start and flex-end wouldn’t understand what to do.


## alignSelf
* #### ‘flex-start’, ‘flex-end’, ‘center’, ‘stretch’
* align an item along the cross axis overwriting his parent alignItem property


## flexWrap
* #### ‘wrap’, ‘nowrap’‘wrap’, ‘nowrap’
* Controls whether flex items are forced on a single line or can be wrapped on multiple lines.
* The default value is nowrap

## alignContent
* #### ‘flex-start’/’center’/’flex-end’/’stretch’/’space-between’/’space-around’
* if you went with flexWrap:'wrap' you have multiple lines of items, this property will help you align the lines on the cross-axis.


## position
* ### ‘relative’/’absolute’
* The default value is relative
* If the element is set to relative it will respect the line and will position himself relatively to the element in front of it. If the element is set to absolute it will ignore all of the element in the line and will position himself as if the line was empty


## zIndex
* You can control which components display on top of others.