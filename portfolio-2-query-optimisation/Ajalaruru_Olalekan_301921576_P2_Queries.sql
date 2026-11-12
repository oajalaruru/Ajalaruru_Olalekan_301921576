-- Show related enrollment, student, course records (up to 20).
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

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
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

-- Find result records where recorded_at matches "2026-10-15T14:30:00Z" (up to 20).
SELECT * FROM portfolio."result"
WHERE "recorded_at" IS NOT DISTINCT FROM '2026-10-15T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."result"
WHERE "recorded_at" IS NOT DISTINCT FROM '2026-10-15T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;

-- Count result records for each enrollment_key (up to 20 groups).
SELECT "enrollment_key", count(*) AS record_count
FROM portfolio."result"
GROUP BY "enrollment_key"
ORDER BY record_count DESC, "enrollment_key" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "enrollment_key", count(*) AS record_count
FROM portfolio."result"
GROUP BY "enrollment_key"
ORDER BY record_count DESC, "enrollment_key" NULLS LAST
LIMIT 20;

-- Find result records where recorded_at matches "2026-10-15T14:30:00Z" (up to 20).
SELECT * FROM portfolio."result"
WHERE "recorded_at" IS NOT DISTINCT FROM '2026-10-15T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."result"
WHERE "recorded_at" IS NOT DISTINCT FROM '2026-10-15T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;
