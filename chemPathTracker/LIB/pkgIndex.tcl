# Tcl package index file, version 1.1
# This file is generated by the "pkg_mkIndex" command
# and sourced either when an application starts up or
# by a "package unknown" script.  It invokes the
# "package ifneeded" command to set up package-related
# information so that packages will be loaded automatically
# in response to "package require" commands.  When this
# script is sourced, the variable $dir must contain the
# full path name of this file's directory.

package ifneeded BPFAboutframe 1.0 [list source [file join $dir aboutFrame.tcl]]
package ifneeded colorbar 1.0 [list source [file join $dir/colorbar colorbar.tcl]]
package ifneeded math 1.2.4 [list source [file join $dir/math math.tcl]]
package ifneeded tablelist 4.11 [list source [file join $dir/tablelist4.11 tablelist.tcl]]
