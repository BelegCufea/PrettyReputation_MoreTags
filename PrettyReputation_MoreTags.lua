local tags = LibStub("PrettyReputationTags")

local definition = tags.Definition
local options = tags.Options
local const = tags.Const

-- define new tag
definition["MD-newTag"] = {
    desc = "new testing tag",
    value = function(info)
        return info.name
    end
}

-- using options and const
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

--modify existing tag
definition["name"].value = function(info) return "Faction name: " .. info.name end

--modify existing tag including description
definition["c_name"] = {
    desc = "redefined c_name tag",
    value = function(info)
        return info.standingColor .. "Faction name is " .. info.name .. "|r"
    end
}