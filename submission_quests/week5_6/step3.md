# ステップ3

## 1. エピソード視聴数トップ3のエピソードタイトルと視聴数の取得

```sql
SELECT 
    episodes.episode_title, 
    SUM(view_counts.view_count) AS total_view_count
FROM 
    view_counts
INNER JOIN 
    episodes ON view_counts.episode_id = episodes.episode_id
GROUP BY 
    view_counts.episode_id
ORDER BY 
    total_view_count DESC
LIMIT 3;

```

## 2. エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数の取得

```sql
SELECT 
    programs.program_title,
    seasons.season_number,
    episodes.episode_number,
    episodes.episode_title, 
    SUM(view_counts.view_count) AS total_view_count
FROM 
    view_counts
INNER JOIN 
    episodes ON view_counts.episode_id = episodes.episode_id
INNER JOIN 
    seasons ON episodes.season_id = seasons.season_id
INNER JOIN 
    programs ON episodes.program_id = programs.program_id
GROUP BY 
    view_counts.episode_id
ORDER BY 
    total_view_count DESC
LIMIT 3;

```

## 3. 本日放送の全番組からチャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得
※ 番組の開始時刻が本日のものを本日放送される番組とみなす。

```sql
SELECT 
    channels.channel_name, 
    program_slots.start_time,
    program_slots.end_time, 
    seasons.season_number, 
    episodes.episode_number, 
    episodes.episode_title,
    episodes.episode_detail
FROM 
    program_slots
INNER JOIN 
    channels ON program_slots.channel_id = channels.channel_id
INNER JOIN 
    program_schedules ON program_slots.program_slot_id = program_schedules.program_slot_id
INNER JOIN 
    episodes ON program_schedules.program_id = episodes.program_id
INNER JOIN
    seasons ON episodes.season_id = seasons.season_id
WHERE 
    DATE(program_slots.start_time) = CURDATE()
ORDER BY 
    program_slots.start_time;

```

## 4. ドラマのチャンネルから放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得

```sql
SELECT
    ps.start_time,
    ps.end_time,
    s.season_number,
    e.episode_number,
    e.episode_title,
    e.episode_detail
FROM
    program_slots ps
JOIN
    channels c ON c.channel_id = ps.channel_id
JOIN
    program_schedules psc ON psc.program_slot_id = ps.program_slot_id
JOIN
    programs p ON p.program_id = psc.program_id
JOIN
    seasons s ON s.program_id = p.program_id
JOIN
    episodes e ON e.season_id = s.season_id
WHERE
    c.channel_name = '映画とドラマ'
    AND ps.start_time >= CURDATE()
    AND ps.start_time < DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY
    ps.start_time;

```

## 5. (advanced)直近一週間に放送された番組中、エピソード視聴数合計トップ2の番組から番組タイトル、視聴数を取得する

```sql
SELECT
    p.program_title,
    SUM(vc.view_count) AS total_view_count
FROM
    view_counts vc
JOIN
    program_slots ps ON ps.program_slot_id = vc.program_slot_id
JOIN
    program_schedules psc ON psc.program_slot_id = ps.program_slot_id
JOIN
    programs p ON p.program_id = psc.program_id
WHERE
    ps.start_time >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
    AND ps.start_time < CURDATE()
GROUP BY
    p.program_id
ORDER BY
    total_view_count DESC
LIMIT 2;

```
