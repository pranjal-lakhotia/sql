--problem
/*Assume there are three Spotify tables containing information about the artists, songs, and music charts. Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times. From now on, we'll refer to this ranking number as "song appearances".

Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, but the rank of who has the most appearances). The order of the rank should take precedence.

For example, Ed Sheeran's songs appeared 5 times in Top 10 list of the global song rank table; this is the highest number of appearances, so he is ranked 1st. Bad Bunny's songs appeared in the list 4, so he comes in at a close 2nd.

Assumptions:

If two artists' songs have the same number of appearances, the artists should have the same rank.
The rank number should be continuous (1, 2, 2, 3, 4, 5) and not skipped (1, 2, 2, 4, 5).
Reference :- https://datalemur.com/questions/top-fans-rank    */

--solution
with cte as (SELECT a.*,s.song_id,g.rank FROM artists a join songs s on a.artist_id = s.artist_id
join global_song_rank g on g.song_id = s.song_id where g.rank <= 10),
appearance_count as (select artist_name,count(*) as times_appearance from cte
group by artist_name),
artists_ranked as (select *,dense_rank() over(order by times_appearance desc) as rn
from appearance_count)
select artist_name,rn as artist_rank from artists_ranked
where rn <= 5;
