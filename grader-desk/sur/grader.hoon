  :: /sur/spec.hoon
::::
::
::   /dat/hw0/q0/student.json
::   /dat/hw0/rubric.json
::
::   /dat/asl1/q1/lagrev-nocfep.json
/+  mip
|%
+$  stud  @p            :: student @p
+$  homw  @tas          :: identifier of a particular homework
+$  ques  @ud           :: question number in a homework
+$  answ  (unit cord)
+$  scor  (unit @ud)    :: student's score on question, ~ if unsubmitted/ungraded
+$  quid  [homw ques]    :: question identifier: homework, question
+$  atyp  ?(%text %text-human %hoon)  :: answer types
+$  enrl  (set stud)  :: students enrolled in a class
+$  rubr  (map quid [qu=cord max=@ud typ=atyp ans=cord])   :: rubric containing question text, maximum score, answer type, and correct/sample answer
+$  grbk  (mip stud quid scor)  :: gradebook storing student scores by question
+$  anbk  (mip stud quid answ)  :: store of student answers

+$  query
  $%  
      [%enrollment ~]      :: query for enrollment list
      [%question quid]     :: `(list stud)` of students that completed a question
      [%homework homw]     :: `(list stud)` of all students that completed a homework (completed every question)
      [%grades ~]          :: dump all grades to csv format, watch out for quotation mark issue
      [%report stud quid]  :: `scor` report student's grade on a question
      [%report-q quid]     :: `(map stud scor)` getting all student performance for a question
      [%report-s stud]     :: return all scores over all homework for a student
      [%report-sh stud homw]  :: return all scores for a given homework and student 
+$  action
  $%  
      [%enroll stud]
      [%unenroll stud]
      [%load-rubric path]    :: `refr`
      [%load-stud path]      :: load a single student's answers (check for compatibility)
      [%load-studs path]     :: load all students in a given directory
      [%grade stud quid]  :: `?`
      [%grade-q quid]   :: `(map stud ?)`  ->  ++add-student-results
      [%grade-s stud]   :: `(map quid ?)`  ->  ++add-question-results
      [%grade-hw homw]
      [%grade-all *]    :: `quag`
  ==
+$  state-0  *
--

