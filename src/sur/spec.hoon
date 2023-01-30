  :: /sur/spec.hoon
::::
::
::   /dat/hw0/q0/student.json
::   /dat/hw0/rubric.json
::
::   /dat/asl1/q1/lagrev-nocfep.json
|%
+$  stud  @p            :: student @p
+$  quid  [@tas @ud]    :: question identifier `[%asl0 0]` for `q0`
+$  quix  (map quid cord)  :: question text
+$  quax  (mip stud quid cord)  :: student answer
+$  acat  ?(%text %text-human %hoon)  :: answer types
+$  refr  (map quid (pair acat @ud))  :: reference answer from rubric
+$  quag  (mip stud quid ?)
+$  action
  $%  [%poll stud]      :: `(list quid)` of completed Qs
      [%load stud]      :: `quax`
      [%load-all *]     :: `(list quax)`
      [%load-rubric]    :: `refr`
      [%grade stud quid]  :: `?`
      [%grade-q quid]   :: `(map stud ?)`  ->  ++add-student-results
      [%grade-s stud]   :: `(map quid ?)`  ->  ++add-question-results
      [%grade-all *]    :: `quag`
      [%report stud quid]
      [%report-q quid]
      [%report-s stud]
      [%report-all *]
  ==
+$  state-0  *
--

