execute pathogen#infect()
syntax on
filetype plugin indent on

" kernel dev
"set tabstop=8           " number of visual spaces per TAB
"set softtabstop=8       " number of spaces in tab when editing
"set shiftwidth=8
"set noexpandtab           " tabs are spaces
set colorcolumn=81
highlight ColorColumn ctermbg=Black ctermfg=DarkRed

" normal dev
set tabstop=2           " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set shiftwidth=2
set expandtab           " tabs are spaces

set number              " show line numbers
set rnu                 " enable relative line numbers
set cursorline          " highlight the current line

set showcmd             " show command in bottom bar
set showmatch           " highlight matching [{()}]
set nohlsearch          " don't highlight search terms

set foldenable          " enable folding
set foldlevelstart=100  " open most folds by default
set foldnestmax=10      " 10 nested fold max

set updatetime=250      " reduce time to show markers (git/syntastic)

" disable YCM linting
let g:ycm_show_diagnostics_ui = 0

augroup MyHighlighter
  autocmd!
  autocmd CursorMoved * if get(g:, 'myhighlight', 0) | exe printf('match IncSearch @\<%s\>@', expand('<cword>')) | endif
  autocmd CursorMoved * if !get(g:, 'myhighlight', 0) | :call clearmatches() | endif
augroup END

nnoremap <f4> :let g:myhighlight = !get(g:, 'myhighlight', 0)<cr>

" Handy tags mappings
" Open definition in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Open definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=6 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" syntastic settings (from readme)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%{fugitive#statusline()}
set statusline+=%*

" disable checks for dart files
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["dart"] }

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 0

" space open/closes folds
nnoremap <space> z
set foldmethod=syntax   " fold based on indent level
let g:EclimCompletionMethod = 'omnifunc'

" YCM options
let g:ycm_auto_start_csharp_server = 1
let g:ycm_auto_stop_csharp_server = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_filetype_blacklist = { 'dart': 1 }

" Deoplete options
let g:deoplete#enable_at_startup = 1
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" ignore short matches
call deoplete#custom#option('min_pattern_length', 2)
call deoplete#custom#option('deoplete-source-attribute-min_pattern_length', 2)
" display popup after first char
let g:deoplete#auto_complete_start_length = 0

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<return>"
" workaround to let enter accept a snip if available, but still enter <CR>
" otherwise. From kbenzie@https://github.com/Valloric/YouCompleteMe/issues/420
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"

let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"vim-airline
let g:airline_powerline_fonts = 1
set laststatus=2

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Disable Arrow keys in Insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

set mouse=r

" CtrlP remaps (fuzzy finder)
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"set runtimepath^=~/.vim/bundle/ctrlp.vim

" NERDTree remaps
map <C-n> :NERDTreeToggle<CR>

" fzf.vim
map <C-p> :Files<CR>
map <A-p> :Buffers<CR>

" NERDTree auto-open
" autocmd vimenter * NERDTree

" Close vim if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Tagbar remaps
nmap <F8> :TagbarToggle<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

if $TERM == "xterm-256color"
  set t_Co=256
endif

set termguicolors
set background=dark
colorscheme gruvbox

" autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
" autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" dart specific
let g:lsc_server_commands = {'dart': 'dart_language_server'}
let g:lsc_auto_map = v:false " Use defaults
" disable LSC highlighting
let g:lsc_reference_highlights = v:false
" ... or set only the keys you want mapped, defaults are:
let g:lsc_auto_map = {
    \ 'GoToDefinition': '<C-]>',
    \ 'FindReferences': 'gr',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'ShowHover': 'K',
    \ 'Completion': 'completefunc',
    \}
