  :: /sur/spec.hoon
::::
::
::   /dat/hw0/q0/student.json
::   /dat/hw0/rubric.json
::
::   /dat/asl1/q1/lagrev-nocfep.json
/+  *mip
|%
+$  stdt  @p            :: student @p
+$  homw  @tas          :: identifier of a particular homework
+$  ques  @tas           :: question number in a homework
+$  answ  (unit cord)   :: student answer
+$  scor  (unit @ud)    :: student's score on question, ~ if unsubmitted/ungraded
+$  cmnt  (unit cord)   :: instructor comment
+$  quid  [homw ques]   :: question identifier: homework, question
+$  atyp  ?(%text %text-human %hoon)  :: answer types
+$  enrl  (set stdt)    :: students enrolled in a class
+$  rubr-entry  [qu=cord max=@ud typ=atyp ans=cord]
+$  rubr  (mip homw ques rubr-entry)   :: rubric containing question text, maximum score, answer type, and correct/sample answer
+$  grbk  (mip stdt quid [scor cmnt])  :: gradebook storing student scores by question
+$  anbk  (mip stdt quid answ)  :: store of student answers

+$  query
  $%  
      [%enrollment ~]      :: query for enrollment list
      [%question =homw =ques]     :: `(list stud)` of students that completed a question
      [%homework =homw]     :: `(list stud)` of all students that completed a homework (completed every question)
      [%grades ~]          :: dump all grades to csv format, watch out for quotation mark issue
      [%report =stdt =homw =ques]  :: `scor` report student's grade on a question
      [%report-q =homw =ques]     :: `(map stud scor)` getting all student performance for a question
      [%report-s =stdt]     :: return all scores over all homework for a student
      [%report-sh =stdt =homw]  :: return all scores for a given homework and student 
  ==
+$  action
  $%  
      [%enroll =stdt]
      [%unenroll =stdt]
      ::[%load-rubric =path]    :: `refr`
      ::[%load-stdt =path]      :: load a single student's answers (check for compatibility)
      ::[%load-stdts =path]     :: load all students in a given directory
      ::[%grade =stdt =quid]  :: `?`
      ::[%grade-q =quid]   :: `(map stud ?)`  ->  ++add-student-results
      ::[%grade-s =stdt]   :: `(map quid ?)`  ->  ++add-question-results
      ::[%grade-hw =homw]
      ::[%grade-all *]    :: `quag`
  ==
+$  state-0  *
--

