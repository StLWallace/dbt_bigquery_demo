SELECT sched.gameId
,sched.homeTeamName
,sched.awayTeamName
,SUM(games.is_ab) AS is_ab
,SUM(games.is_ab_over) AS is_ab_over
,SUM(games.is_hit) AS is_hit
,SUM(games.is_on_base) AS is_on_base
,SUM(games.is_bunt) AS is_bunt
,SUM(games.is_bunt_shown) AS is_bunt_shown
,SUM(games.is_triple_play) AS is_triple_play
,SUM(games.is_wild_pitch) AS is_wild_pitch
,SUM(games.is_passed_ball) as is_passed_ball

FROM {{ source("baseball", "schedules") }} sched

JOIN {{ source("baseball", "games_wide") }} games 
USING(gameId)

GROUP BY 1,2,3
