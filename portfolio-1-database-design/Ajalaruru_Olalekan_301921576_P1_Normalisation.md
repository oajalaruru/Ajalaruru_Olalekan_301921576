# University Student Result Portal — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| student_key | enrollment records (list) |
| --- | --- |
| 101 | [301] |
| 102 | [302] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| enrollment.enrollment_key | enrollment.student_key | enrollment.course_key | enrollment.term_code | student.student_key | student.program | course.course_key | course.course_code |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 2026-FALL | 101 | Computer Science | 201 | CS101 |
| 302 | 102 | 202 | 2026-FALL | 102 | Mathematics | 202 | MATH210 |

Key: enrollment_key.

## 2NF: depend on the whole key

enrollment: student_key is a proper part of candidate key (student_key, course_key, term_code), and determines student details. enrollment: course_key is a proper part of candidate key (student_key, course_key, term_code), and determines course details.

## student_example

| student.student_key | student.program |
| --- | --- |
| 101 | Computer Science |
| 102 | Mathematics |

## course_example

| course.course_key | course.course_code |
| --- | --- |
| 201 | CS101 |
| 202 | MATH210 |

## enrollment_example

| enrollment.enrollment_key | enrollment.student_key | enrollment.course_key | enrollment.term_code |
| --- | --- | --- | --- |
| 301 | 101 | 201 | 2026-FALL |
| 302 | 102 | 202 | 2026-FALL |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## student

| student_key | program | cohort_year | active |
| --- | --- | --- | --- |
| 101 | Computer Science | 2024 | true |
| 102 | Mathematics | 2023 | true |

## course

| course_key | course_code | title | credits |
| --- | --- | --- | --- |
| 201 | CS101 | Foundations of Computing | 3 |
| 202 | MATH210 | Discrete Mathematics | 4 |

## enrollment

| enrollment_key | student_key | course_key | term_code | enrolled_on | status |
| --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 2026-FALL | 2026-09-01 | enrolled |
| 302 | 102 | 202 | 2026-FALL | 2026-09-02 | completed |

## result

| result_key | enrollment_key | assessment_code | score | recorded_at |
| --- | --- | --- | --- | --- |
| 401 | 301 | MIDTERM | 87.5 | 2026-10-15T14:30:00+00:00 |
| 402 | 302 | FINAL | 92 | 2026-11-03T09:15:00+00:00 |

## Dependencies

- student: (student_key) → program, cohort_year, active
- course: (course_key) → course_code, title, credits
- enrollment: (enrollment_key) → student_key, course_key, term_code, enrolled_on, status
- result: (result_key) → enrollment_key, assessment_code, score, recorded_at

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
