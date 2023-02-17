/-  *grader
/+  verb, dbug, default-agent, mip
::
|%
::
+$  versioned-state  $%(state-0)
::
  +$  state-0
    $:  %0
        =enrl
        =rubr
        =grbk
        =anbk
    ==
::
::
::  boilerplate
::
+$  card  card:agent:gall
--
::
%+  verb  &
%-  agent:dbug
=|  state-0
=*  state  -
::
^-  agent:gall
::
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %|) bowl)
    eng   ~(. +> [bowl ~])
++  on-init
^-  (quip card _this)
~>  %bout.[0 '%mine +on-init']
=^  cards  state
    abet:init:eng
[cards this]
::
++  on-save
^-  vase
~>  %bout.[0 '%mine +on-save']
!>(state)
::
++  on-load
|=  ole=vase
~>  %bout.[0 '%mine +on-load']
^-  (quip card _this)
  =/  old  !<(versioned-state ole)
  ?-  -.old
    %0  `this(state old)
  ==
::
++  on-poke
|=  [mar=mark vaz=vase]
~>  %bout.[0 '%mine +on-poke']
^-  (quip card _this)
?+    mar  (on-poke:default mar vaz)
    %grader-action
  =/  act  !<(action vase)
  ?-    -.act
      %enroll
    ~&  "Student enrolled successfully"
    `this(enrl ~(put in enrl stud.act))
      %unenroll
    ?.  ~(has in enrl stud.act)
      ~&  "Specified student not found"
      `this
    ~&  "Student and their grade/answer records have been deleted"
    `this(enrl ~(del in enrl stud.act), grbk ~(del in grbk stud.act), anbk ~(del in anbk stud.act))
    ::  [%load-rubric path]    :: `refr`
    ::  [%load-stud path]      :: load a single student's answers (check for compatibility)
    ::  [%load-studs path]     :: load all students in a given directory
    ::  [%grade stud quid]  :: `?`
    ::  [%grade-q quid]   :: `(map stud ?)`  ->  ++add-student-results
    ::  [%grade-s stud]   :: `(map quid ?)`  ->  ++add-question-results
    ::  [%grade-hw homw]
    ::  [%grade-all *]
++  on-peek
|=  =path
~>  %bout.[0 '%mine +on-peek']
^-  (unit (unit cage))
?+    path  (on-peek:default path)
    [%x %enrollment ~]
  ``grader-query+!>(`query`[%enrollment enrl])
    [%x %question @ @ ~]
  =/  =homw  (slav %tas i.t.t.path)
  =/  =ques  (slav %ud i.t.t.t.path)
  =/  students=(list stud)
  %+  turn
    %+  skim
      ~(tap bi:mip anbk)
    |=(a=[=stud =quid =answ] &(!=(answ ~) =(quid [homw ques])))
  |=(a=[=stud =quid =answ] stud)
  ``grader-query+!>(`query`[%question students])
    [%x %homework @ ~]
  =/  homework=homw  (slav %tas i.t.t.path)
  =/  students=(list stud)
  ::  take a map of students to loobean, and convert to a list of students with yes
  ::
  %+  skim
    %~  tap  by
    %-  ~(run by anbk)
    ::  convert the inner map to a yes or no of whether the student finished all questions in a hw
    ::
    |=  a=*(map quid answ)
    ^-  ?(%.y %.n)
    ::  check if all questions in homework are done
    ::
    %+  levy
      ::  filter for particular homework
      ::
      %+  skim
        ~(tap by a)
      |=(b=[p=quid q=answ] =(homw.p homework))
    |=(b=[p=quid q=answ] !=(q ~))
  |=(a=[p=stud q=?(%.y %.n)] q.a)
  ``grader-query+!>(`query`[%question students])
    [%x %report @ @ @ ~]
  =/  =stud  (slav %tas i.t.t.path)
  =/  =homw  (slav %ud i.t.t.t.path)
  =/  =ques (slav %ud i.t.t.t.t.path)
  ``grader-query+!>(`query`[%report (~(get bi:mip grbk) stud [homw ques])])
    [%x %report-q @ @ ~]
  =/  =homw  (slav %tas i.t.t.path)
  =/  =ques (slav %ud i.t.t.t.path)
  =/  students=(map stud scor)
  %-  ~(run by grbk)
  |=(a=*(map quid answer) (~(got by a) [homw ques]))
  ``grader-query+!>(`query`[%report-q students])
    [%x %report-s @ ~]
  =/  =stud  (slav %tas i.t.t.path)
  ``grader-query+!>(`query`[%report-s (~(get by grbk) stud)])
    [%x %report-sh @ @ ~]
  =/  =stud  (slav @ud i.t.t.path)
  =/  =homw (slav @ud i.t.t.t.path)
  =/  result=*(map quid scor)
  %+  skim
    %~  tap  by
    (~(get by grbk) stud)
  |=(a=[p=quid q=scor] =(homw.p homw))
  ``grader-query+!>(`query`[%report-sh results])
    ::  [grades ]
++  on-agent
|=  [wir=wire sig=sign:agent:gall]
~>  %bout.[0 '%mine +on-agent']
^-  (quip card _this)
`this
::
++  on-arvo
|=  [wir=wire sig=sign-arvo]
~>  %bout.[0 '%mine +on-arvo']
^-  (quip card _this)
`this
::
++  on-watch
|=  =path
~>  %bout.[0 '%mine +on-watch']
^-  (quip card _this)
`this
::
++  on-fail
~>  %bout.[0 '%mine +on-fail']
on-fail:def
::
++  on-leave
~>  %bout.[0 '%mine +on-leave']
on-leave:def
--
