::  Grader agent
::  reams a cord to see if it matches a reference answer
::
/-  *grader
/+  *csv, *mip
/%  csv  %csv
:-  %say  
|=  [[now=@da * bec=beak] [homw=path rubr=path ~] ~]
:-  %noun
|^
=/  pax=path  /(scot %p p.bec)/[q.bec]/(scot %da now)
=/  hw  .^((list (list @t)) %cx (weld pax homw))
=/  rb  .^((list (list @t)) %cx (weld pax rubr))
(snag 2 (snag 0 rb))
++  parse-rubric-hw
  |=  rb=(list (list @t))
  ^-  (map ques rubr-entry)
  ::  make inner map of mip
  ::
  %-  malt  
  ^-  (list (pair ques rubr-entry))
  (turn rb process-rubric-entry)
++  process-rubric-entry
|=  entry=(list @t)
^-  (pair ques rubr-entry)
=/  ques=@tas 
  ?~  (slaw %tas (snag 0 entry))
    ~&  "Malformed rubric entry, column 0, question id"  !!
  ?~  (need (slaw %tas (snag 0 entry)))
    ~&  "Empty column 0, question id"  !!
  (need (slaw %tas (snag 0 entry)))
=/  qu=cord 
  ?~  (snag 1 entry)
    ~&  "Empty column 1, question text"  !!
  (snag 1 entry)
=/  typ=atyp 
  ?~  (slaw %tas (snag 2 entry))
    ~&  "Malformed rubric entry, column 2, answer type"  !!
  =/  entry=@tas  (need (slaw %tas (snag 2 entry)))
  ?.  |(=(entry %text) =(entry %text-human) =(entry %hoon))
    ~&  "Malformed rubric entry, column 3, answer type"  !!
   ;;(atyp entry)
=/  max=@ud  
  ?~  (slaw %ud (snag 3 entry))
    ~&  "Malformed rubric entry, column 3, max score"  !!
  ?~  (need (slaw %ud (snag 3 entry)))
    ~&  "Empty column 3, max score"  !!
  (need (slaw %ud (snag 3 entry)))
=/  ans=cord  (snag 5 entry)
[ques [qu max typ ans]]
--
