" ============================================================================
" Author: Bruno Sutic
" Repository: https://github.com/vim-utils/vim-troll-stopper
" ============================================================================

if exists('g:loaded_troll_stopper') && g:loaded_troll_stopper
    finish
endif
let g:loaded_troll_stopper = 1

let s:save_cpo = &cpo
set cpo&vim

if hlexists('TrollStopper') == 0
  highlight default link TrollStopper Error
  highlight Conceal NONE
  highlight default link Conceal Error
endif

if !exists("g:troll_stopper_conceal")
  let g:troll_stopper_conceal = 0
endif

let s:visible_chars_map = {
      \ "\u00A0": ' ',
      \ "\u2000": ' ',
      \ "\u2001": ' ',
      \ "\u2002": ' ',
      \ "\u2003": ' ',
      \ "\u2004": ' ',
      \ "\u2005": ' ',
      \ "\u2006": ' ',
      \ "\u2007": ' ',
      \ "\u2008": ' ',
      \ "\u2009": ' ',
      \ "\u200A": ' ',
      \ "\u2028": ' ',
      \ "\u2029": ' ',
      \ "\u202F": ' ',
      \ "\u205F": ' ',
      \ "\u3000": ' ',
      \ "\uFF01": '!',
      \ "\u01C3": '!',
      \ "\u2D51": '!',
      \ "\uFE15": '!',
      \ "\uFE57": '!',
      \ "\uFF02": '"',
      \ "\uFF03": '#',
      \ "\uFE5F": '#',
      \ "\uFF04": '$',
      \ "\uFE69": '$',
      \ "\uFF05": '%',
      \ "\u066A": '%',
      \ "\u2052": '%',
      \ "\uFE6A": '%',
      \ "\uFF06": '&',
      \ "\uFE60": '&',
      \ "\uFF07": "'",
      \ "\u02B9": "'",
      \ "\u0374": "'",
      \ "\uFF08": '(',
      \ "\uFE59": '(',
      \ "\uFF09": ')',
      \ "\uFE5A": ')',
      \ "\uFF0A": '*',
      \ "\u22C6": '*',
      \ "\uFE61": '*',
      \ "\uFF0B": '+',
      \ "\u16ED": '+',
      \ "\uFE62": '+',
      \ "\uFF0C": ',',
      \ "\u02CF": ',',
      \ "\u16E7": ',',
      \ "\u201A": ',',
      \ "\uFF0D": '-',
      \ "\u02D7": '-',
      \ "\u2212": '-',
      \ "\u23BC": '-',
      \ "\u2574": '-',
      \ "\uFE63": '-',
      \ "\uFF0E": '.',
      \ "\u2024": '.',
      \ "\uFF0F": '/',
      \ "\u1735": '/',
      \ "\u2044": '/',
      \ "\u2215": '/',
      \ "\u29F8": '/',
      \ "\u14BF": '2',
      \ "\u01B7": '3',
      \ "\u0417": '3',
      \ "\u2128": '3',
      \ "\u13CE": '4',
      \ "\u13EE": '6',
      \ "\u13ED": '9',
      \ "\uFF1A": ':',
      \ "\u02D0": ':',
      \ "\u02F8": ':',
      \ "\u0589": ':',
      \ "\u1361": ':',
      \ "\u16EC": ':',
      \ "\u205A": ':',
      \ "\u2236": ':',
      \ "\u2806": ':',
      \ "\uFE13": ':',
      \ "\uFE55": ':',
      \ "\uFF1B": ';',
      \ "\u037E": ';',
      \ "\uFE14": ';',
      \ "\uFE54": ';',
      \ "\uFF1C": '<',
      \ "\u02C2": '<',
      \ "\u2039": '<',
      \ "\u227A": '<',
      \ "\u276E": '<',
      \ "\u2D66": '<',
      \ "\uFE64": '<',
      \ "\uFF1D": '=',
      \ "\u2550": '=',
      \ "\u268C": '=',
      \ "\uFE66": '=',
      \ "\uFF1E": '>',
      \ "\u02C3": '>',
      \ "\u203A": '>',
      \ "\u227B": '>',
      \ "\u276F": '>',
      \ "\uFE65": '>',
      \ "\uFF1F": '?',
      \ "\uFE16": '?',
      \ "\uFE56": '?',
      \ "\uFF20": '@',
      \ "\uFE6B": '@',
      \ "\u0391": 'A',
      \ "\u0410": 'A',
      \ "\u13AA": 'A',
      \ "\u0392": 'B',
      \ "\u0412": 'B',
      \ "\u13F4": 'B',
      \ "\u15F7": 'B',
      \ "\u2C82": 'B',
      \ "\u03F9": 'C',
      \ "\u0421": 'C',
      \ "\u13DF": 'C',
      \ "\u216D": 'C',
      \ "\u2CA4": 'C',
      \ "\u13A0": 'D',
      \ "\u15EA": 'D',
      \ "\u216E": 'D',
      \ "\u0395": 'E',
      \ "\u0415": 'E',
      \ "\u13AC": 'E',
      \ "\u15B4": 'F',
      \ "\u050C": 'G',
      \ "\u13C0": 'G',
      \ "\u0397": 'H',
      \ "\u041D": 'H',
      \ "\u12D8": 'H',
      \ "\u13BB": 'H',
      \ "\u157C": 'H',
      \ "\u2C8E": 'H',
      \ "\u0399": 'I',
      \ "\u0406": 'I',
      \ "\u2160": 'I',
      \ "\u0408": 'J',
      \ "\u13AB": 'J',
      \ "\u148D": 'J',
      \ "\u039A": 'K',
      \ "\u13E6": 'K',
      \ "\u16D5": 'K',
      \ "\u212A": 'K',
      \ "\u2C94": 'K',
      \ "\u13DE": 'L',
      \ "\u14AA": 'L',
      \ "\u216C": 'L',
      \ "\u039C": 'M',
      \ "\u03FA": 'M',
      \ "\u041C": 'M',
      \ "\u13B7": 'M',
      \ "\u216F": 'M',
      \ "\u039D": 'N',
      \ "\u2C9A": 'N',
      \ "\u039F": 'O',
      \ "\u041E": 'O',
      \ "\u2C9E": 'O',
      \ "\u03A1": 'P',
      \ "\u0420": 'P',
      \ "\u13E2": 'P',
      \ "\u2CA2": 'P',
      \ "\u051A": 'Q',
      \ "\u2D55": 'Q',
      \ "\u13A1": 'R',
      \ "\u13D2": 'R',
      \ "\u1587": 'R',
      \ "\u0405": 'S',
      \ "\u13DA": 'S',
      \ "\u03A4": 'T',
      \ "\u0422": 'T',
      \ "\u13A2": 'T',
      \ "\u13D9": 'V',
      \ "\u2164": 'V',
      \ "\u13B3": 'W',
      \ "\u13D4": 'W',
      \ "\u03A7": 'X',
      \ "\u0425": 'X',
      \ "\u2169": 'X',
      \ "\u2CAC": 'X',
      \ "\u03A5": 'Y',
      \ "\u2CA8": 'Y',
      \ "\u0396": 'Z',
      \ "\u13C3": 'Z',
      \ "\uFF3B": '[',
      \ "\uFF3C": '\',
      \ "\u2216": '\',
      \ "\u29F5": '\',
      \ "\u29F9": '\',
      \ "\uFE68": '\',
      \ "\uFF3D": ']',
      \ "\uFF3E": '^',
      \ "\u02C4": '^',
      \ "\u02C6": '^',
      \ "\u1DBA": '^',
      \ "\u2303": '^',
      \ "\uFF3F": '_',
      \ "\u02CD": '_',
      \ "\u268A": '_',
      \ "\uFF40": '`',
      \ "\u02CB": '`',
      \ "\u1FEF": '`',
      \ "\u2035": '`',
      \ "\u0251": 'a',
      \ "\u0430": 'a',
      \ "\u03F2": 'c',
      \ "\u0441": 'c',
      \ "\u217D": 'c',
      \ "\u0501": 'd',
      \ "\u217E": 'd',
      \ "\u0435": 'e',
      \ "\u1971": 'e',
      \ "\u0261": 'g',
      \ "\u04BB": 'h',
      \ "\u0456": 'i',
      \ "\u2170": 'i',
      \ "\u03F3": 'j',
      \ "\u0458": 'j',
      \ "\u217C": 'l',
      \ "\u217F": 'm',
      \ "\u1952": 'n',
      \ "\u03BF": 'o',
      \ "\u043E": 'o',
      \ "\u0D20": 'o',
      \ "\u2C9F": 'o',
      \ "\u0440": 'p',
      \ "\u2CA3": 'p',
      \ "\u0455": 's',
      \ "\u1959": 'u',
      \ "\u222A": 'u',
      \ "\u1D20": 'v',
      \ "\u2174": 'v',
      \ "\u2228": 'v',
      \ "\u22C1": 'v',
      \ "\u1D21": 'w',
      \ "\u0445": 'x',
      \ "\u2179": 'x',
      \ "\u2CAD": 'x',
      \ "\u0443": 'y',
      \ "\u1EFF": 'y',
      \ "\u1D22": 'z',
      \ "\uFF5B": '{',
      \ "\uFE5B": '{',
      \ "\uFF5C": '|',
      \ "\u01C0": '|',
      \ "\u16C1": '|',
      \ "\u239C": '|',
      \ "\u239F": '|',
      \ "\u23A2": '|',
      \ "\u23A5": '|',
      \ "\u23AA": '|',
      \ "\u23AE": '|',
      \ "\uFFE8": '|',
      \ "\uFF5D": '}',
      \ "\uFE5C": '}',
      \ "\uFF5E": '~',
      \ "\u02DC": '~',
      \ "\u2053": '~',
      \ "\u223C": '~'
      \ }

let s:invisible_chars_map = {
      \ "\u2060": ' ',
      \ "\u2061": ' ',
      \ "\u2062": ' ',
      \ "\u2063": ' ',
      \ "\u2064": ' ',
      \ "\u2065": ' ',
      \ "\u2066": ' ',
      \ "\u2067": ' ',
      \ "\u2068": ' ',
      \ "\u2069": ' '
      \ }

let s:all_chars_map = extend(extend({}, s:visible_chars_map), s:invisible_chars_map)

let s:visible_chars_regex = '[' . join(keys(s:visible_chars_map), '') . ']'
let s:invisible_chars_regex = '[' . join(keys(s:invisible_chars_map), '') . ']'

function! s:HighlighTrolling()
  if !exists('w:highlighted_troll_stopper')
    call matchadd('TrollStopper', s:visible_chars_regex)

    let w:highlighted_troll_stopper = 1
  endif

  if g:troll_stopper_conceal
    call matchadd('Conceal', s:invisible_chars_regex, 10, -1, { 'conceal': ' ' })
    setlocal conceallevel=2 concealcursor=nc
  endif
endfunction

function! s:TrollStop(line1, line2)
  let saved_search=@/
  let line = line(".")
  let col = col(".")

  for [key, value] in items(s:all_chars_map)
    if value ==# '/' || value ==# '&' || value ==# '~'
      let value = '\' . value
    endif
    silent! keepj execute ':'.a:line1.','.a:line2.'s/'.key.'/'.value.'/g'
  endfor

  let @/=saved_search
  call cursor(line, col)
endfunction

augroup TrollHighlight
  autocmd!
  autocmd BufEnter,WinEnter * call <SID>HighlighTrolling()
augroup END

command! -range=% TrollStop call <SID>TrollStop(<line1>, <line2>)

let &cpo = s:save_cpo
unlet s:save_cpo

" Notes about `TrollHighlight` autocommands and the way highlight matching
" is done:
" It turns out adding a new highlight pattern to buffers isn't so easy. Here
" are the testing scenarios used for this plugin:
"
" 1. start vim without a file ($ vim) and paste some text containing troll
" characters.
" 2. open a file containing troll characters ($ vim test.txt)
" 3. open a file containing troll characters ($ vim test.txt), then invoke
" `:split` command
" 4. open a file containing troll characters ($ vim text.txt), open another
" random file, then return to the first file with `:buffer #` command
"
" Only triggering with `BufEnter` + `WinEnter` autocommands passed all the
" above tests.
