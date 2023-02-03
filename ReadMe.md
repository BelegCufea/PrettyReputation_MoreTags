# Pretty Reputation tags

You can use available data from [Pretty Reputation](https://github.com/BelegCufea/PrettyReputation) to define your own tags. You can even redefine already defined ones.
New tags will be listed (and available) in config of Pretty Reputation

## Available info

### Extracted from Blizzard message
* faction = name of faction as provided by Blizzad reputation message
* change = absolute value of actual gain/loss
* negative = set to true if chnage is negative (i.e. reputation loss)
* session = reputation change during session (this one may be negative)

### Gain using Blizzard API (GetFactionInfoByID, GetFactionParagonInfo, GetFriendshipReputation)

It is possible that Pretty Reputation will not be able to fill these variables (as I am shitty programmer). In that case, Pretty reputation will override the whole messsage with predefined text.

* name = name of faction
* standingText = reputation standing ("Friendly", "Revered", "True friend" ...), it may include paragon level with possible reward icon if set in options.
* standingColor = color string in form of "|cffrrggbb" for intergating in your message, don't forget to add "|r" at the end
    * color = same as above, but the format is {r = x, g = y, b = z}, where x, y, z are number form 0 to 1
* current = current raputation value
* maximum = maximum value of current reputation (e.g. for Revered it is 21000 to reach Exalted)
* bottom = raw number of reputation points for current standing (bottom value)
* top = raw number of reputation points for current standing (top value)
* paragon = paragon level with possible reward (with no regard to settings), empty string if no paragon level obtaied
* renown = renown level, empty string if no renown available


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
```lua
definition["MD-test"] = {
    tag = "testing tag",
    value = function(info)
        return info.standingColor .. "Faction name is " .. info.faction .. "|r"
    end
}
```

3. Redefine existing tag
Any available tag can be modified
```lua
definition["name"] = {
    tag = "redefined name tag",
    value = function(info)
        return "Faction name is " .. info.name
    end
}
```
