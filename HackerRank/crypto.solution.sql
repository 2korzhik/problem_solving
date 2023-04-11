select sender
     , min(dt)     as sequence_start
     , max(dt)     as sequence_end
     , count(*)    as transaction_count
     , sum(amount) as transaction_sum
  from ( select *
              , if(dt_prev_diff between 1 and 60 or dt_next_diff between 1 and 60, 1, 0) as is_target_session
           from ( select sender
                       , amount
                       , dt
                       , timestampdiff(minute, ifnull(lag(dt) over (partition by sender order by dt), dt), dt)  as dt_prev_diff
                       , timestampdiff(minute, dt, ifnull(lead(dt) over (partition by sender order by dt), dt)) as dt_next_diff
                    from crypto
                   order by dt
                ) as t
         having is_target_session = 1
          order by dt
       ) as tt
 group by sender
having transaction_sum >= 150
