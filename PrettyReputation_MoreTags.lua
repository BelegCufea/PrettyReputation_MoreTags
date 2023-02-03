local tags = LibStub("PrettyReputationTags")

local definition = tags.Definition

-- define new tag
definition["MD-test"] = {
    tag = "testing tag",
    value = function(info)
        return info.standingColor .. "Faction name is " .. info.faction .. "|r"
    end
}

--redefine existing tag
definition["name"] = {
    tag = "redefined name tag",
    value = function(info)
        return "Faction name is " .. info.name
    end
}