/+  bc=bitcoin
^?
|%
++  req
  |=  [rpc-url=tape type=?(%btc %electrs) rpc-call=json]
  ^-  request:http
  =/  url=@ta
    %-  crip
    %+  weld  rpc-url
    ?:  ?=(%btc type)
      "/btc-rpc"
    "/electrs-rpc"
  :*  method=%'POST'
    url
    header-list=['Content-Type'^'application/json' ~]
    ^=  body
    %-  some
    %-  as-octt:mimes:html
    (en-json:html rpc-call)
  ==
::
++  call
  =,  enjs:format
  |=  [id=@t method=@t params=(list json)]
  ^-  json
  %-  pairs
  :~  jsonrpc+s+'2.0'
      id+s+id
      method+s+method
      params+a+params
  ==
::  convert address to Electrs ScriptHash that it uses to index
::   big-endian sha256 of the output script
::
++  electrs-scripthash
  |=  a=address:bc
  ^-  hexb:bc
  %-  flip:byt:bc
  %-  sha256:bc
  (to-script-pubkey:adr:bc a)
::
++  calls
  |%
  ::  BTC
  ::
  ++  block-count
    (call 'block-count' 'getblockcount' ~)
  ::
  ++  block-hash
    |=  block=@ud
    (call 'block-hash' 'getblockhash' ~[[%n (scot %ud block)]])
  ::
  ++  block-filter
    |=  blockhash=@t
    (call 'block-filter' 'getblockfilter' ~[[%s blockhash]])
  ::
  ++  fee
    (call 'fee' 'estimatesmartfee' ~[[%n '1']])
  ::  Electrs
  ::
  ++  list-unspent
    |=  a=address:bc
    %^  call  'list-unspent'  'blockchain.scripthash.listunspent'
    ~[[%s (scot %ux dat:(electrs-scripthash a))]]
  --
--
