emacs-config
============

From your home directory:

    $ git clone https://github.com/tboggs/emacs-config.git .emacs.d

    $ ln -s .emacs.d/.emacs

Note that this will clobber your existing emacs configuration.

If they're not already installed in your virtualenv

    pip install epc jedi

After starting emacs, switch to the virtualenv and install the jedi server:

    M-x venv-workon RET <virtualenv name>

    M-x jedi:install-server

You may need to restart and possibly install the server again. If packages
get installed under ~/.emacs.d/.python-environments, then you will most
likely need to delete that directory and try again.


