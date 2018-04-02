UPDATE policies SET DifferenceMonth = r.MAX_MONTH FROM
(select p.PolicyNum,
       DATEDIFF("m",q.minEffective,q.maxpExpiration) as MAX_MONTH
       FROM POData2.dbo.policies as p 
       inner join (
select p.[Policy],p.[PolicyNum],MIN(p.Effective) over (PARTITION BY p.[PolicyNum]) as minEffective,
MAX(p.Expiration) over (PARTITION BY p.[PolicyNum]) as maxpExpiration
from 
policies as p ) as q
on p.[PolicyNum] = q.[PolicyNum] ) r
