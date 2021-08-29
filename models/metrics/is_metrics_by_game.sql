{{ config(
    materialized = 'table'
)}}

{% set cols = get_column_names( source("baseball", "games_wide") ) %}
{% set is_cols = get_matches(cols, 'is_.*') %}

SELECT sched.gameId
,sched.homeTeamName
,sched.awayTeamName
{%- for col in is_cols %}
    ,SUM(games.{{ col }}) AS {{ col }}
{% endfor -%}

FROM {{ source("baseball", "schedules") }} sched

JOIN {{ source("baseball", "games_wide") }} games 
USING(gameId)

GROUP BY 1,2,3
