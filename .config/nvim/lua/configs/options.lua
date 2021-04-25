local apply_options = require("configs.utils").apply_options

apply_options(
    {
        termguicolors  = true;
        errorbells     = false;
        visualbell     = true;
        hidden         = true;
        fileformats    = "unix,mac,dos";
        magic          = true;
        virtualedit    = "block";
        encoding       = "utf-8";
        viewoptions    = "folds,cursor,curdir,slash,unix";
        sessionoptions = "curdir,help,tabpages,winsize";
        clipboard      = "unnamedplus";
        wildignorecase = true;
        wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
        backup         = false;
        writebackup    = false;
        swapfile       = false;
        history        = 2000;
        shada          = "!,'300,<50,@100,s10,h";
        backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
        smarttab       = true;
        shiftround     = true;
        timeout        = true;
        ttimeout       = true;
        timeoutlen     = 500;
        ttimeoutlen    = 10;
        updatetime     = 100;
        redrawtime     = 1500;
        ignorecase     = true;
        smartcase      = true;
        infercase      = true;
        incsearch      = true;
        wrapscan       = true;
        complete       = ".,w,b,k";
        inccommand     = "nosplit";
        grepformat     = "%f:%l:%c:%m";
        breakat        = [[\ \	;:,!?]];
        startofline    = false;
        whichwrap      = "h,l,<,>,[,],~";
        splitbelow     = true;
        splitright     = true;
        smartindent    = true;
        autoindent     = true;
        switchbuf      = "useopen";
        backspace      = "indent,eol,start";
        diffopt        = "filler,iwhite,internal,algorithm:patience";
        completeopt    = "menuone,noselect";
        jumpoptions    = "stack";
        showmode       = false;
        shortmess      = "aoOTIcF";
        scrolloff      = 2;
        sidescrolloff  = 5;
        foldlevelstart = 99;
        ruler          = false;
        list           = true;
        showtabline    = 1;
        winwidth       = 20;
        winminwidth    = 10;
        pumheight      = 15;
        pumwidth       = 60;
        helpheight     = 12;
        previewheight  = 12;
        showcmd        = false;
        cmdheight      = 1;
        cmdwinheight   = 5;
        laststatus     = 2;
        display        = "lastline";
        showbreak      = "↳  ";
        listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←,eol:↲";
        fillchars      = [[eob:\ ]];
        pumblend       = 10;
        winblend       = 10;
        synmaxcol      = 2500;
        formatoptions  = "1jcroql";
        textwidth      = 80;
        expandtab      = true;
        tabstop        = 4;
        shiftwidth     = 4;
        softtabstop    = -1;
        breakindentopt = "shift:2,min:20";
        wrap           = false;
        linebreak      = true;
        number         = true;
        relativenumber = true;
        colorcolumn    = "100";
        foldenable     = true;
        signcolumn     = "yes";
        conceallevel   = 3;
        concealcursor  = "niv";
    }
)

vim.api.nvim_exec([[
    syntax on
    filetype indent on
    filetype plugin on
]], false)
