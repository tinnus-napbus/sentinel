/-  beacon
|%
+$  status  ?(%ok %bad %old %old-bad %idk)
+$  result  ?(%yes %no %expire %got %abort %error)
+$  received  time
+$  entry   [=received =status =request:beacon =result]
+$  ref     [src=ship =id:beacon]
+$  item    [=ref entry]
+$  logs    (list item)
+$  action  [=ref approve=?]
+$  update
  $%  [%new item]
      [%close =ref =result]
      [%open =logs]
      [%closed before=time =logs]
  ==
+$  log-val  (each ref (set ref))
+$  log      ((mop received log-val) gth)
++  orm      ((on received log-val) gth)
+$  entries  (map ref entry)
+$  pending  (map ref [=received =request:beacon])
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
