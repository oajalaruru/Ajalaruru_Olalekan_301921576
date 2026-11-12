-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. student pk duplicate. Expected: pk_student, SQLSTATE 23505.
INSERT INTO portfolio."student" ("student_key", "program", "cohort_year", "active")
VALUES (101, 'Physics', 2025, TRUE);

-- 2. student key not null. Expected: student_key, SQLSTATE 23502.
INSERT INTO portfolio."student" ("student_key", "program", "cohort_year", "active")
VALUES (NULL, 'Physics', 2025, TRUE);

-- 3. student program not null. Expected: program, SQLSTATE 23502.
INSERT INTO portfolio."student" ("student_key", "program", "cohort_year", "active")
VALUES (1001, NULL, 2025, TRUE);

-- 4. student cohort not null. Expected: cohort_year, SQLSTATE 23502.
INSERT INTO portfolio."student" ("student_key", "program", "cohort_year", "active")
VALUES (1002, 'Physics', NULL, TRUE);

-- 5. student active not null. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."student" ("student_key", "program", "cohort_year", "active")
VALUES (1003, 'Physics', 2025, NULL);

-- 6. course pk duplicate. Expected: pk_course, SQLSTATE 23505.
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits")
VALUES (201, 'CS999', 'Distinct Course', 3);

-- 7. course code unique. Expected: uq_course_0, SQLSTATE 23505.
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits")
VALUES (1101, 'CS101', 'Distinct Course', 3);

-- 8. course key not null. Expected: course_key, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits")
VALUES (NULL, 'CS991', 'Distinct Course', 3);

-- 9. course code not null. Expected: course_code, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits")
VALUES (1102, NULL, 'Distinct Course', 3);

-- 10. course title not null. Expected: title, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits")
VALUES (1103, 'CS992', NULL, 3);

-- 11. course credits not null. Expected: credits, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits")
VALUES (1104, 'CS993', 'Distinct Course', NULL);

-- 12. enrollment pk duplicate. Expected: pk_enrollment, SQLSTATE 23505.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (301, 102, 201, '2027-SPRING', '2027-01-10', 'enrolled');

-- 13. enrollment unique. Expected: uq_enrollment_0, SQLSTATE 23505.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1201, 101, 201, '2026-FALL', '2026-09-03', 'enrolled');

-- 14. enrollment student fk. Expected: fk_enrollment_0, SQLSTATE 23503.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1202, 9991, 201, '2027-SPRING', '2027-01-10', 'enrolled');

-- 15. enrollment course fk. Expected: fk_enrollment_1, SQLSTATE 23503.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1203, 101, 9992, '2027-SPRING', '2027-01-10', 'enrolled');

-- 16. enrollment key not null. Expected: enrollment_key, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (NULL, 101, 201, '2027-SPRING', '2027-01-10', 'enrolled');

-- 17. enrollment student not null. Expected: student_key, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1204, NULL, 201, '2027-SPRING', '2027-01-10', 'enrolled');

-- 18. enrollment course not null. Expected: course_key, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1205, 101, NULL, '2027-SPRING', '2027-01-10', 'enrolled');

-- 19. enrollment term not null. Expected: term_code, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1206, 101, 201, NULL, '2027-01-10', 'enrolled');

-- 20. enrollment date not null. Expected: enrolled_on, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1207, 101, 201, '2027-SPRING', NULL, 'enrolled');

-- 21. enrollment status not null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1208, 101, 201, '2027-SPRING', '2027-01-10', NULL);

-- 22. result pk duplicate. Expected: pk_result, SQLSTATE 23505.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (401, 302, 'OTHER', 75, '2026-11-04T10:00:00Z');

-- 23. result unique. Expected: uq_result_0, SQLSTATE 23505.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (1301, 301, 'MIDTERM', 75, '2026-11-04T10:00:00Z');

-- 24. result enrollment fk. Expected: fk_result_0, SQLSTATE 23503.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (1302, 9993, 'OTHER', 75, '2026-11-04T10:00:00Z');

-- 25. result key not null. Expected: result_key, SQLSTATE 23502.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (NULL, 301, 'OTHER', 75, '2026-11-04T10:00:00Z');

-- 26. result enrollment not null. Expected: enrollment_key, SQLSTATE 23502.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (1303, NULL, 'OTHER', 75, '2026-11-04T10:00:00Z');

-- 27. result assessment not null. Expected: assessment_code, SQLSTATE 23502.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (1304, 301, NULL, 75, '2026-11-04T10:00:00Z');

-- 28. result score not null. Expected: score, SQLSTATE 23502.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (1305, 301, 'OTHER', NULL, '2026-11-04T10:00:00Z');

-- 29. result recorded not null. Expected: recorded_at, SQLSTATE 23502.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (1306, 301, 'OTHER', 75, NULL);

-- 30. invalid enrollment status. Expected: valid_enrollment_status, SQLSTATE 23514.
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status")
VALUES (1307, 101, 201, '2027-SUMMER', '2027-05-01', 'pending');

-- 31. invalid result score. Expected: valid_result_score, SQLSTATE 23514.
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at")
VALUES (1308, 301, 'QUIZ', 101, '2026-11-04T10:00:00Z');
