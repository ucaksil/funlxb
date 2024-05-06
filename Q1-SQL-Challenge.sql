drop table if exists login_details;
create table login_details
(
	times	time,
	status	varchar(3)
);
insert into login_details values('10:00:00', 'on');
insert into login_details values('10:01:00', 'on');
insert into login_details values('10:02:00', 'on');
insert into login_details values('10:03:00', 'off');
insert into login_details values('10:04:00', 'on');
insert into login_details values('10:05:00', 'on');
insert into login_details values('10:06:00', 'off');
insert into login_details values('10:07:00', 'off');
insert into login_details values('10:08:00', 'off');
insert into login_details values('10:09:00', 'on');
insert into login_details values('10:10:00', 'on');
insert into login_details values('10:11:00', 'on');
insert into login_details values('10:12:00', 'on');
insert into login_details values('10:13:00', 'off');
insert into login_details values('10:14:00', 'off');
insert into login_details values('10:15:00', 'on');
insert into login_details values('10:16:00', 'off');
insert into login_details values('10:17:00', 'off');

select min(log_on) LOG_ON,log_off as LOG_OFF ,max(duration) DURATION from (SELECT 
    l1.times AS LOG_ON,
    l2.times AS LOG_OFF,
    TIMESTAMPDIFF(MINUTE, l1.times, l2.times) AS DURATION
FROM
    login_details l1
JOIN
    login_details l2 ON l1.times < l2.times AND l2.status = 'off'
WHERE
    l1.status = 'on' AND
    l2.times = (
        SELECT l3.times
        FROM login_details l3
        WHERE l3.status = 'off' AND l3.times > l1.times
        ORDER BY l3.times ASC
        LIMIT 1
    )
ORDER BY
    l1.times)z group by log_off