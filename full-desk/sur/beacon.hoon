|%
+$  proof  [=turf =ship =life =sign]
+$  sign  @uw
+$  manifest  (list proof)
+$  stamp  @udunixnano
+$  request
  $:  id=@ux
      =ship
      =turf
      user=(unit @t)
      code=(unit @ud)
      msg=(unit @t)
      expire=@da
  ==
+$  result  ?(%yes %no %expire %got %sent %abort %error)
+$  entry   [=request =result]
+$  logs    (list [=stamp =request =result])
+$  action
  $%  [%new =stamp =request]
      [%cancel =stamp]
  ==
+$  update
  $%  [%entry =stamp =request =result]
      [%result =stamp =result]
      [%init-all since=(unit stamp) before=(unit stamp) =logs]
      [%init-turf =turf since=(unit stamp) before=(unit stamp) =logs]
      [%init-ship =ship since=(unit stamp) before=(unit stamp) =logs]
  ==
+$  log  ((mop stamp entry) lth)
+$  by-ship  (jug ship stamp)
++  orm  ((on stamp entry) lth)
::
++  old-0
  |%
  +$  url     cord
  +$  urls    (map url fate)
  +$  ships   (map ship fate)
  +$  fate    ?(%clotho %lachesis %atropos)
  +$  appeal
    $%  [%auto =url]
        [%send =ship]
        [%auth =ship]
        [%burn =ship]
    ==
  +$  update
    $%  [%url =url]
        [%pending =ship]
        [%approve =ship]
        [%reject =ship]
        [%init =url bids=ships]
    ==
  --
--
