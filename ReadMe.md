# Pretty Reputation tags

You can use available data from [Pretty Reputation](https://github.com/BelegCufea/PrettyReputation) to define your own TAGS. You can even modify already defined ones.
New tags will be listed (and available) in config of Pretty Reputation


## 1. Available info

From info parameter of the function (see [Structure of TAG](#structure-of-tag) section)

### 1.1 Extracted from Blizzard message

* faction = name of faction as provided by Blizzad reputation message
* change = absolute value of actual gain/loss
* negative = set to true if change is negative (i.e. reputation loss) otherwise nil
* session = reputation change during session (this one may be negative)

### 1.2 From iterating factions (GetFactionInfo)

* factionId = Id of faction

### 1.3 Gain using Blizzard API (GetFactionInfoByID, GetFactionParagonInfo, GetFriendshipReputation)

It is possible that Pretty Reputation will not be able to fill these variables (as I am shitty programmer). In that case, Pretty reputation will override the whole messsage with predefined text.

* name = name of faction
* standingId = Id of standing
* standingText = reputation standing ("Friendly", "Revered", "True friend" ...), it may include reward icon and  if set in options also paragon level.
* standingColor = color string in form of "|cffrrggbb" for intergating in your message, don't forget to add "|r" at the end
    * color = same as above, but the format is {r = x, g = y, b = z}, where x, y, z are number form 0 to 1
* current = current raputation value
* maximum = maximum value of current reputation (e.g. for Revered it is 21000 to reach Exalted)
* bottom = raw number of reputation points for current standing (bottom value)
* top = raw number of reputation points for current standing (top value)
* paragon = reward icon (if available) and if set in options also paragon level, empty string if no paragon level obtaied
* renown = renown level, empty string if no renown available

## 2. Other available variables

### 2.1 Form options

From `LibStub("PrettyReputationTags").Options`. These are returned as functions.

* Reputation.barChar() = character for the barlike progress
* Reputation.barLength() = length of the barlike progress
* Reputation.showParagonCount() = whether to display paragon count in standing text
* StandingColors() = table of defined colors in escaped format ready to be used in print (in format "|cffrrggbb") {[1] = hated, [2] = hostile, [3] = unfriendly, [4] = neutral, [5] = friendly, [6] = honored, [7] = revered, [8] = exalted, [9] = paragon, [10] = renown}
    * Colors() = same as above but the format is {r = x, g = y, b = z} instead of "|cffrrggbb"

### 2.2 From constants

From `LibStub("PrettyReputationTags").Const`. These are plain values.

* Colors.name = color of name TAG
* Colors.bar_full = color of filled bar chars
* Colors.bar_empty = color of empty bar chars
* Colors.bar_edge = color of brackets of barlike progress
* Colors.positive = color of positive gain, also used in Enable text and tooltip
* Colors.negative = color of negative loss, also used in Disable text and tooltip

## 3. Tag definition

### 3.1 Libraries

You will need LibStub (included in this example)

### 3.2 TOC file

```
...
## Dependencies: PrettyReputation
...
Libs\LibStub\LibStub.lua
...
```


### 3.2 LUA

#### Grap library

```lua
local tags = LibStub("PrettyReputationTags")
local definition = tags.Definition
local options = tags.Options
local const = tags.Const
```

#### Usage

In `definition` variable (above) are stored all predefined TAGS. It is possible to add your own or modify existing ones.

##### Structure of TAG

```lua
definition["<<TAG>>"] = {
    desc = "<<description>>",
    value = function(info)
        return "<<string>>"
    end
}
```

where

* `<<TAG>>` = tag name
* `<<description>>` = description string shown in configuration
* `<<string>>` = what will be displayed in chat if this TAG is used, must be string

`value` is defined as function with one parameter. Members of said parameter are described in [Available info](#1-available-info) section.

Function defined in `value` is called only if that TAG is used in message pattern (or in debug mode).
You can use that function to do whatever you want, but remember it is called every time reputation message is displayed and it MUST return a string!

#### TAG examples

##### New tag definition

###### simple example

```lua
definition["MD-newTag"] = {
    desc = "new testing tag",
    value = function(info)
        return info.name
    end
}
```

###### using options and const

```lua
definition["MD-paragonTest"] = {
    desc = "paragon testing tag",
    value = function(info)
        local reputationColors = options.StandingColors()
        if options.Reputation.showParagonCount() then
            return reputationColors[9] .. "Paragon count is shown" .. "|r"
        else
            return const.Colors.negative .. "Paragon count is hidden" .. "|r"
        end
    end
}
```

##### Redefine existing tag

Any available tag can be modified

###### only return value function

```lua
definition["name"].value = function(info) return "Faction name: " .. info.name end
```

###### including description

```lua
definition["c_name"] = {
    desc = "redefined c_name tag",
    value = function(info)
        return info.standingColor .. "Faction name is " .. info.name .. "|r"
    end
}
```

## New and modified tags are shown in options

![Options with new tags](https://i.imgur.com/9u6aa0J.png)