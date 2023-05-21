# ステップ2
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
