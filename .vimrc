execute pathogen#infect()
syntax on filetype plugin indent on
colorscheme molokai
set backspace=2 " make backspace work like most other apps

" Use deoplete.
" let g:deoplete#enable_at_startup = 1

" kernel dev
"set tabstop=8           " number of visual spaces per TAB
"set softtabstop=8       " number of spaces in tab when editing
"set shiftwidth=8
"set noexpandtab           " tabs are spaces
set colorcolumn=81
highlight ColorColumn ctermbg=Black ctermfg=DarkRed

" normal dev
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4
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

set noincsearch

" manually enable cindent (should be enabled by default, but not working)
autocmd FileType c set cindent
autocmd FileType cpp set cindent

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
let g:ycm_global_ycm_extra_conf = '/home/andrew/.vim/.ycm_extra_conf.py'
"let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

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
let g:airline#extensions#tabline#enabled = 1
"let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
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
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set runtimepath^=~/.vim/bundle/ctrlp.vim

" NERDTree remaps
map <C-n> :NERDTreeToggle<CR>

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

"if $TERM == "xterm-256color"
  set t_Co=256
"endif
"set termguicolors

"ONLY apply the linux coding style plugin in certain dirs (overrides
"indentation rules)
let g:linuxsty_patterns = [ "/usr/src/", "/linux" ]

function AskForConfirmation(cmd)
    while 1
        redraw!
        echohl WarningMsg
        echo 'Really perform action: ' . a:cmd . '?'
        echohl None
        let choice = inputlist(['1. yes', '2. no'])
        if choice == 0 || choice > 2
            redraw!
            echohl WarningMsg
            echo 'Please enter a number between 1 and 2'
            echohl None
            continue
        elseif choice == 1
            return 1
        else
            return 0
        endif
        break
endfunction

function P4Edit()
    :!remoteP4.sh p4 edit %
endfunction

function P4Revert()
    if AskForConfirmation('REVERT ' . expand('%')) == 1
        :!remoteP4.sh p4 revert %
    endif
endfunction

" open file for editing on remote Perforce workspace
map <F2> :call P4Edit()<CR>
imap <F2> :call P4Edit()<CR>

map <F8> :call P4Revert()<CR>
imap <F8> :call P4Revert()<CR>
