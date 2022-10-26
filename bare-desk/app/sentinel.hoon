/-  *sentinel, beacon
/+  blib=beacon, default-agent, dbug
|%
+$  versioned-state
  $%  state-1
      state-0
  ==
+$  state-0  [%zero *]
+$  state-1  [%1 =log open=log =by-id =pending =valid]
+$  card  card:agent:gall
--
::
%-  agent:dbug
=|  state-1
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init  on-init:def
++  on-save  !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  =+  !<(v=versioned-state old)
  ?-    v
      [%1 *]
    `this(state v)
  ::
      [%zero *]
    =/  cards=(list card)
      %+  weld
        %+  turn  ~(tap by sup.bowl)
        |=  [* =ship =path]
        ^-  card
        [%give %kick ~[path] `ship]
      %+  turn  ~(tap by wex.bowl)
      |=  [[=wire =ship =term] *]
      ^-  card
      [%pass wire %agent [ship term] %leave ~]
    =.  cards
      :_  cards
      [%pass /eyre %arvo %e %disconnect `/'sentinel']
    [cards this]
  ==
::
++  on-poke
  |=  [=mark =vase]
  |^  ^-  (quip card _this)
  =^  cards  state
    ?+  mark  (on-poke:def mark vase)
      %beacon-ask   (handle-beacon !<(request:beacon vase))
      %sentinel-do  (handle-action !<(action vase))
    ==
  [cards this]
  ::
  ++  handle-beacon
    |=  =request:beacon
    ^-  (quip card _state)
    ?>  ?&  ?=(^ turf.request)
            =(our.bowl ship.request)
            !(~(has by by-id) id.request)
        ==
    =/  =time
      =/  t=@da
        (from-unix-ms:chrono:userlib (unm:chrono:userlib now.bowl))
      |-
      ?.  ?|  (has:orm log t)
              (has:orm open t)
              (~(has by pending) t)
          ==
        t
      $(t (from-unix-ms:chrono:userlib +((unm:chrono:userlib t))))
    =/  good=(unit ^time)  (~(get by valid) [src.bowl turf.request])
    ?:  &(?=(^ good) (gte ~d30 (sub now.bowl u.good)))
      =/  =path  /results/(scot %p src.bowl)/(scot %ux id.request)
      =/  =result:beacon
        ?:((lte expire.request now.bowl) %expire %got)
      =/  local=(list ^path)
        ?:  ?=(%expire result)
          ~[/all]
        ~[/all /open]
      =/  =update  [%new time src.bowl %ok request result]
      :_  %=  state
            by-id    (~(put by by-id) id.request time)
            open     ?:  ?=(%expire result)
                       open
                     (put:orm open time src.bowl %ok request result)
            log      ?:  ?=(%got result)
                       log
                     (put:orm log time src.bowl %ok request result)
          ==
      :*  [%give %fact local %sentinel-did !>(update)]
          [%give %fact ~[path] %beacon-tell !>(result)]
          ?:  ?=(%expire result)
            ~
          =/  =wire  /timer/(scot %da time)
          [%pass wire %arvo %b %wait expire.request]~
      ==
    =/  =wire  /check/(scot %da time)
    =/  =cage  [%noun !>([~ src.bowl turf.request])]
    :_  state(pending (~(put by pending) time src.bowl request))
    [%pass wire %arvo %k %fard %sentinel %validate-url cage]~
  ::
  ++  handle-action
    |=  act=action
    ^-  (quip card _state)
    ?>  =(our.bowl src.bowl)
    =/  =entry  (got:orm open time.act)
    ?>  ?=(%got result.entry)
    =/  =result  ?:(approve.act %yes %no)
    =/  =path    /results/(scot %p src.entry)/(scot %ux id.request.entry)
    =/  =wire    /timer/(scot %da time.act)
    =/  =update  [%close time.act result]
    :_  %=  state
          log   (put:orm log time.act entry(result result))
          open  (tail (del:orm open time.act))
        ==
    :~  [%give %fact ~[/open /all] %sentinel-did !>(update)]
        [%give %fact ~[path] %beacon-tell !>(result)]
        [%pass wire %arvo %b %rest expire.request.entry]
    ==
  --
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path)
      [%all ~]
    ?>  =(our.bowl src.bowl)
    `this
  ::
      [%open ~]
    ?>  =(our.bowl src.bowl)
    =/  =update  [%open (tap:orm open)]
    :_  this
    [%give %fact ~ %sentinel-did !>(update)]~
  ::
      [%results @ @ ~]
    =/  src=ship    (slav %p i.t.path)
    =/  id=@ux  (slav %ux i.t.t.path)
    ?>  =(src src.bowl)
    =/  tyme=(unit time)  (~(get by by-id) id)
    ?~  tyme  `this
    =/  ent=(unit entry)
      (hunt |=(* &) (get:orm log u.tyme) (get:orm open u.tyme))
    ?~  ent  `this
    ?>  =(src.u.ent src.bowl)
    :_  this
    [%give %fact ~ %beacon-tell !>(result.u.ent)]~
  ==
::
++  on-arvo
  |=  [=wire sign=sign-arvo]
  ^-  (quip card _this)
  ?+    wire  (on-arvo:def wire sign)
      [%timer @ ~]
    ?.  ?=([%behn %wake *] sign)  (on-arvo:def wire sign)
    =/  =time  (slav %da i.t.wire)
    =/  ent=(unit entry)  (get:orm open time)
    ?~  ent  `this
    ?:  ?&  ?=(^ error.sign)
            (gth expire.request.u.ent now.bowl)
        ==
      :_  this
      [%pass wire %arvo %b %wait expire.request.u.ent]~
    =/  =path  /results/(scot %p src.u.ent)/(scot %ux id.request.u.ent)
    =/  =update  [%close time %expire]
    :_  %=  this
          log   (put:orm log time u.ent(result %expire))
          open  (tail (del:orm open time))
        ==
    :~  [%give %fact ~[/open /all] %sentinel-did !>(update)]
        [%give %fact ~[path] %beacon-tell !>(%expire)]
    ==
  ::
      [%check @ ~]
    ?.  ?=([%khan %arow *] sign)  (on-arvo:def wire sign)
    =/  =time  (slav %da i.t.wire)
    ?:  ?=(%| -.p.sign)
      =/  res=(unit [src=ship =request:beacon])
        (~(get by pending) time)
      ?~  res  `this
      ?:  ?=(%cancelled mote.p.p.sign)
        =/  =cage  [%noun !>([~ src.u.res turf.request.u.res])]
        :_  this
        [%pass wire %arvo %k %fard %sentinel %validate-url cage]~
      =/  =result:beacon
        ?:((lte expire.request.u.res now.bowl) %expire %got)
      =/  =update  [%new time src.u.res %idk request.u.res result]
      =/  =path  /results/(scot %p src.u.res)/(scot %ux id.request.u.res)
      =/  local=(list ^path)
        ?:  ?=(%expire result)
          ~[/all]
        ~[/open /all]
      :_  %=  this
            pending  (~(del by pending) time)
            by-id    (~(put by by-id) id.request.u.res time)
            log      ?:  ?=(%got result)
                       log
                     %^  put:orm  log  time
                     [src.u.res %idk request.u.res result]
            open     ?:  ?=(%expire result)
                       open
                     %^  put:orm  open  time
                     [src.u.res %idk request.u.res result]
          ==
      :*  [%give %fact local %sentinel-did !>(update)]
          [%give %fact ~[path] %beacon-tell !>(result)]
          ?:  ?=(%expire result)
            ~
          [%pass /timer/(scot %da time) %arvo %b %wait expire.request.u.res]~
      ==
    =+  !<(=status q.p.p.sign)
    =/  res=(unit [src=ship =request:beacon])
      (~(get by pending) time)
    ?~  res  `this
    =/  =result:beacon
      ?:((lte expire.request.u.res now.bowl) %expire %got)
    =/  =update  [%new time src.u.res status request.u.res result]
    =/  =path  /results/(scot %p src.u.res)/(scot %ux id.request.u.res)
    =/  local=(list ^path)
      ?:  ?=(%expire result)
        ~[/all]
      ~[/open /all]
    :_  %=    this
            pending
          (~(del by pending) time)
        ::
            by-id
          (~(put by by-id) id.request.u.res time)
        ::
            valid
          ?.  ?=(%ok status)
            valid
          (~(put by valid) [src.u.res turf.request.u.res] now.bowl)
        ::
            log
          ?:  ?=(%got result)
            log
          %^  put:orm  log  time
          [src.u.res status request.u.res result]
        ::
            open
          ?:  ?=(%expire result)
            open
          %^  put:orm  open  time
          [src.u.res status request.u.res result]
        ==
    :*  [%give %fact local %sentinel-did !>(update)]
        [%give %fact ~[path] %beacon-tell !>(result)]
        ?:  ?=(%expire result)
          ~
        [%pass /timer/(scot %da time) %arvo %b %wait expire.request.u.res]~
    ==
  ==
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %check ~]
    ``json+!>(~)
  ::
      [%x %open ~]
    :^  ~  ~  %sentinel-did
    !>  ^-  update
    [%open (tap:orm open)]
  ::
      [%x %closed @ @ ~]
    =/  =time
      (from-unix-ms:chrono:userlib (rash i.t.t.path dem))
    =/  count=@ud  (rash i.t.t.t.path dem)
    :^  ~  ~  %sentinel-did
    !>  ^-  update
    [%closed time (tab:orm log `time count)]
  ==
::
++  on-agent  on-agent:def
++  on-leave  on-leave:def
++  on-fail  on-fail:def
--
