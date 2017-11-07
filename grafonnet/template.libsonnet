{
    new(
        name,
        datasource,
        query,
        label=null,
        allValues=null,
        tagValuesQuery="",
        current=null,
        hide="",
        refresh="never",
        includeAll=false,
        multi=false,
    )::
        {
            allValue: allValues,
            current: $.current(current),
            datasource: datasource,
            hide: if hide == "" then 0 else if hide == "label" then 1 else 2,
            includeAll: includeAll,
            label: label,
            multi: multi,
            name: name,
            options: [],
            query: query,
            refresh: if refresh == "never"
            then
                0
            else if refresh == "load"
            then
                1
            else if refresh == "time"
            then
                2
            else
                refresh
            ,
            regex: "",
            sort: 0,
            tagValuesQuery: tagValuesQuery,
            tags: [],
            tagsQuery: "",
            type: "query",
            useTags: false,
        },
    interval(
        name,
        query,
        current,
        hide="",
        label=null,
        auto_count=300,
        auto_min="10s",
    )::
        {
            current: $.current(current),
            hide: if hide == "" then 0 else if hide == "label" then 1 else 2,
            label: label,
            name: name,
            query: query,
            refresh: 2,
            type: "interval",
            auto: std.count(std.split(query, ","), "auto") > 0,
            auto_count: auto_count,
            auto_min: auto_min,
        },
    current(current):: {
        [if current != null then "text"]: current,
        [if current != null then "value"]: if current == "auto" then
            "$__auto_interval"
        else if current == "all" then
            "$__all"
        else
            current,
    },
}