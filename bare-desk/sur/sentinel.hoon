/-  beacon
|%
+$  status  ?(%ok %bad %old %old-bad %idk)
+$  result  ?(%yes %no %expire %got %abort %error)
+$  entry   [src=ship =status =request:beacon =result:beacon]
+$  action  [=time approve=?]
+$  update
  $%  [%new =time =entry]
      [%close =time =result:beacon]
      [%open logs=(list [=time =entry])]
      [%closed before=time logs=(list [=time =entry])]
  ==
+$  log      ((mop time entry) gth)
++  orm      ((on time entry) gth)
+$  by-id    (map @ux time)
+$  pending  (map time [src=ship =request:beacon])
+$  valid    (map [src=ship =turf] time)
::
++  old-0
  |%
  +$  url     cord
  +$  urls    (map url fate)
  +$  fate    ?(%clotho %lachesis %atropos)
  +$  action
    $%  [%what =url]
        [%okay =url]
        [%yeet =url]
    ==
  --
--
