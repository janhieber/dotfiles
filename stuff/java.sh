# fix ugly font
_JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
#_JAVA_OPTIONS="$_JAVA_OPTIONS -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFee"
_JAVA_OPTIONS="$_JAVA_OPTIONS -Dswing.aatext=true"
#_JAVA_OPTIONS="$_JAVA_OPTIONS -Dsun.java2d.opengl=true"
export _JAVA_OPTIONS

# fix problems with eclipse GUI
export SWT_GTK3=0

