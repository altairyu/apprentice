# ステップ1
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
