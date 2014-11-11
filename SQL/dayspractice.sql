sqlite> select  strftime('%Y-%m-%d',first_play_time), count(distinct player_id) from data group by strftime('%Y-%m-%d',first_play_time);

