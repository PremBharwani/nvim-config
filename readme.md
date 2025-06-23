# Description 

Here's my nvim config & a small todo that I wish to complete some day lol.

# Todo

- [ ] Searching
	- [ ] Find files
		- [x] vanilla
		- [ ] case sensitive
		- [ ] include / exclude patterns for directory
	- [ ] Find ***in*** a file (Ripgrep)
		- [x] find all in all files
		- [ ] Case sensitive
		- [ ] Include/exclude directories (pattern based)
	- [ ] Find and replace
- [ ] LSP
	- [x] Go to declarations
	- [x] Find something that's not imported yet
- [ ] AI stuff
	- [x] Copilot inline suggestions + friendly config
	- [ ] Inline chat :))
- [ ] Editor
	- [x] Titles for the currently opened buffers
	- [x] Navigation b/w opened buffers
	- [x] Splits
	- [x] Methods / functions outline navigation
		- [x] friendly keybind
		- [x] on statuline
	- [x] Directory navigation 
	- [x] Jump to matching braces - keybind
	- [x] auto save
- [ ] VCS
	- [x] show curr branch while on nvim
	- [ ] inline git blame
		- [x] friendly keybind  - `<leader> + b` - column git blame
	- [ ] merge conflict - handle manually
		- [ ] friendly ux ( go to the conflicted file, `:Gdiffsplit!` solve the issue in the middle one, then do `:only` to have the middle one only)
- [ ] Enhancements
	- [ ] Stylish lightline (bottom status bar)
	- [x] Snippets 
	- [ ] If I am in side a code block (say a function or a for loop) I should be able to traverse to the beginning of that immediate block
	- [ ] Quick navigate to the corresponding test file
	- [ ] Nothing should get yanked to clipboard except for when i explicitly do 'y' or 'x'. when I paste, the block I pasted over gets copied into clipboard. shouldn't happen. 
	- [ ] backspacing issue due to pair plugin
	- [x] the current block's signature at the very top like vscode - solved via 'wellle/context.vim'
	- [ ] live reloading of file
	- [x] try claude code nvim 
	- [ ] shortcut to get the cursor straight to the currently opened buffer in the nvim tree (for copy or smth)
	    - [ ] currently focused file shows up in the nvim tree file explorer
	- [ ] re-open to the files i left at


# Credits

- Credits to [Shetty's nvim config](https://github.com/srijanshetty/vimrc/tree/master/.config/nvim), I borrowed it as a starter & made my
modifs.
- To all the people who made the plugins I use, I love you all <3.
