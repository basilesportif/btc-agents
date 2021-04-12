# RPC actions
Uses `dumb.js` in the BTC RPC utils.

## btc/electrs sanity checks
Should return `block-info` result
```
-btc-rpc
```

## parsing POC
It's ok to just parse one (or more) keys in a multi-key thing. The below parses only the "tim" key.
```
=p (ot:dejs:format ~[[%tim ni:dejs:format]])
(p (pairs:enjs:format ~[[%tim [%n '2']] [%blah [%s '3']]]))
```
