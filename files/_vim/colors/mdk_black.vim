" mdk_black color scheme
"
" Heavily inspired by the ir_black color scheme available at
" http://blog.infinitered.com/entries/show/8
"


"                         24-bit     256-color
let s:colors = {
\   'darkblue':         [ '#96cbfe', 117 ],
\   'darkgreen':        [ '#A8FF60', 155 ],
\   'darkcyan':         [ '#C6C5FE', 183 ],
\   'darkred':          [ '#FF6C60', 203 ],
\   'darkmagenta':      [ '#FF73FD', 207 ],
\   'darkyellow':       [ '#FFFFB6', 228 ],
\   'gray':             [ '#7c7c7c', 243 ],
\   'blue':             [ '#66B5FF',  75 ],
\   'green':            [ '#CEFFAB', 193 ],
\   'cyan':             [ '#DFDFFE', 189 ],
\   'red':              [ '#FFB6B0', 217 ],
\   'magenta':          [ '#FF9CFE', 213 ],
\   'yellow':           [ '#FFFFCB', 230 ],
\
\   'darkamber':        [ '#ffa560', 215 ],
\   'amber':            [ '#FFD2A7', 223 ],
\
\   'verylightgray':    [ '#cccccc', 251 ],
\   'darkgray':         [ '#3d3d3d', 237 ],
\   'verydarkgray':     [ '#1c1c1c', 234 ],
\   'charcoal':         [ '#121212', 233 ],
\   'darkcoolgray':     [ '#47496c', 235 ],
\   'palegreen':        [ '#99cc99', 114 ],
\   'darkpalegreen':    [ '#448844',  65 ],
\   'verydarkyellow':   [ '#808000',   3 ],
\   'peach':            [ '#E18964', 173 ],
\   'teal':             [ '#00A0A0',  37 ],
\   'lightpurple':      [ '#FFCCFF', 225 ],
\
\   'orange':           [ '#FF8000', 208 ],
\   'brown':            [ '#B18A3D', 137 ],
\   'deepred':          [ '#592929',  52 ],
\}

function! s:resolve_color(color)
    let l:color = tolower(a:color)
    if has_key(s:colors, l:color)
        return s:colors[l:color]
    else
        return [ a:color, a:color ]
    endif
endfunction

function! s:highlight(group, guifg, guibg, guiattr, termfg, termbg, termattr)
    let l:fg = s:resolve_color(a:guifg)
    let l:bg = s:resolve_color(a:guibg)
    let l:guifg = l:fg[0]
    let l:guibg = l:bg[0]
    if &t_Co == 256
        let l:termfg = l:fg[1]
        let l:termbg = l:bg[1]
    else
        let l:termfg = a:termfg
        let l:termbg = a:termbg
    endif

    "echo 'hi ' . a:group .
    "            \ ' guifg='   . l:guifg  . ' guibg='   . l:guibg  . ' gui='   . a:guiattr
    "            \ ' ctermfg=' . l:termfg . ' ctermbg=' . l:termbg . ' cterm=' . a:termattr

    exec 'hi ' . a:group .
                \ ' guifg='   . l:guifg  . ' guibg='   . l:guibg  . ' gui='   . a:guiattr
                \ ' ctermfg=' . l:termfg . ' ctermbg=' . l:termbg . ' cterm=' . a:termattr
endfunction

" ********************************************************************************
" Standard colors used in all ir_black themes:
" Note, x:x:x are RGB values
"
"  normal: #f6f3e8
" 
"  string: #A8FF60  168:255:96                   
"    string inner (punc, code, etc): #00A0A0  0:160:160
"  number: #FF73FD  255:115:253                 
"  comments: #7C7C7C  124:124:124
"  keywords: #96CBFE  150:203:254             
"  operators: white
"  class: #FFFFB6  255:255:182
"  method declaration name: #FFD2A7  255:210:167
"  regular expression: #E9C062  233:192:98
"    regexp alternate: #FF8000  255:128:0
"    regexp alternate 2: #B18A3D  177:138:61
"  variable: #C6C5FE  198:197:254
"  
" Misc colors:
"  red color (used for whatever): #FF6C60   255:108:96 
"     light red: #FFB6B0   255:182:176
"
"  brown: #E18964  good for special
"
"  lightpurpleish: #FFCCFF
" 
" Interface colors:
"  background color: black
"  cursor (where underscore is used): #FFA560  255:165:96
"  cursor (where block is used): white
"  visual selection: #1D1E2C  
"  current line: #151515  21:21:21
"  search selection: #07281C  7:40:28
"  line number: #3D3D3D  61:61:61


" ********************************************************************************
" The following are the preferred 16 colors for your terminal
"           Colors      Bright Colors
" Black     #4E4E4E     #7C7C7C
" Red       #FF6C60     #FFB6B0
" Green     #A8FF60     #CEFFAB
" Yellow    #FFFFB6     #FFFFCB
" Blue      #96CBFE     #FFFFCB
" Magenta   #FF73FD     #FF9CFE
" Cyan      #C6C5FE     #DFDFFE
" White     #EEEEEE     #FFFFFF

" ********************************************************************************
set background=dark
hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "mdk_black"

call s:highlight('Normal',       'VeryLightGray', 'Black',          'NONE',   'LightGray', 'Black',      'NONE')
call s:highlight('NonText',      'VeryDarkGray',  'Black',          'NONE',   'DarkGray',  'Black',      'NONE')
call s:highlight('SpecialKey',   'VeryDarkGray',  'NONE',           'NONE',   'DarkGray',  'NONE',       'NONE')

call s:highlight('Cursor',       'Black',         'DarkAmber',      'NONE',   'Black',     'DarkYellow', 'NONE')
call s:highlight('Visual',       'NONE',          'DarkCoolGray',   'NONE',   'NONE',      'DarkGray',   'NONE')
if version >= 700
    call s:highlight('ColorColumn',  'NONE',          'DeepRed',        'NONE',   'NONE',      'DarkRed',    'NONE')
    " TODO: Figure out why CursorColumn can't be linked to CursorLine
    call s:highlight('CursorColumn', 'NONE',          'Charcoal',       'NONE',   'NONE',      'DarkBlue',   'bold')
    call s:highlight('CursorLine',   'NONE',          'Charcoal',       'NONE',   'NONE',      'DarkBlue',   'bold')
endif

call s:highlight('LineNr',       'Gray',          'DarkGray',       'NONE',   'DarkGray',  'Black',      'NONE')

call s:highlight('VertSplit',    'DarkGray',      'DarkGray',       'NONE',   'DarkGray',  'DarkGray',   'NONE')
call s:highlight('StatusLine',   'White',         'DarkGray',       'italic', 'White',     'DarkGray',   'NONE')
call s:highlight('StatusLineNC', 'Black',         'DarkGray',       'NONE',   'Black',     'DarkGray',   'NONE')

call s:highlight('Folded',       'DarkGray',      'Charcoal',       'NONE',   'NONE',      'NONE',       'NONE')
call s:highlight('FoldColumn',   'Blue',          'Charcoal',       'NONE',   'Blue',      'NONE',       'NONE')

if version >= 700
    call s:highlight('Search',       'NONE',          'DarkPaleGreen',  'NONE',  'NONE',       'yellow',     'NONE')
endif

call s:highlight('Title',        'LightPurple',   'NONE',           'bold',   'NONE',      'NONE',       'NONE')

call s:highlight('ErrorMsg',     'White',         'DarkRed',        'bold',   'White',     'DarkRed',    'NONE')
call s:highlight('WarningMsg',   'Charcoal',      'VeryDarkYellow', 'bold',   'DarkBlue',  'DarkYellow', 'NONE')

hi WildMenu         guifg=green       guibg=yellow      gui=NONE      ctermfg=black       ctermbg=yellow      cterm=NONE
hi PmenuSbar        guifg=black       guibg=white       gui=NONE      ctermfg=black       ctermbg=white       cterm=NONE
"hi Ignore           guifg=gray        guibg=black       gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE


" MDK: Spelling error colors were omitted and the defaults were hard to
"      read with the rest of the color scheme.
if version >= 700
    hi SpellBad       guifg=NONE        guibg=NONE        gui=undercurl guisp=red           ctermfg=red         ctermbg=NONE        cterm=UNDERLINE
    hi SpellCap       guifg=NONE        guibg=NONE        gui=undercurl guisp=yellow        ctermfg=yellow      ctermbg=NONE        cterm=UNDERLINE
    hi SpellLocal     guifg=NONE        guibg=NONE        gui=undercurl guisp=lightblue     ctermfg=lightblue   ctermbg=NONE        cterm=UNDERLINE
    hi SpellRare      guifg=NONE        guibg=NONE        gui=undercurl guisp=lightblue     ctermfg=lightblue   ctermbg=NONE        cterm=UNDERLINE
endif
" MDK: end

call s:highlight('DiffAdd',      'NONE',          'Charcoal',       'NONE',   'NONE',      'DarkBlue',   'NONE')
call s:highlight('DiffChange',   'NONE',          'Charcoal',       'NONE',   'NONE',      'DarkCyan',   'NONE')
call s:highlight('DiffDelete',   'Charcoal',      'Charcoal',       'NONE',   'Blue',      'DarkCyan',   'NONE')
call s:highlight('DiffText',     'NONE',          'DeepRed',        'bold',   'NONE',      'DarkRed',    'bold')

" Message displayed in lower left, such as --INSERT--
hi ModeMsg          guifg=black       guibg=#C6C5FE     gui=BOLD      ctermfg=black       ctermbg=cyan        cterm=BOLD

if version >= 700 " Vim 7.x specific colors
    hi MatchParen     guifg=#f6f3e8     guibg=#857b6f     gui=BOLD      ctermfg=white       ctermbg=darkgray    cterm=NONE
    " MDK: Make the popup menu look nicer and make highlighted search results
    "      stand out.
    "  hi Pmenu          guifg=#f6f3e8     guibg=#444444     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
    hi Pmenu          guifg=#f6f3e8     guibg=#444444     gui=NONE      ctermfg=NONE        ctermbg=242         cterm=NONE
    "  hi PmenuSel       guifg=#000000     guibg=#cae682     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
    hi PmenuSel       guifg=#000000     guibg=#cae682     gui=NONE      ctermfg=NONE        ctermbg=242         cterm=NONE
    " MDK: end
    " MDK: Add appropriate colors for the tab line (new in 7.3)
    hi TabLine        guifg=NONE        guibg=DarkGrey    gui=underline ctermfg=15          ctermbg=232         cterm=underline      term=underline
    hi TabLineFill                                        gui=reverse   ctermfg=NONE        ctermbg=232         cterm=underline      term=reverse
    hi TabLineSel                                         gui=bold      ctermfg=lightblue   ctermbg=242         cterm=bold,underline term=bold
    " MDK: end
endif

" Syntax highlighting

call s:highlight('Comment',              'Gray',          'NONE',         'NONE',      'Gray',        'NONE',       'NONE')

call s:highlight('Constant',             'PaleGreen',     'NONE',         'NONE',      'DarkCyan',    'NONE',       'NONE')
call s:highlight('String',               'DarkGreen',     'NONE',         'NONE',      'DarkGreen',   'NONE',       'NONE')
call s:highlight('Number',               'DarkMagenta',   'NONE',         'NONE',      'DarkMagenta', 'NONE',       'NONE')
hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number

call s:highlight('Identifier',           'DarkRed',       'NONE',         'NONE',      'DarkCyan',    'NONE',       'NONE')
call s:highlight('Function',             'Amber',         'NONE',         'NONE',      'Yellow',      'NONE',       'NONE')

call s:highlight('Statement',            'Blue',          'NONE',         'NONE',      'Blue',        'NONE',       'NONE')
call s:highlight('Conditional',          'Blue',          'NONE',         'NONE',      'Blue',        'NONE',       'NONE')
call s:highlight('Operator',             'White',         'NONE',         'NONE',      'White',       'NONE',       'NONE')
call s:highlight('Keyword',              'Blue',          'NONE',         'NONE',      'Blue',        'NONE',       'NONE')
call s:highlight('Exception',            'DarkAmber',     'NONE',         'NONE',      'DarkYellow',  'NONE',       'NONE')
hi link Exception       Statement
hi link Repeat          Statement
hi link Label           Statement

call s:highlight('PreProc',              'Blue',          'NONE',         'NONE',      'Blue',        'NONE',       'NONE')
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc

call s:highlight('Type',                 'Yellow',        'NONE',         'NONE',      'Yellow',      'NONE',       'NONE')
call s:highlight('StorageClass',         'Magenta',       'NONE',         'NONE',      'Magenta',     'NONE',       'NONE')
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type

call s:highlight('Special',              'Peach',         'NONE',         'NONE',      'Magenta',     'NONE',       'NONE')
call s:highlight('Delimiter',            'Teal',          'NONE',         'NONE',      'Cyan',        'NONE',       'NONE')
hi link SpecialChar     Special
hi link Tag             Special
hi link SpecialComment  Special
hi link Debug           Special

" TODO: Undercurl color: guisp=#FF6C60 " undercurl color
call s:highlight('Error',               'NONE',          'NONE',         'undercurl', 'White',       'Red',        'bold')

call s:highlight('Todo',                'DarkAmber',     'NONE',         'NONE',      'Red',         'NONE',       'NONE')

" Special for Java
call s:highlight('javaDocComment',      'PaleGreen',     'NONE',         'NONE',      'DarkGreen',       'NONE',       'NONE')
call s:highlight('javaCommentTitle',    'PaleGreen',     'NONE',         'bold',      'DarkGreen',       'NONE',       'NONE')
call s:highlight('javaDocSeeTag',       'DarkPaleGreen', 'NONE',         'NONE',      'Green',           'NONE',       'NONE')
call s:highlight('javaDocParam',        'DarkAmber',     'NONE',         'NONE',      'DarkYellow',      'NONE',       'NONE')
hi link javaCommentStar       javaDocComment
hi link javaDocTags           javaDocSeeTag
hi link javaDocParam          javaDocSeeTag
hi link javaDocSeeTagParam    javaDocSeeTag

" Special for Ruby
call s:highlight('rubyRegexp',          'Brown',         'NONE',         'NONE',      'Brown',           'NONE',       'NONE')
call s:highlight('rubyRegexpDelimiter', 'Orange',        'NONE',         'NONE',      'Brown',           'NONE',       'NONE')
call s:highlight('rubyEscape',          'White',         'NONE',         'NONE',      'Cyan',            'NONE',       'NONE')
call s:highlight(
            \       'rubyInterpolationDelimiter',   'Teal',          'NONE',         'NONE',      'Blue',            'NONE',       'NONE')
call s:highlight('rubyControl',         'Blue',          'NONE',         'NONE',      'Blue',            'NONE',       'NONE')  "and break, etc
call s:highlight('rubyGlobalVariable',  'LightPurple',   'NONE',         'NONE',      'LightBlue',       'NONE',       'NONE')
call s:highlight('rubyStringDelimiter', 'DarkPaleGreen', 'NONE',         'NONE',      'DarkGreen',       'NONE',       'NONE')
hi link rubyClass             Keyword 
hi link rubyModule            Keyword 
hi link rubyKeyword           Keyword 
hi link rubyOperator          Operator
hi link rubyIdentifier        Identifier
hi link rubyInstanceVariable  Identifier
hi link rubyGlobalVariable    Identifier
hi link rubyClassVariable     Identifier
hi link rubyConstant          Type  


" Special for XML
hi link xmlTag          Keyword 
hi link xmlTagName      Conditional 
hi link xmlEndTag       Identifier 


" Special for HTML
hi link htmlTag         Keyword 
hi link htmlTagName     Conditional 
hi link htmlEndTag      Identifier 


" Special for Javascript
hi link javaScriptNumber      Number 


" Special for Python
"hi  link pythonEscape         Keyword      


" Special for CSharp
hi  link csXmlTag             Keyword      

" Special for PHP
