# Pretty Reputation tags

You can define your own custom tags using the available data from [Pretty Reputation](https://github.com/BelegCufea/PrettyReputation). You can even modify existing tags. The newly created tags will be listed and available in the config of Pretty Reputation.

## 1. Available info

From info parameter in the function (as described in the [Structure of a TAG](#structure-of-a-tag) section) contains the following information:

### 1.1 Extracted from Blizzard message (GetCurrentCombatTextEventInfo)

* faction =  Name of the faction, as provided by the Blizzard reputation message
* change = Absolute value of the actual gain/loss
* negative = Set to true if the change is negative (i.e., a reputation loss), otherwise nil
* session = Reputation change during the session (this value may be negative)

### 1.2 From iterating factions (GetFactionInfo)

* factionId = ID of the faction

### 1.3 Gain using Blizzard API (GetFactionInfoByID, GetFactionParagonInfo, GetFriendshipReputation)

It is possible that Pretty Reputation will not be able to fill these variables (as I am a bad programmer). In that case, Pretty Reputation will override the entire message with a predefined text.

* name = Name of the faction
* standingId = ID of the standing
* standingText = Reputation standing (e.g., "Friendly," "Revered," "True friend," etc.), it may include a reward icon and the paragon level if set in the options.
* standingColor =  Color string in the format of "|cffrrggbb" for integrating in your message. Don't forget to add "|r" at the end.
    * color = Same as above, but the format is {r = x, g = y, b = z}, where x, y, and z are numbers from 0 to 1.
* current = Current reputation value
* maximum = Maximum value of the current reputation (e.g., for Revered it is 21000 to reach Exalted)
* bottom =  Raw number of reputation points for the current standing (bottom value)
* top =  Raw number of reputation points for the current standing (top value)
* paragon = Reward icon (if available) and if set in the options, the paragon level. Empty string if no paragon level is obtained.
* renown = Renown level, empty string if no renown is available.

## 2. Other available variables

### 2.1 Form options

From `LibStub("PrettyReputationTags").Options`. These are returned as functions.

* `Reputation.barChar()` = character for the bar-like progress
* `Reputation.barLength()` = length of the bar-like progress
* `Reputation.showParagonCount()` = whether to display paragon count in standing text
* `Reputation.shortCharCount()` = number of characters in 'Short' TAGs
* `StandingColors()` = table of defined colors in escaped format ready to be used in print (in format "|cffrrggbb") {[1] = hated, [2] = hostile, [3] = unfriendly, [4] = neutral, [5] = friendly, [6] = honored, [7] = revered, [8] = exalted, [9] = paragon, [10] = renown}
    * `Colors()` = same as above but the format is {r = x, g = y, b = z} instead of "|cffrrggbb"

### 2.2 From constants

From `LibStub("PrettyReputationTags").Const`. These are plain values.

* `Colors.name` = color of name TAG
* `Colors.bar_full` = color of filled bar chars
* `Colors.bar_empty` = color of empty bar chars
* `Colors.bar_edge` = color of brackets of bar-like progress
* `Colors.positive` = color of positive gain, also used in Enable text and tooltip
* `Colors.negative` = color of negative loss, also used in Disable text and tooltip

## 3. Tag definition

### 3.1 Libraries

You will need `LibStub` (included in this example)

### 3.2 TOC file

```
...
## Dependencies: PrettyReputation
...
Libs\LibStub\LibStub.lua
...
```


### 3.3 LUA

#### Grap library

```lua
local tags = LibStub("PrettyReputationTags")
local definition = tags.Definition
local options = tags.Options
local const = tags.Const
```

#### Usage

In the `definition` variable, all predefined TAGS are stored. It is possible to add new ones or modify existing ones.

##### Structure a of TAG

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
* `<<description>>` = description string shown in the configuration
* `<<string>>` = what will be displayed in chat if this TAG is used, must be a string

The `value` is defined as a function with one parameter. The members of this parameter are described in the [Available info](#1-available-info) section.

The function defined in `value` is called only if that TAG is used in a message pattern (or in debug mode). You can use this function to do whatever you want, but remember, it is called every time a reputation message is displayed, and it MUST return a string!

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

## New and Modified Tags Are Shown in Options

![Options with new tags](https://i.imgur.com/9u6aa0J.png)