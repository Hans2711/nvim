; extends

; Fold multiline directive argument blocks such as:
; @props([
;   ...
; ])
(document
  (directive) @fold
  .
  (parameter) @fold)
