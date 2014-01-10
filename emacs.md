# Emacs

Install:

    apt-get install emacs

## Emacs Prelude

Install:

    curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh

    # Turn off guru mode to re-enable arrow keys
    echo "(setq prelude-guru nil)" > ~/.emacs.d/personal/prelude-guru-off.el

    # Copy the module list to our personal directory
    cp ~/.emacs.d/sample/prelude-modules.el ~/.emacs.d/personal/prelude-modules.el

    # Edit to tast
    emacs prelude-modules.el


## Package Manager (deprecated)

http://tromey.com/elpa/install.html

To install Emacs package manager, eval this:

    (let ((buffer (url-retrieve-synchronously
         "http://tromey.com/elpa/package-install.el")))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (eval-region (point) (point-max))
      (kill-buffer (current-buffer))))

This installs package.el in $HOME/.emacs.d/elpa/ and packages are installed in subdirectories.

To see what packages can be downloaded from ELPA, type M-x package-list-packages in Emacs. Then in the *Packages* buffer, type r. This will download the latest list of available packages.

To search  for a package in ELPA, go into the package menu. Then you can isearch (or whatever) through package names and descriptions. (If you don't see descriptions, make sure you are using the latest version of package.el.)

To update package.el, use the package menu, just as you would any other package.
    # Decide which modules we want
