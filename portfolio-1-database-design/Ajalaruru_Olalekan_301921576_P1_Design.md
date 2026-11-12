# University Student Result Portal — database design

My case study records student, course, enrollment, result.

## Users

- Students reviewing their own enrollments and results
- Authorized staff maintaining course, enrollment, and result records

## Main operations

- Create a course enrollment for a student and term
- Record or correct an assessment result
- Filter and review results by term or recording date
- Summarize assessment scores by course and term

## Entities

| Entity | Information stored |
| --- | --- |
| student | Stores a minimal synthetic student record without a name or institutional student ID. |
| course | Stores course catalog details used by enrollment and result queries. |
| enrollment | Associates one student with one course in a term and stores enrollment-specific details. |
| result | Stores one assessment score and recording timestamp for an enrollment. |

## student

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| student_key | BIGINT | PK | Yes |
| program | TEXT |  | Yes |
| cohort_year | INTEGER |  | Yes |
| active | BOOLEAN |  | Yes |


## course

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| course_key | BIGINT | PK | Yes |
| course_code | TEXT | Unique | Yes |
| title | TEXT |  | Yes |
| credits | INTEGER |  | Yes |
- Unique key: (course_code).

## enrollment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| enrollment_key | BIGINT | PK | Yes |
| student_key | BIGINT | FK | Yes |
| course_key | BIGINT | FK | Yes |
| term_code | TEXT |  | Yes |
| enrolled_on | DATE |  | Yes |
| status | TEXT |  | Yes |
- student_key → student.student_key
- course_key → course.course_key
- Unique key: (student_key, course_key, term_code).

## result

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| result_key | BIGINT | PK | Yes |
| enrollment_key | BIGINT | FK | Yes |
| assessment_code | TEXT |  | Yes |
| score | NUMERIC(18,2) |  | Yes |
| recorded_at | TIMESTAMPTZ |  | Yes |
- enrollment_key → enrollment.enrollment_key
- Unique key: (enrollment_key, assessment_code).

## Relationships and business rules

- Each course code identifies at most one course.
- A student may have at most one enrollment in the same course and term.
- Every enrollment must reference an existing student.
- Every enrollment must reference an existing course.
- Enrollment status must be one of enrolled, completed, or withdrawn.
- Every recorded assessment score must be between 0 and 100 inclusive.
- An enrollment has at most one current result for each assessment code.
- Every result must reference an existing enrollment.

## Assumptions

- Student names and institutional student IDs are omitted. student_key is an opaque synthetic surrogate key.
- Primary-key values are synthetic opaque identifiers and are globally unique across all entities.
- Scores use a 0-to-100 scale; assessment_code identifies an assessment within one enrollment.
- A course can be enrolled in again in a different term, but only once per student, course, and term.

