-- Fictional sample records for University Student Result Portal.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."student" ("student_key", "program", "cohort_year", "active") VALUES (101, 'Computer Science', 2024, TRUE);
INSERT INTO portfolio."student" ("student_key", "program", "cohort_year", "active") VALUES (102, 'Mathematics', 2023, TRUE);
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits") VALUES (201, 'CS101', 'Foundations of Computing', 3);
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits") VALUES (202, 'MATH210', 'Discrete Mathematics', 4);
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status") VALUES (301, 101, 201, '2026-FALL', '2026-09-01', 'enrolled');
INSERT INTO portfolio."enrollment" ("enrollment_key", "student_key", "course_key", "term_code", "enrolled_on", "status") VALUES (302, 102, 202, '2026-FALL', '2026-09-02', 'completed');
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at") VALUES (401, 301, 'MIDTERM', 87.5, '2026-10-15T14:30:00Z');
INSERT INTO portfolio."result" ("result_key", "enrollment_key", "assessment_code", "score", "recorded_at") VALUES (402, 302, 'FINAL', 92, '2026-11-03T09:15:00+00:00');
COMMIT;
