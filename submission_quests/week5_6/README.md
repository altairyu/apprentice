# インターネットTV

## ステップ1
<details>
<summary>テーブル設計</summary>

### テーブル：channels

| カラム名         | データ型              | NULL | キー      | 初期値 | AUTO INCREMENT |
|--------------|-------------------|------|---------|----|----------------|
| channel_id   | SMALLINT UNSIGNED | NO   | PRIMARY |    | YES            |
| channel_name | VARCHAR(100)      | NO   | UNIQUE  |    |                |
- ユニークキー制約：channel_nameカラムに対して設定


### テーブル：program_slots

| カラム名            | データ型              | NULL | キー                            | 初期値 | AUTO INCREMENT |
|-----------------|-------------------|----|-------------------------------|-----|----------------|
| program_slot_id | BIGINT UNSIGNED   | NO | PRIMARY                       |     | YES            |
| channel_id      | SMALLINT UNSIGNED | NO | FOREIGN (channels.channel_id) |     |                |
| start_time      | DATETIME          | NO |                               |     |                |
| end_time        | DATETIME          | NO |                               |     |                |
- 外部キー制約：channel_id に対して、channelsテーブルのchannel_idカラムから設定

### テーブル：programs

| カラム名           | データ型            | NULL | キー      | 初期値 | AUTO INCREMENT |
|----------------|-----------------|----|---------|--|----------------|
| program_id     | BIGINT UNSIGNED | NO | PRIMARY |  | YES            |
| program_title  | VARCHAR(100)    | NO |         |  |                |
| program_detail | TEXT            | NO |         |  |                |


### テーブル：program_schedules
| カラム名                | データ型            | NULL | キー                                     | 初期値 | AUTO INCREMENT |
|---------------------|-----------------|------|----------------------------------------|-----|----------------|
| program_schedule_id | BIGINT UNSIGNED | NO   | PRIMARY                                |     | YES            |
| program_id          | BIGINT UNSIGNED | NO   | FOREIGN (programs.program_id)          |     |                |
| program_slot_id     | BIGINT UNSIGNED | NO   | FOREIGN (program_slot.program_slot_id) |     |                |
- 外部キー制約：program_id に対して、programsテーブルのprogram_idカラムから設定
- 外部キー制約：program_slot_id に対して、program_slotsテーブルのprogram_slot_idカラムから設定


### テーブル：genres

| カラム名       | データ型         | NULL | キー      | 初期値 | AUTO INCREMENT |
|------------|--------------|------|---------|----|----------------|
| genre_id   | INT UNSIGNED | NO   | PRIMARY |    | YES            |
| genre_name | VARCHAR(50)  | NO   | UNIQUE  |    |                |
- ユニークキー制約：genre_nameカラムに対して設定

### テーブル：program_genre
※ programsテーブルとgenresテーブルの中間テーブル（関連実体）。

| カラム名       | データ型            | NULL | キー                            | 初期値 | AUTO INCREMENT |
|------------|-----------------|------|-------------------------------|----|-------------|
| program_id | BIGINT UNSIGNED | NO   | FOREIGN (programs.program_id) |    |             |
| genre_id   | INT UNSIGNED    | NO   | FOREIGN (genres.genre_id)     |    |             |
- 外部キー制約：program_id に対して、programsテーブルのprograms_idカラムから設定
- 外部キー制約：genre_id に対して、genresテーブルのgenre_idカラムから設定

### テーブル：seasons

| カラム名          | データ型            | NULL | キー                            | 初期値  | AUTO INCREMENT |
|---------------|-----------------|------|-------------------------------|------|----------------|
| season_id     | INT UNSIGNED    | NO   | PRIMARY                       |      | YES            |
| program_id    | BIGINT UNSIGNED | NO   | FOREIGN (programs.program_id) |      |                |
| season_number | INT UNSIGNED    | YES  |                               | NULL |                |
- 外部キー制約：program_id に対して、programsテーブルのprograms_idカラムから設定

### テーブル：episodes
| カラム名           | データ型            | NULL | キー                            | 初期値 | AUTO INCREMENT |
|----------------|-----------------|------|-------------------------------|---|----------------|
| episode_id     | INT UNSIGNED    | NO   | PRIMARY                       |   | YES            |
| program_id     | INT UNSIGNED    | NO   | FOREIGN (programs.program_id) |     |                |
| season_id      | INT UNSIGNED    | YES  | FOREIGN (seasons.season_id)   |   |                |
| episode_number | INT UNSIGNED    | YES  |                               |   |                |
| episode_title  | VARCHAR(100)    | NO   |                               |   |                |
| episode_detail | TEXT            | NO   |                               |   |                |
| duration       | TIME            | NO   |                               |   |                |
| release_date   | DATE            | NO   |                               |   |                | 
- 外部キー制約：program_id に対して、programsテーブルのprogram_idカラムから設定
- 外部キー制約：season_id に対して、seasonsテーブルのseason_idカラムから設定

### テーブル：view_counts

| カラム名             | データ型            | NULL | キー                                      | 初期値 | AUTO INCREMENT |
|------------------|-----------------|------|-----------------------------------------|-----|----------------|
| view_count_id    | INT UNSIGNED    | NO   | PRIMARY                                 |     | YES            |
| episode_id       | INT UNSIGNED    | NO   | FOREIGN (episodes.episode_id)           |     |                |
| program_slot_id  | INT UNSIGNED    | NO   | FOREIGN (program_slots.program_slot_id) |     |                |
| view_count       | BIGINT UNSIGNED | NO   |                                         | 0   |                |
- 外部キー制約：episode_id に対して、episodesテーブルのseason_idカラムから設定
- 外部キー制約：program_slot_id に対して、program_slotsテーブルのprogram_slot_idカラムから設定


</details>

## ステップ2
### データベースの作成

<details>
<summary>  0. 事前準備</summary>

- MySQLを実行するディレクトリ下に以下のファイルを用意してください
  - `sample_data.sql`
  ※ サンプルデータの追加時に使います。
  ※ ローカル環境での実行を想定しています。

</details>

<details>
<summary>  1. MySQLへログイン</summary>

```
mysql -u root -p
```
</details>
<details>
<summary>  2. データベースを作成 </summary>

- 以下のSQL文を実行してください。

```sql
CREATE DATABASE;
```
</details>

<details>
<summary>  3. データベースの確認</summary>

- 以下のSQL文を実行してデータベースが作成されていることを確認します。

```sql
SHOW DATABASES;
```

</details>

### テーブルの作成

<details>
<summary> 4. データベースの選択</summary>

- 以下のSQL文を実行してください。

```sql
USE internet_tv;
```
</details>

<details>
<summary> 5. テーブルの作成</summary>

- 以下のSQL文を実行してください。

    <details>
    <summary>channelsテーブル</summary>
    
    ```sql
    CREATE TABLE channels (
        PRIMARY KEY (channel_id),
        channel_id             SMALLINT UNSIGNED  NOT NULL AUTO_INCREMENT,
        channel_name           VARCHAR(50)        NOT NULL UNIQUE
    );
    ```
    </details>

    <details>
    <summary>program_slotsテーブル</summary>
    
    ```sql
    CREATE TABLE program_slots (
        PRIMARY KEY (program_slot_id),
        program_slot_id        BIGINT UNSIGNED    NOT NULL AUTO_INCREMENT,
        channel_id             SMALLINT UNSIGNED  NOT NULL,
        start_time             DATETIME           NOT NULL,
        end_time               DATETIME           NOT NULL,
        FOREIGN KEY (channel_id)      REFERENCES channels(channel_id) ON DELETE CASCADE
    );  
    ```
    </details>
    
    <details>
    <summary>programsテーブル</summary>
    
    ```sql
    CREATE TABLE programs (
        PRIMARY KEY (program_id),
        program_id             BIGINT UNSIGNED    NOT NULL AUTO_INCREMENT,
        program_title          VARCHAR(100)       NOT NULL,
        program_detail         TEXT               NOT NULL
    );
    ```
    </details>
    
    <details>
    <summary>program_schedulesテーブル</summary>
    
    ```sql
    CREATE TABLE program_schedules (
        PRIMARY KEY (program_schedule_id),
        program_schedule_id    BIGINT UNSIGNED    NOT NULL AUTO_INCREMENT,
        program_id             BIGINT UNSIGNED    NOT NULL,
        program_slot_id        BIGINT UNSIGNED    NOT NULL,
        FOREIGN KEY (program_id)      REFERENCES programs(program_id) ON DELETE CASCADE,
        FOREIGN KEY (program_slot_id) REFERENCES program_slots(program_slot_id) ON DELETE CASCADE
    );
    ```
    </details>
    
    <details>
    <summary>genresテーブル</summary>
    
    ```sql
    CREATE TABLE genres (
        PRIMARY KEY (genre_id),
        genre_id               SMALLINT UNSIGNED  NOT NULL AUTO_INCREMENT,
        genre_name             VARCHAR(50)        NOT NULL UNIQUE
    );
    ```
    </details>
    
    <details>
    <summary>program_genreテーブル</summary>
    
    ```sql
    CREATE TABLE program_genre (
        PRIMARY KEY (program_id, genre_id),
        program_id             BIGINT UNSIGNED    NOT NULL,
        genre_id               SMALLINT UNSIGNED       NOT NULL,
        FOREIGN KEY (program_id)      REFERENCES programs(program_id) ON DELETE CASCADE,
        FOREIGN KEY (genre_id)        REFERENCES genres(genre_id) ON DELETE CASCADE
    );
    ```
    </details>
    
    <details>
    <summary>seasonsテーブル</summary>
    
    ```sql
    CREATE TABLE seasons (
        PRIMARY KEY (season_id),
        season_id              INT UNSIGNED       NOT NULL AUTO_INCREMENT,
        program_id             BIGINT UNSIGNED    NOT NULL,
        season_number          INT UNSIGNED,
        FOREIGN KEY (program_id)      REFERENCES programs(program_id) ON DELETE CASCADE
    );
    ```
    </details>
    
    <details>
    <summary>episodesテーブル</summary>
    
    ```sql
    CREATE TABLE episodes (
        PRIMARY KEY (episode_id),
        episode_id             INT UNSIGNED       NOT NULL AUTO_INCREMENT,
        program_id             BIGINT UNSIGNED       NOT NULL,
        season_id              INT UNSIGNED,
        episode_number         INT UNSIGNED,
        episode_title          VARCHAR(100)       NOT NULL,
        episode_detail         TEXT               NOT NULL,
        duration               TIME               NOT NULL,
        release_date           DATE               NOT NULL,
        FOREIGN KEY (program_id)      REFERENCES programs(program_id) ON DELETE CASCADE,
        FOREIGN KEY (season_id)       REFERENCES seasons(season_id) ON DELETE CASCADE
    );
    ```
    </details>
    
    <details>
    <summary>view_countsテーブル</summary>
    
    ```sql
    CREATE TABLE view_counts (
        PRIMARY KEY (view_count_id),
        view_count_id          INT UNSIGNED       NOT NULL AUTO_INCREMENT,
        episode_id             INT UNSIGNED       NOT NULL,
        program_slot_id        BIGINT UNSIGNED    NOT NULL,
        view_count             BIGINT UNSIGNED    NOT NULL DEFAULT 0,
        FOREIGN KEY (episode_id)      REFERENCES episodes(episode_id) ON DELETE CASCADE,
        FOREIGN KEY (program_slot_id) REFERENCES program_slots(program_slot_id) ON DELETE CASCADE
    );
    ```
    </details>

</details>

<details>
<summary> 6. テーブルの確認</summary>

- 以下のSQL文を実行してテーブルが作成されていることを確認します。

```sql
SHOW TABLES;
```

</details>


### サンプルデータの追加

<details>
<summary> 7. サンプルデータの追加</summary>

- 以下のSQL文を実行してください。

```sql
source sample_data.sql;
```

</details>

<details>
<summary> 8. サンプルデータの簡単な確認</summary>

- 以下のSQL文を実行して結果が確認できればOKです。

```sql
SELECT * FROM channels ORDER BY channel_id ASC;
```

</details>




## ステップ3

<details>
<summary><h3>1. エピソード視聴数トップ3のエピソードタイトルと視聴数の取得</h3></summary>

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

</details>

<details>
<summary><h3>2. エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数の取得</h3></summary>

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

</details>

<details>
<summary><h3>3. 本日放送の全番組からチャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得</h3></summary>

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

</details>


<details>
<summary><h3>4. ドラマのチャンネルから放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得</h3></summary>


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

</details>

<details>
<summary><h3>5. (advanced)直近一週間に放送された番組中、エピソード視聴数合計トップ2の番組から番組タイトル、視聴数を取得する</h3></summary>


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

</details>
