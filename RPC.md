# RPC actions
Uses `dumb.js` in the BTC RPC utils.

## btc/electrs sanity checks
Should return `block-info` result
```
-btc-rpc
```


  +$  httr  [p=@ud q=mess r=(unit octs)]                ::  raw http response
  +$  math  (map @t (list @t))                          ::  semiparsed headers
  +$  mess  (list [p=@t q=@t])                          


  +$  response-header
    $:  ::  status: http status code
        ::
        status-code=@ud
        ::  headers: http headers
        ::
        headers=header-list
        
+$  header-list
(list [key=@t value=@t])


  +$  mime-data
    [type=@t data=octs]


