# Pretty Reputation tags

You can use available data from [Pretty Reputation](https://github.com/BelegCufea/PrettyReputation) to define your own tags. You can even redefine already defined ones.
New tags will be listed (and available) in config of Pretty Reputation

## Available info

From info parameter of the function

### Extracted from Blizzard message
* faction = name of faction as provided by Blizzad reputation message
* change = absolute value of actual gain/loss
* negative = set to true if chnage is negative (i.e. reputation loss)
* session = reputation change during session (this one may be negative)

### From iterating factions (GetFactionInfo)
* factionId = Id of faction

### Gain using Blizzard API (GetFactionInfoByID, GetFactionParagonInfo, GetFriendshipReputation)

It is possible that Pretty Reputation will not be able to fill these variables (as I am shitty programmer). In that case, Pretty reputation will override the whole messsage with predefined text.

* name = name of faction
* standingId = Id of standing
* standingText = reputation standing ("Friendly", "Revered", "True friend" ...), it may include paragon level with possible reward icon if set in options.
* standingColor = color string in form of "|cffrrggbb" for intergating in your message, don't forget to add "|r" at the end
    * color = same as above, but the format is {r = x, g = y, b = z}, where x, y, z are number form 0 to 1
* current = current raputation value
* maximum = maximum value of current reputation (e.g. for Revered it is 21000 to reach Exalted)
* bottom = raw number of reputation points for current standing (bottom value)
* top = raw number of reputation points for current standing (top value)
* paragon = paragon level with possible reward (with no regard to settings), empty string if no paragon level obtaied
* renown = renown level, empty string if no renown available

## Other available

### Some of the variables form options

From `LibStub("PrettyReputationTags").Options`. These are returned as functions.

* Reputation.barChar() = character for the barlike progress
* Reputation.barLength() = length of the barlike progress
* Reputation.showParagonCount() = whether to display paragon count in standing text
* StandingColors() = table of defined colors in escaped format ready to be used print (in format "|cffrrggbb") {[1] = hated, [2] = hostile, [3] = unfriendly, [4] = neutral, [5] = friendly, [6] = honored, [7] = revered, [8] = exalted, [9] = paragon, [10] = renown}
    * Colors() = same as above but the format is {r = x, g = y, b = z} insteda of "|cffrrggbb"

### Some constants

From `LibStub("PrettyReputationTags").Const`.These are plain values.

* Colors.name = color of name tag
* Colors.bar_full = color of filled bar chars
* Colors.bar_empty = color of empty bar chars
* Colors.bar_edge = color of brackets of barlike progress
* Colors.positive = color of positive gain, also used in Enable text and tooltip,
* Colors.negative = color of negative loss, also used in Disable text and tooltip,

## Tag definition

### Libraries

You will need LibStub

### TOC
...
\## Dependencies: PrettyReputation
...

Libs\LibStub\LibStub.lua
...

### LUA
1. Grap library
```lua
local tags = LibStub("PrettyReputationTags")
local definition = tags.Definition
```

2. Define new tag
All the info is in `info` variable that has to be passed in function of `value`

* simple example
```lua
definition["MD-newTag"] = {
    desc = "new testing tag",
    value = function(info)
        return info.name
    end
}
```

* using options and const
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

3. Redefine existing tag
Any available tag can be modified

* only return value
```lua
definition["name"].value = function(info) return "Faction name: " .. info.name end
```

* including description
```lua
definition["c_name"] = {
    desc = "redefined c_name tag",
    value = function(info)
        return info.standingColor .. "Faction name is " .. info.name .. "|r"
    end
}
```
