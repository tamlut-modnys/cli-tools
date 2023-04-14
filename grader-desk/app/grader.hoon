/-  *grader
/+  csv
/*  csv-mark  %as-mark /mar/csv/hoon
/+  verb, dbug, default-agent, *mip
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
=<
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %|) bowl)
    eng   ~(. +> [bowl ~])
++  on-init
^-  (quip card _this)
~>  %bout.[0 '%mine +on-init']
`this
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
?+    mar  (on-poke:def mar vaz)
    %grader-action
  =/  act  !<(action vaz)
  ?-    -.act
      %enroll
    ~&  "student enrolled successfully"
    `this(enrl (~(put in enrl) stdt.act))
      %unenroll
    ?.  (~(has in enrl) stdt.act)
      ~&  "Specified student not found"
      `this
    ~&  "Student and their grade/answer records have been deleted"
    `this(enrl (~(del in enrl) stdt.act), grbk (~(del in grbk) stdt.act), anbk (~(del in anbk) stdt.act))
      %load-rubric
    =/  rubric-csv  .^((list(list @t)) %cx /===/path.act/csv)
    =/  new-rubr
    |-
      ?~  csv  new-rubr
      $(new-rubr (process-rubric-entry new-rubr i.csv), csv t.csv)
    `this(rubr new-rubr)
      %load-stdt
      
    ::  [%load-rubric path]    :: `refr` -- uses a thread
    ::  [%load-stud path]      :: load a single student's answers (check for compatibility)
    ::  [%load-studs path]     :: load all students in a given directory
    ::  [%grade stud quid]  :: `?`
    ::  [%grade-q quid]   :: `(map stud ?)`  ->  ++add-student-results
    ::  [%grade-s stud]   :: `(map quid ?)`  ->  ++add-question-results
    ::  [%grade-hw homw]
    ::  [%grade-all *]
  ==
==
++  on-peek
|=  =path
~>  %bout.[0 '%mine +on-peek']
^-  (unit (unit cage))
?+    path  (on-peek:def path)
  ::  return list of enrolled students
  ::
    [%x %enrollment ~]
  ``noun+!>(enrl)
  ::  list of students that have completed question
  ::
    [%x %question @ @ ~]
  =/  =homw  (slav %tas i.t.t.path)
  =/  =ques  (slav %ud i.t.t.t.path)
  =/  students=(list stdt)
  ::  just return students list
  ::
  %+  turn
    ^-  (list [x=stdt y=quid v=answ])
    ::  skim list for non-null answer and quid match
    ::
    %+  skim
    ^-  (list [x=stdt y=quid v=answ])
      ::  convert map to list
      ::
      ~(tap bi anbk)
    |=(a=[x=stdt y=quid v=answ] &(!=(v.a ~) =(y.a [homw ques])))
  |=(a=[x=stdt y=quid v=answ] x.a)
  ``noun+!>(students)
  ::  list of students that have completed homework
  ::
    [%x %homework @ ~]
  =/  homework=homw  (slav %tas i.t.t.path)
  =/  students=(list stdt)
  %+  turn
    ::  take a map of students to loobean, and convert to a list of students with yes
    ::
    %+  skim
      ^-  (list [p=stdt q=?(%.y %.n)])
      %~  tap  by
      ^-  (map stdt ?(%.y %.n))
      %-  ~(run by anbk)
      ::  convert the inner map to a yes or no of whether the student finished all questions in a hw
      ::
      |=  a=(map quid answ)
      ^-  ?(%.y %.n)
      ::  check if all questions in homework are done
      ::
      %+  levy
        ::  filter for particular homework
        ::
        %+  skim
          ~(tap by a)
        |=(b=[p=quid q=answ] =(-.p.b homework))
      |=(b=[p=quid q=answ] !=(q.b ~))
    |=(a=[p=stdt q=?(%.y %.n)] q.a)
  |=(a=[p=stdt q=?(%.y %.n)] p.a)
  ``noun+!>(students)
  ::  return a single grade
  ::
    [%x %report @ @ @ ~]
  =/  =stdt  (slav %p i.t.t.path)
  =/  =homw  (slav %tas i.t.t.t.path)
  =/  =ques  (slav %ud i.t.t.t.t.path)
  ``noun+!>((~(get bi grbk) stdt [homw ques]))
  ::  return grades over students for a question
  ::
    [%x %report-q @ @ ~]
  =/  =homw  (slav %tas i.t.t.path)
  =/  =ques  (slav %ud i.t.t.t.path)
  =/  students=(map stdt [scor cmnt])
  %-  ~(run by grbk)
  |=(a=(map quid [scor cmnt]) (~(got by a) [homw ques]))
  ``noun+!>(students)
  ::  grades for a single student
  ::
    [%x %report-s @ ~]
  =/  =stdt  (slav %tas i.t.t.path)
  ``noun+!>((~(get by grbk) stdt))
  ::  grades for a single student and homework
  ::
    [%x %report-sh @ @ ~]
  =/  =stdt  (slav %p i.t.t.path)
  =/  =homw  (slav %ud i.t.t.t.path)
  =/  result=(list [p=quid q=[scor cmnt]])
  ?~  (~(get by grbk) stdt)
    ~
  %+  skim
    ^-  (list [p=quid q=[scor cmnt]])
    %~  tap  by
    ^-  (map quid [scor cmnt])
    (need (~(get by grbk) stdt))
  |=(a=[p=quid q=[scor cmnt]] =(-.p.a homw))
  ``noun+!>(result)
    ::  [grades ] just pass as a urbit csv?
==
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
|%
++  process-rubric-entry
|=  [=rubr entry=(list @t)]
^-  ^rubr
=/  homw=@tas  
  ?~  (slaw %tas (snag 0 entry))
    ~&  "Malformed rubric entry, column 0, homework id"  !!
  ?~  (need (slaw %tas (snag 0 entry)))
    ~&  "Empty column 0, homework id" !!
  (need (slaw %tas (snag 0 entry)))
=/  ques=@ud  
  ?~  (slaw %ud (snag 1 entry))
    ~&  "Malformed rubric entry, column 1, question id"  !!
  ?~  (need (slaw %tas (snag 1 entry)))
    ~&  "Empty column 1, question id"  !!
  (need (slaw %tas (snag 1 entry)))
=/  qu=cord 
  ?~  (snag 2 entry)
    ~&  "Empty column 2, question text"  !!
  (snag 2 entry)
=/  max=@ud  
  ?~  (slaw %ud (snag 3 entry))
    ~&  "Malformed rubric entry, column 3, max score"  !!
  ?~  (need (slaw %tas (snag 3 entry)))
    "Empty column 3, max score"
  (need (slaw %tas (snag 3 entry)))
=/  typ=atyp 
  ?~  (slaw %tas (snag 4 entry))
    ~&  "Malformed rubric entry, column 3, answer type"  !!
  =/  entry=%tas  (need (slaw %tas (snag 4 entry)))
  ?. |(=(entry %text) =(entry %text-human) =(entry %hoon))
    ~&  "Malformed rubric entry, column 3, answer type"  !!
  entry
=/  ans=cord  (snag 5 entry)
(~(put by rubr) [homw ques] [qu max typ])

--
