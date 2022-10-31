/-  *beacon
|%
++  dejs
  |%
  ++  action
    =,  dejs:format
    |=  jon=json
    |^  ^-  ^action
    %.  jon
    %-  of
    :~  new+(ot stamp+ni request+request ~)
        cancel+(ot stamp+ni ~)
    ==
    ::
    ++  request
      %+  cu
        (lead 0x0)
      %-  ot
      :~  ship+(su fed:ag)
          turf+turf
          user+(mu so)
          code+(mu ni)
          msg+(mu so)
          expire+di
      ==
    ::
    ++  turf
      |=  jon=json
      ^-  ^turf
      ?>  ?=([%s *] jon)
      =/  tur=^turf  (need (de-turf:html p.jon))
      ?>  ?=(^ tur)
      tur
    --
  --
++  enjs
  =,  enjs:format
  |%
  ++  manifest
    |=  manifest=^manifest
    ^-  json
    :-  %a
    (turn manifest proof)
  ::
  ++  proof
    |=  proof=^proof
    ^-  json
    %-  pairs
    :~  ['turf' s+(en-turf:html turf.proof)]
        ['ship' (ship ship.proof)]
        ['life' (numb life.proof)]
        ['sign' s+(en:base64:mimes:html 64 sign.proof)]
    ==
  ::
  ++  update
    |=  upd=^update
    ^-  json
    ?-    upd
        [%entry *]
      %+  frond  'entry'
      %-  pairs
      :~  ['stamp' (numb stamp.upd)]
          ['request' (request request.upd)]
          ['result' s+result.upd]
      ==
    ::
        [%result *]
      %+  frond  'result'
      %-  pairs
      :~  ['stamp' (numb stamp.upd)]
          ['result' s+result.upd]
      ==
    ::
        [%init-all *]
      %+  frond  'initAll'
      %-  pairs
      :~  ['since' ?~(since.upd ~ (numb u.since.upd))]
          ['before' ?~(before.upd ~ (numb u.before.upd))]
          ['logs' a+(turn logs.upd log-item)]
      ==
    ::
        [%init-turf *]
      %+  frond  'initTurf'
      %-  pairs
      :~  ['turf' s+(en-turf:html turf.upd)]
          ['since' ?~(since.upd ~ (numb u.since.upd))]
          ['before' ?~(before.upd ~ (numb u.before.upd))]
          ['logs' a+(turn logs.upd log-item)]
      ==
    ::
        [%init-ship *]
      %+  frond  'initShip'
      %-  pairs
      :~  ['ship' (ship ship.upd)]
          ['since' ?~(since.upd ~ (numb u.since.upd))]
          ['before' ?~(before.upd ~ (numb u.before.upd))]
          ['logs' a+(turn logs.upd log-item)]
      ==
    ==
  ::
  ++  log-item
    |=  [=stamp req=^request =result]
    ^-  json
    %-  pairs
    :~  ['stamp' (numb stamp)]
        ['request' (request req)]
        ['result' s+result]
    ==
  ::
  ++  request
    |=  request=^request
    ^-  json
    %-  pairs
    :~  ['ship' (ship ship.request)]
        ['turf' s+(en-turf:html turf.request)]
        ['user' ?~(user.request ~ s+u.user.request)]
        ['code' ?~(code.request ~ (numb u.code.request))]
        ['msg' ?~(msg.request ~ s+u.msg.request)]
        ['expire' (time expire.request)]
    ==
  --
::
++  make-proof
  |=  [our=ship now=time =turf]
  ^-  proof
  =+  .^(=life %j /(scot %p our)/life/(scot %da now)/(scot %p our))
  =+  .^(=ring %j /(scot %p our)/vein/(scot %da now)/(scot %ud life))
  [turf our life (sign:ed:crypto (jam turf) (cut 3 1^32 ring))]
--
