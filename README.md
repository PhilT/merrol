Merrol
======
Minimalist Editor for Ruby, Rails and Other Languages

What
----------------------------------
An editor for Ruby, Rails and supporting langauges, written in Ruby with an open design to allow customization and easy maintainance.

Why
----------------------------------
I noticed, while using other editors that I found myself constantly re-arranging windows to get the optimum setup. I thought, "There must be a better way".

I wanted to make an editor that was open not just the source code but in maintainability, enhancement and customization.

I wanted to challenge the conventional editor design and take a different approach to editing. One that doesn't involve a mouse but one that can be learnt quickly.

Design Goals
----------------------------------
To get the most of a screen whether it's a 30" desktop or a 13" laptop. Control screens without having to resize windows.

Foremost it will be a Rails and Ruby editor. There will be nothing stopping it being customized for other languages and there will be nothing to stop it being forked or plugins added.

No toolbars, menus, icons or any other extra fluff. Straightforward shortcuts will allow access to all functions.

Robust - All built with well factored, well tested Ruby code

No dialogs - Panels will allow a more versatible way to accept input

Support multiple instances for loading different application directories

(Planned) Features
----------------------------------
Autoload configuration (YAML files)
Open file with fuzzy matcher (CTRL+O)
Close file (CTRL+W)
Multi-file switching (CTRL+TAB)
Remove trailing space on save
Bracket matching
Snippets (Smart code tab completion)
Find/Replace (CTRL+F)
Multi-file find/replace (CTRL+SHIFT+F)
Save window position
Output window
Integrated autospec

rails generator snippets
rcov - pretty test coverage output
rspec - pretty html specs output
Git support (do git add before reloading files? or between loads/saves?)
rdoc - builtin help using rdoc - somehow for ruby as well
handle really large files (e.g. SQL dump or log file. Probably turn off highlighting)

