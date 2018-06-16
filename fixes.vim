let g:fixes=[
  \['cannot use true', 'wcwnil'],
  \['invalid operation: ! error', 'cwerr := $hi; err != nil'],
  \['cannot use false', '@e@g'],
  \['non-bool ', 'wierr := $hi; err == nil$%a else {return false}'],
  \['too many arguments', '[[$ierror '],
  \['missing return', 'Oreturn nil'],
  \['multiple-value', '0wwi_, '],
  \['network.WriteTo', '@pkkwi_, '],
\]

function! Fix()
  for f in g:fixes
    if FixesTryFix(f)
      return 1
    endif
  endfor
  echoerr 'No pattern matched.'
endfunction

function! FixesTryFix(fix)
  let [pattern, recording] = a:fix
  let qflist = getqflist()
  let qfcurnr = getqflist({'idx' : 0}).idx-1
  let pmatch = matchstr(qflist[qfcurnr]['text'], pattern)
  if pmatch != ''
    execute "normal" recording
    return 1
  endif
  echo ['nomatch', pattern, qfcurnr, qflist[qfcurnr]['text']]
endfunction

"call Fix()
