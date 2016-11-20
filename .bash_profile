# runs for login shells

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
