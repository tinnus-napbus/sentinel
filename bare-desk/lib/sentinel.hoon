/-  *sentinel, beacon
|%
++  dejs
  |%
  ++  manifest-soft
    =,  dejs-soft:format
    |=  jon=json
    |^  ^-  (unit manifest:beacon)
    %.  jon
    %-  ar
    %-  ot
    :~  turf+(ci de-turf:html so)
        ship+(su fed:ag)
        life+ni
        sign+(ci maybe-sign so)
    ==
    ::
    ++  maybe-sign
      |=  str=@t
      ^-  (unit sign:beacon)
      =/  uocts=(unit octs)  (de:base64:mimes:html str)
      ?~  uocts  ~
      (some q.u.uocts)
    --
  ::
  ++  action
    =,  dejs:format
    |=  jon=json
    ^-  ^action
    %.  jon
    (ot time+di approve+bo ~)
  --
++  enjs
  =,  enjs:format
  |%
  ++  update
    |=  upd=^update
    ^-  json
    ?-    upd
        [%new *]
      %+  frond  'new'
      %-  pairs
      :~  ['time' (time time.upd)]
          ['entry' (entry entry.upd)]
      ==
    ::
        [%close *]
      %+  frond  'close'
      %-  pairs
      :~  ['time' (time time.upd)]
          ['result' s+result.upd]
      ==
    ::
        [%open *]
      (frond 'open' (logs logs.upd))
    ::
        [%closed *]
      %+  frond  'closed'
      %-  pairs
      :~  ['before' (time before.upd)]
          ['logs' (logs logs.upd)]
      ==
    ==
  ::
  ++  logs
    |=  ls=(list [@da ^entry])
    ^-  json
    :-  %a
    %+  turn  ls
    |=  [d=@da ent=^entry]
    a+[(time d) (entry ent) ~]
  ::
  ++  entry
    |=  ent=^entry
    ^-  json
    %-  pairs
    :~  ['src' (ship src.ent)]
        ['status' s+status.ent]
        ['request' (request request.ent)]
        ['result' s+result.ent]
    ==
  ::
  ++  request
    |=  =request:beacon
    ^-  json
    %-  pairs
    :~  ['id' s+(crip ((x-co:co 32) id.request))]
        ['ship' (ship ship.request)]
        ['turf' s+(en-turf:html turf.request)]
        ['user' ?~(user.request ~ s+u.user.request)]
        ['code' ?~(code.request ~ (numb u.code.request))]
        ['msg' ?~(msg.request ~ s+u.msg.request)]
        ['expire' (time expire.request)]
    ==
  --
::
++  prove
  |=  [live=life puss=(unit pass) =proof:beacon]
  ^-  status
  ?~  puss  %idk
  =/  res=?
    %-  veri:ed:crypto
    [sign.proof (jam turf.proof) (cut 3 1^32 u.puss)]
  ?:  =(live life.proof)
    ?:(res %ok %bad)
  ?:  (gth life.proof live)
    %idk
  ?:(res %old %old-bad)
::
++  process-manifest
  |=  [=turf =ship lyfe=(unit life) keys=(map life pass) =manifest:beacon]
  ^-  status
  ?~  lyfe
    %idk
  %+  roll
    %+  turn
      %+  skim  manifest
      |=  =proof:beacon
      &(=(ship ship.proof) =(turf turf.proof))
    |=  =proof:beacon
    (prove u.lyfe (~(get by keys) life.proof) proof)
  choose-status
::
++  choose-status
  |=  [new=status old=status]
  ^-  status
  ?-  old
    %ok       old
    %bad      ?:(?=(%ok new) new old)
    %old      ?:(?=(?(%ok %bad) new) new old)
    %old-bad  ?:(?=(?(%ok %bad %old) new) new old)
    %idk      new
  ==
--
