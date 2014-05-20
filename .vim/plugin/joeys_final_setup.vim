" Do final initialisation of Vim.
" Opens all the IDE-like widgets I like to use in Vim.

if exists('s:JoeysFinalSetup_Ran_Already')
	echo "JoeysFinalSetup refusing to run a second time."
	finish
endif

" We don't want to run until all the plugins have loaded.  So we wait for a CursorHold event.
augroup JFSOnceOnly
	au!
	au CursorHold * call <SID>JoeysFinalSetup()
augroup END

function! s:JoeysFinalSetup()
	augroup JFSOnceOnly
		au!
	augroup END

	" Still doesn't always happen with this enabled.  (Or keeps resetting later?)
	" highlight Comment ctermfg=darkgrey guifg=darkgrey

	" On very long files, :Joeyfolding takes a long time to run.
	" Furthermore, on *reasonably* long files, it seems to lag up/down cursor movement.  (Although that may be related to RepeatLast triggering CursorHold early.)
	" Either way, we don't want to run this automatically on large files.  (If indeed we want to run it at all.)
	if line("$") < 7000
		:Joeyfolding
	endif
	" BUG: I fear this only enables folding on the initial buffer, not all of them.
	" For that we would need:
	" au BufEnter * :Joeyfolding
	" But then it doesn't work on the first buffer!
	" And it causes problems e.g. setting foldmethod on magic windows like TList.

	":Tlist
	" Didn't appear to work:
	"execute "normal \:Tlist"
	" Preferred solution: let g:Tlist_Auto_Open = 1 in .vimrc

	"" Doesn't open at bootup, presumably because it's empty.
	" :cwindow

	" :VSTreeExplore
	" BUG: Even with silent, VSTreeExplore throws an error and we never get to...
	" Reposition on editing frame/window
	"execute "normal \<C-w><Right>"
	"" BUG TODO: NONE of the normals (attempt to reposition) work!

	" :ConqueTerm

endfunction

