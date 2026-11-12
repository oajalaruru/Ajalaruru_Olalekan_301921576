# University Student Result Portal — SQL queries

## 1. Show related enrollment, student, course records (up to 20).

```sql
SELECT t0."enrollment_key" AS "enrollment_enrollment_key",
       t0."term_code" AS "enrollment_term_code",
       t1."student_key" AS "student_student_key",
       t1."program" AS "student_program",
       t2."course_key" AS "course_course_key",
       t2."course_code" AS "course_course_code"
FROM portfolio."enrollment" t0
JOIN portfolio."student" t1 ON t0."student_key" = t1."student_key"
JOIN portfolio."course" t2 ON t0."course_key" = t2."course_key"
ORDER BY t0."enrollment_key", t1."student_key", t2."course_key"
LIMIT 20;
```

| enrollment_enrollment_key | enrollment_term_code | student_student_key | student_program | course_course_key | course_course_code |
| --- | --- | --- | --- | --- | --- |
| 301 | 2026-FALL | 101 | Computer Science | 201 | CS101 |
| 302 | 2026-FALL | 102 | Mathematics | 202 | MATH210 |

## 2. Find result records where recorded_at matches "2026-10-15T14:30:00Z" (up to 20).

```sql
SELECT * FROM portfolio."result"
WHERE "recorded_at" IS NOT DISTINCT FROM '2026-10-15T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;
```

| result_key | enrollment_key | assessment_code | score | recorded_at |
| --- | --- | --- | --- | --- |
| 401 | 301 | MIDTERM | 87.5 | 2026-10-15T14:30:00+00:00 |

## 3. Count result records for each enrollment_key (up to 20 groups).

```sql
SELECT "enrollment_key", count(*) AS record_count
FROM portfolio."result"
GROUP BY "enrollment_key"
ORDER BY record_count DESC, "enrollment_key" NULLS LAST
LIMIT 20;
```

| enrollment_key | record_count |
| --- | --- |
| 301 | 1 |
| 302 | 1 |

## 4. Find result records where recorded_at matches "2026-10-15T14:30:00Z" (up to 20).

```sql
SELECT * FROM portfolio."result"
WHERE "recorded_at" IS NOT DISTINCT FROM '2026-10-15T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;
```

| result_key | enrollment_key | assessment_code | score | recorded_at |
| --- | --- | --- | --- | --- |
| 401 | 301 | MIDTERM | 87.5 | 2026-10-15T14:30:00+00:00 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.976 | 0.976, 0.951, 0.978 | Sort → Seq Scan | 112 |
| After index | 0.198 | 0.189, 0.204, 0.198 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 0.976 ms to 0.198 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.949..0.95 rows=20 loops=1)
  Seq Scan on result (actual time=0.015..0.916 rows=20 loops=1)
Planning Time: 0.33 ms
Execution Time: 0.976 ms
```

### Before index, run 2

```text
Sort (actual time=0.925..0.926 rows=20 loops=1)
  Seq Scan on result (actual time=0.015..0.892 rows=20 loops=1)
Planning Time: 0.372 ms
Execution Time: 0.951 ms
```

### Before index, run 3

```text
Sort (actual time=0.951..0.953 rows=20 loops=1)
  Seq Scan on result (actual time=0.015..0.918 rows=20 loops=1)
Planning Time: 0.342 ms
Execution Time: 0.978 ms
```

### After index, run 1

```text
Sort (actual time=0.13..0.132 rows=20 loops=1)
  Bitmap Heap Scan on result (actual time=0.029..0.096 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.016..0.017 rows=20 loops=1)
Planning Time: 0.548 ms
Execution Time: 0.189 ms
```

### After index, run 2

```text
Sort (actual time=0.145..0.147 rows=20 loops=1)
  Bitmap Heap Scan on result (actual time=0.031..0.111 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.017..0.017 rows=20 loops=1)
Planning Time: 0.549 ms
Execution Time: 0.204 ms
```

### After index, run 3

```text
Sort (actual time=0.138..0.14 rows=20 loops=1)
  Bitmap Heap Scan on result (actual time=0.032..0.103 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.018..0.018 rows=20 loops=1)
Planning Time: 0.562 ms
Execution Time: 0.198 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Ajalaruru_Olalekan_301921576_P2_Queries.sql, then Ajalaruru_Olalekan_301921576_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Ajalaruru_Olalekan_301921576_P2_QueryResults.png) · [Index comparison](screenshots/Ajalaruru_Olalekan_301921576_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

