package provide BPF 1.0

namespace eval BPF:: {
	package require math::statistics
	package require tablelist
	package require colorbar
	package require BPFAboutframe

        #### Read Packages


        #### Variables Program

  variable topGui ".path"
	variable guiFind ".find"
	variable debug 2



  variable selectData 		{
		{"Custom"			100	Avg	""}
		{"HBonds"			100	Pt	"type ND1 ND2 OD1 OE1 OE2 OG OG1 NH1 NH2 NE2 SG SE OD2 NZ OH"}
		{"Polar Amino Acids" 		100	Avg	"resname ARG ASN ASP CYS GLU GLN HIS HIE HID HIP LYS SER TYR"}
		{"Negative Charged Amino Acids" 100	Avg	"resname GLU ASP "}
		{"Positive Charged Amino Acids" 100     Avg     "resname ARG LYS HIS HIE HID HIP"}
		{"Ring containing Amino Acids"	100     Avg     "resname HIS HIE HID PRO PHE TYR TRP"}
		{"Non-Polar Amino Acids"	100     Avg     "resname ALA GLY ILE LEU MET PHE PRO TRP VAL"}
	}

	variable startSelection ""


	variable distcutoff 10
	variable startpoint "index 1"

	array set cost ""
	array set prev ""
	array set vertex ""
	array set edge ""

	variable outFind ""
	variable pathLayer ""
	variable outPath		""
	variable outPut		""
	variable startpoint		""
	variable topLayer		""
	array set point_dyn ""
	array set point_frm ""
	array set point_dist ""
	variable barLayer ""
	variable iniRep ""
	variable repId 0
	variable outRep ""
	variable resRep ""
	variable point_pair ""
	variable points 1
	array set point_coor ""
	array set pFind ""
}

proc BPF::BPF {} {

	if {[winfo exists $BPF::topGui] != 1} {
			BPF::path
    } else {
			#BPF::path
			wm deiconify $BPF::topGui
			#update
			#return $BPF::topGui
    }
	return $BPF::topGui

}

proc BPF::path {} {

	if {[info exists BPF::vertex(1)] == 1} {
		array unset BPF::prev; array set BPF::prev ""
		array unset BPF::vertex; array set BPF::vertex ""
		array unset BPF::edge; array set BPF::edge ""
		array unset BPF::point_dyn; array set BPF::point_dyn ""
		array unset BPF::point_frm; array set BPF::point_frm ""
		array unset BPF::point_dist; array set BPF::point_dist ""
		array unset BPF::point_coor; array set BPF::point_coor ""
		array unset BPF::pFind; array set BPF::pFind ""
	}

	set BPF::startSelection ""
	set BPF::distcutoff 10

	set BPF::pathLayer ""
	set BPF::outPath ""
	set BPF::topLayer		""
	set BPF::barLayer ""
	set BPF::iniRep ""
	set BPF::repId 0
	set BPF::outRep ""
	set BPF::resRep ""
	set BPF::point_pair ""

	set BPF::outFind ""

	display resetview
	set nameLayer ""
	set BPF::outRep ""

	foreach x [molinfo list] {
		if { [molinfo $x get name] == "ChemPathTrackerData"} {
			mol delete $x
		}

	}




	## startGui

set logo {
R0lGODlhaQAaAMZxAAAAAAICAg8PDhERERcXFxkZGR8gHyAgHyIiIR5FMDw+Oz5APEFBQUBDP0lN
RyRaN0lOSElRRypdOSZfNy9fO1NaUFRbUVtlV1xnWDx0QFxoWVRwTkJ4Q11xVWJwXDmBPWNyXVx2
U2NzXWV1XjuGPTKLO2d5X2h5X1aBTWl8YFqDUHR5cUqLQ2p/YGqAYGuBYGaFWmyDYG2GYG2HYHmC
d3qDeG6LYG+MYG6NX26OXm6QXW6RXW6SXG2TW26TXG6UW22WWWyXWG2XWWuYVjqqNT2pNzqqNmyY
V2qZVTyqNT+pNzyqNj2qNkCpOGmaVEanPEGpOGqaVESoOkGpOWibUkWoOkWoO0OpOWecUkeoO0Sp
OkqnPmadUEioPEunPlSkQk6mQFKlQWWeT1CmQE2nP16hSVOlQmGgS1akRFyiR2SfTl+hSVqjRVek
RGKgTGSgTWKhS////////////////////////////////////////////////////////////yH+
GkNyZWF0ZWQgd2l0aCBHSU1QIG9uIGEgTWFjACwAAAAAaQAaAAAH/oAAgoOEhYaHhCs1NIwMiI+Q
kZKTlIUmZ5iZmmcmgyJXT6FaREAIlaeoqZQ7RF42MaxEsrI7gzNEV7JNTVBpqr/Av6wVgxiztLZE
TxYAC2xEWsyTCHBwC8HYpztuhW7HtYK3y+GyL4IQ0oPM6AgWWtGFFhDZ9IU7VIVU38njCGm4F3Ic
e2PKiZIsRIp0wZWLSIoFb47lqFdvh5cBgxQcIwIOgDg0ZXD1ysGECEhZZQCElHXFDJpQIDWgQfml
CJMZFLNZJCAIg7d95GaNKkXECrgYXq5ACKlUkIVQzNxVESFIDK6clETsmHFt0AIeLQBo3IiM3JMe
JyxcczcOwNNl/iFTOoXqUVYyIlgltVkia8o8ACaIxAggAAfZsnW1pLAgbYGSJ1QBaHgSLa46uiKa
EOkqEG/eRy6KHOtiYYToGIIOHOY4aAgRI1IoE8GCYAuuGCnAECGjkohcAAiUBZmhYRebFDamKAHy
+dGZ1bJiGOhQQB/ZjlaPPTFpYUqSWU0tD0ojWvALzbPQmGp+CAlZLM+IqNiQAMXPjR11EGnCDMEY
IkosgIAMP/iQwnopDPHDDBaYgkAKM8TgwQw6DIHEDFQtoMEMxHUFAAQMLgChCKZYwKEGgzx4oAgc
phNPebKc0YwsJFDAwQMlHNaRONJE1MQ1MShxRX9ANPEdEVBs/iENBGSMguSQHk3BF4BTmAMAHNA0
UdIVYbjG0htOXXGFFOARdEhgWSixxnomXAGDBB9kEIEgCggxy47K9JADG0ooAWZd4+zwGBlOsFEF
EVMggAAZRIQxxhu5xKABFFBcgcUbUwDIzEomkXEFemV4egVVTymBS6hQNIHTIe14OAgPLEzQQCF2
shbUMUqIYQqPwREBxnoxPAFFCpNaEYQgDyIQhix/WXAoF70RQVWvUC6gWS1PEcGGgyyhwkoIhoyF
51kz9EDGLszxmO2qHx4qhDgoEoISIbmEEe0gM/0277qDrOStYIcgxiOyDQHK2HbsQoDQgsq4CMC8
g4xir7+C+Yj3sG9uIdyvXdoAbIjADRN8FY8Q5PInADFY0UQKKUBhBWrApVAyLutZoBm0FPemL8bZ
6gqcLFv824YhIID8BEhlfFpEDwb3pkUaMzih2RUILJBpE07kcMUSHCoBBRg59JALf/dWjLEg+27n
aw9gVMruKogB4IAXiKVg6iypOrErkswsQAYUeJMhTWZ3i4biG3dTmYLZnuk8SNqylITLyZXEQkQb
McACFHAxcMihCB6CCLMgItygxg0kErJADFEc8ZA6M2Dxw+uCbBiZZMQNAuE82fYQAxeoq3LBDsQX
b/wOF7DXHL/KN/+ZBYC/7fz02SDQ+XrUZ698IAA7
}


	## Check if the window exists
  #if {[winfo exists $BPF::topGui]} {wm deiconify $BPF::topGui;return}
		if {[molinfo top] == -1} {
			tk_messageBox -message "Please Load a Structure First" -type ok
		} else {
			set BPF::topLayer [molinfo top]
		}
	if {[winfo exists $BPF::topGui] != 1} {
		toplevel $BPF::topGui
	}
	grid columnconfigure $BPF::topGui 0 -weight 2

	## Title of the windows
  wm title $BPF::topGui "Chem-Path-Tracker" ;# titulo da pagina

	wm protocol $BPF::topGui WM_DELETE_WINDOW {
    BPF::resetBtt
    wm withdraw $BPF::topGui
  }




	## Image Label
  grid [frame $BPF::topGui.f0 -bg black -height 30] -row 0 -column 0 -sticky ew
  image create photo BPF::logo -data $logo
  pack [label $BPF::topGui.f0.logo -bg black -image BPF::logo ] -side right

	grid [ttk::frame $BPF::topGui.fbtload] -row 1 -column 0 -sticky ew -padx 2 -pady 4
	grid columnconfigure $BPF::topGui.fbtload 1 -weight 1

	grid [ttk::button  $BPF::topGui.fbtload.btLoad -text "Load" -command {BPF::LoadBtt} -padding "2 0 2 0"] -row 0 -column 0 -sticky w -padx 2
	grid [ttk::entry  $BPF::topGui.fbtload.entLoad] -row 0 -column 1 -sticky we

	## NoteBook

  grid [ttk::notebook $BPF::topGui.nb] -row 2 -column 0 -sticky news
	grid columnconfigure $BPF::topGui.nb 0 -weight 2
  ttk::frame $BPF::topGui.nb.f1
	grid columnconfigure $BPF::topGui.nb.f1 0 -weight 1
	ttk::frame $BPF::topGui.nb.f2
	grid columnconfigure $BPF::topGui.nb.f2 0 -weight 1
	grid rowconfigure $BPF::topGui.nb.f2 0 -weight 1
	ttk::frame $BPF::topGui.nb.f3
	grid columnconfigure $BPF::topGui.nb.f3 0 -weight 1
	grid rowconfigure $BPF::topGui.nb.f3 0 -weight 1
	$BPF::topGui.nb add $BPF::topGui.nb.f1 -text "Input" -sticky news
	$BPF::topGui.nb add $BPF::topGui.nb.f2 -text "Output"  -sticky news
	$BPF::topGui.nb add $BPF::topGui.nb.f3 -text "About"  -sticky news


		## Tab 1

		## Frame 1

	grid [ttk::frame $BPF::topGui.nb.f1.f1] -row 2 -column 0 -stick news -pady 5
	grid columnconfigure $BPF::topGui.nb.f1.f1 1 -weight 1

		####FRAME Dynamics
	grid [ttk::frame $BPF::topGui.nb.f1.fdyn] -row 1 -column 0 -stick news -pady 2
	grid columnconfigure $BPF::topGui.nb.f1.fdyn 0 -weight 2
		if {[molinfo top] != -1} {
			set max [molinfo [molinfo top] get numframes]
			if {$max == 0} {
				set max 1
			}
		} else {
			set max 1
		}
	grid [ttk::labelframe $BPF::topGui.nb.f1.fdyn.fs -text "Dynamic Analysis"] -column 0 -row 1 -sticky nwe -pady 4
	grid columnconfigure $BPF::topGui.nb.f1.fdyn.fs 0 -weight 1; grid rowconfigure $BPF::topGui.nb.f1.fdyn.fs 0 -weight 2
	grid columnconfigure $BPF::topGui.nb.f1.fdyn.fs 1 -weight 1
	grid columnconfigure $BPF::topGui.nb.f1.fdyn.fs 2 -weight 1

	set frs $BPF::topGui.nb.f1.fdyn.fs
	grid [ttk::label $frs.lfrom -text "From"] -column 0 -row 0 -padx 5 -pady 2 -sticky w
	grid [spinbox $frs.spfrom -increment 1 -width 8 -command {
		BPF::spinfrom
		if {[molinfo top] != -1} {
			molinfo [molinfo top] set frame [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
			$BPF::topGui.nb.f1.f1.buttonSP invoke
			BPF::highlight 1 [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
		}

	}] -column 1 -row 0 -padx 2 -sticky we -pady 2
	grid [ttk::label $frs.frto -text "To"] -column 2 -row 0 -padx 5 -pady 2 -sticky w
	grid [spinbox $frs.spto -increment 1 -width 8 -command BPF::spinfrom] -column 3 -row 0 -padx 2 -pady 2 -sticky we
	grid [ttk::label $frs.lbstep -text "Step"] -column 4 -row 0 -padx 5 -pady 2 -sticky e
	grid [spinbox $frs.spstep -increment 1 -width 8] -column 5 -row 0 -padx 2 -pady 2 -sticky e

	if {$max == 1} {
		$frs.spfrom configure -from 0
		$frs.spfrom configure -to 1
		$frs.spto configure -from 0
		$frs.spto configure -to 1
		$frs.spstep configure -from 0
		$frs.spstep configure -to 1
		$frs.spfrom set 0
		$frs.spto set 1
		$frs.spstep set 1
	} else {
		$frs.spfrom configure -to [expr $max -1]
		$frs.spfrom configure -from 0
		$frs.spto configure -to [expr $max -1]
		$frs.spto configure -from 0
		$frs.spstep configure -to $max
		$frs.spstep configure -from 1
		$frs.spto set [expr $max -1]
		$frs.spstep set 1
	}


	grid [ttk::label $BPF::topGui.nb.f1.f1.textSP -text "Starting point :" ]  -row 0 -column 0 -stick w
	grid [ttk::entry $BPF::topGui.nb.f1.f1.entrySP -textvariable BPF::startpoint]  -row 0 -column 1 -sticky we -padx 10
	$BPF::topGui.nb.f1.f1.entrySP delete 0 end
	set BPF::startpoint "index 1"
	grid [ttk::button $BPF::topGui.nb.f1.f1.buttonSP -text "Highlight " -width 8 -command {BPF::highlightStartPoint [$BPF::topGui.nb.f1.fdyn.fs.spfrom get] 1} -padding "2 0 2 0"] -row 0 -column 2 -padx 10

	grid [ttk::label $BPF::topGui.nb.f1.f1.textCOff -text "Distance Cut-Off :" ] -row 1 -column 0 -stick w
	grid [spinbox $BPF::topGui.nb.f1.f1.entryCoff -textvariable BPF::distcutoff -from 1 -to 100 -width 5 -increment 0.1 ] -row 1 -column 1 -sticky w -padx 10


	grid [ttk::label $BPF::topGui.nb.f1.f1.textColor -text "Path Color :" ] -row 2 -column 0 -stick w


		# find out what color corresponds to which id:
	set colors {"Percentage" "Off"}
	foreach color [colorinfo colors] {
		set colors [lappend colors $color]
	}


	grid [ttk::combobox $BPF::topGui.nb.f1.f1.cb -values $colors] -row 2 -column 1 -sticky nws -padx 10

	bind $BPF::topGui.nb.f1.f1.cb <<ComboboxSelected>> BPF::chagePath
	$BPF::topGui.nb.f1.f1.cb set Percentage



	## Frame 2

	grid [ttk::frame $BPF::topGui.nb.f1.f20] -row 3 -column 0 -stick nws
	grid [ttk::label $BPF::topGui.nb.f1.f20.label -text " Data points :"] -row 0 -column 0 -sticky nw -pady 5



	grid [ttk::frame $BPF::topGui.nb.f1.f20.lb] -row 1 -column 0 -sticky ew
	grid columnconfigure $BPF::topGui.nb.f1.f20.lb 3 -weight 2
	grid [ttk::label $BPF::topGui.nb.f1.f20.lb.textSelC -text " Color" -width 5 -justify center] -row 1 -column 0
	grid [ttk::label $BPF::topGui.nb.f1.f20.lb.textSel2 -text " Opt" -width 5 -justify center] -row 1 -column 1
	grid [ttk::label $BPF::topGui.nb.f1.f20.lb.textSel3 -text "Selections" -justify left] -row 1 -column 2


        	## Frame 3
	grid [ttk::frame $BPF::topGui.nb.f1.f2] -row 4 -column 0 -sticky news
	grid columnconfigure $BPF::topGui.nb.f1.f2 0 -weight 1; grid rowconfigure $BPF::topGui.nb.f1.f2 0 -weight 1
			## ScrollBox_1
	grid [ttk::scrollbar $BPF::topGui.nb.f1.f2.sb -command {BPF::scrollview}] -row 0 -column 1 -sticky ens

	grid [ttk::frame $BPF::topGui.nb.f1.f2.frmlist] -row 0 -column 0 -sticky nesw
	grid columnconfigure $BPF::topGui.nb.f1.f2.frmlist 2 -weight 2; grid rowconfigure $BPF::topGui.nb.f1.f2.frmlist 1 -weight 1
	#ListBox_Color
	grid [listbox $BPF::topGui.nb.f1.f2.frmlist.lbc -width 5 -relief flat -selectbord 0 -highlightt 0\
				-bd 0 -exportselection 0 -selectmode single -selectforeground cyan -yscrollcommand {BPF::listboxset}] -row 1 -column 0 -sticky nse -padx 3

	## ListBox_1
	grid [listbox $BPF::topGui.nb.f1.f2.frmlist.lb2 -width 3 -relief flat -selectbord 0 -highlightt 0\
				-bd 0 -exportselection 0 -selectmode single -selectbackground cyan -selectforeground black -yscrollcommand {BPF::listboxset}] -row 1 -column 1 -sticky nsw -padx 3

	## ListBox_2
	grid [listbox $BPF::topGui.nb.f1.f2.frmlist.lb3 -relief flat -selectbord 0 -highlightt 0\
				-bd 0 -exportselection 0 -selectmode single -selectbackground cyan -selectforeground black -yscrollcommand {BPF::listboxset}] -row 1 -column 2 -sticky nwes -padx 3


	## Bindings

	bind $BPF::topGui.nb.f1.f2.frmlist.lbc <<ListboxSelect>> {$BPF::topGui.nb.f1.f2.frmlist.lbc itemconfigure [$BPF::topGui.nb.f1.f2.frmlist.lbc cursel] -selectbackground [$BPF::topGui.nb.f1.f2.frmlist.lbc itemcget [$BPF::topGui.nb.f1.f2.frmlist.lbc cursel] -background]}

	bind $BPF::topGui.nb.f1.f2.frmlist.lb2 <<ListboxSelect>> { BPF::synchrolistbox $BPF::topGui.nb.f1.f2.frmlist.lb2 $BPF::topGui.nb.f1.f2.frmlist.lb3 }

	bind $BPF::topGui.nb.f1.f2.frmlist.lb3 <<ListboxSelect>> { BPF::synchrolistbox $BPF::topGui.nb.f1.f2.frmlist.lb3 $BPF::topGui.nb.f1.f2.frmlist.lb2 }



	## Frame 3

	grid [ttk::frame $BPF::topGui.nb.f1.f3] -row 5 -column 0 -sticky news -pady 10

	set options ""
	foreach x $BPF::selectData {set options [lappend options [lindex $x 0] ]}
	grid [ttk::label $BPF::topGui.nb.f1.f3.lb3 -text " Predefined Selection :" ] -row 0 -column 0 -stick news
	grid [ttk::combobox $BPF::topGui.nb.f1.f3.cb2 -values $options] -row 0 -column 1 -sticky news


	$BPF::topGui.nb.f1.f3.cb2 set [lindex $options 0]
	bind $BPF::topGui.nb.f1.f3.cb2 <<ComboboxSelected>> BPF::combo




	## Frame 4

	grid [ttk::frame $BPF::topGui.nb.f1.f4] -row 6 -column 0 -sticky news
	grid columnconfigure $BPF::topGui.nb.f1.f4 2 -weight 3; grid rowconfigure $BPF::topGui.nb.f1.f4 2 -weight 3

	grid [ttk::label $BPF::topGui.nb.f1.f4.lb1 -text " Selection Details :" ] -row 0 -column 0 -sticky w


	grid [ttk::label $BPF::topGui.nb.f1.f4.lb3 -text "Custom Sel :" ] -row 0 -column 1 -stick w
	grid [ttk::entry $BPF::topGui.nb.f1.f4.ent] -row 0 -column 2 -sticky ew

	grid [ttk::label $BPF::topGui.nb.f1.f4.lb4 -text "Type of Sel :" ] -row 1 -column 1
	grid [ttk::combobox $BPF::topGui.nb.f1.f4.cb -width 8 -values "Avg Pt"] -row 1 -column 2 -sticky w

	$BPF::topGui.nb.f1.f4.cb set Avg

	# Bindings


	bind $BPF::topGui.nb.f1.f4.ent <1> {$BPF::topGui.nb.f1.f3.cb2 current 0}
	bind $BPF::topGui.nb.f1.f4.cb <1> {$BPF::topGui.nb.f1.f3.cb2 current 0}




## Frame 5

	grid [ttk::frame $BPF::topGui.nb.f1.f5] -row 7 -column 0 -sticky nes -pady 2

	## buttons Add Delete Edit Highlight
	grid [ttk::button $BPF::topGui.nb.f1.f5.button_Add -text "Add" -width 6 \
				-command {BPF::add end [$BPF::topGui.nb.f1.f4.ent get] [$BPF::topGui.nb.f1.f4.cb get] 0}] -row 1 -column 0  -sticky w -padx 3
	grid [ttk::button $BPF::topGui.nb.f1.f5.button_Delete -text "Delete" -width 6 -command {BPF::delete}] -row 1 -column 1 -sticky w -padx 3
	grid [ttk::button $BPF::topGui.nb.f1.f5.button_Edit -text "Modify" -width 6 -command {BPF::modify}] -row 1 -column 2 -sticky w -padx 3

##Progress Bar
	grid [ttk::frame $BPF::topGui.nb.f1.fpg] -row 8 -column 0 -sticky news -pady 2
	grid columnconfigure $BPF::topGui.nb.f1.fpg 0 -weight 1
	grid [ttk::progressbar $BPF::topGui.nb.f1.fpg.pg -mode determinate] -column 0 -row 0 -sticky news -pady 2

  ## Bottom Frame
  grid [ttk::frame $BPF::topGui.fb] -row 3 -column 0 -sticky news -pady 0
	grid columnconfigure $BPF::topGui.fb 0 -weight 1
	## buttons Exit and Calculate

	grid [ttk::button $BPF::topGui.fb.button_Calculate -text "Calculate" -padding "4 2 4 2" -command {
		if {[molinfo top] != -1} {
			BPF::Run
			molinfo [molinfo top] set frame [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
			BPF::highlight 1 [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
		}
	}] -row 0 -column 0 -pady 5 -padx 4 -sticky e

	grid [ttk::button $BPF::topGui.fb.button_Save -text "Save" -padding "4 2 4 2"  -command {BPF::SaveBtt}] -row 0 -column 1 -pady 5 -padx 4 -sticky e
	grid [ttk::button $BPF::topGui.fb.button_Reset -text "Reset" -padding "4 2 4 2"  -command {
		BPF::resetBtt
		BPF::path
				}] -row 0 -column 2 -pady 5 -padx 4 -sticky e
	## Weights
	grid columnconfigure $BPF::topGui.nb.f1.f3 1 -weight 1
	grid columnconfigure $BPF::topGui.nb.f1.f4 2 -weight 1

	#Create or Search for the PathLayer
	grid [ttk::frame $BPF::topGui.nb.f2.frmP] -row 0 -column 0 -sticky nswe
	grid columnconfigur $BPF::topGui.nb.f2.frmP 0 -weight 1
	grid rowconfigur $BPF::topGui.nb.f2.frmP 0 -weight 1

	#grid columnconfigur $BPF::topGui.nb.f2.frmP 1 -weight 2
	#grid rowconfigur $BPF::topGui.nb.f2.frmP 1 -weight 2

	grid [ttk::frame $BPF::topGui.nb.f2.frmP.frmLoad] -row 0 -column 0 -sticky nswe -pady 4 -padx 2
	grid columnconfigur $BPF::topGui.nb.f2.frmP.frmLoad 0 -weight 1


	grid [ttk::frame $BPF::topGui.nb.f2.frmP.frmTable] -row 0 -column 0 -sticky nswe
	grid columnconfigur $BPF::topGui.nb.f2.frmP.frmTable 0 -weight 1
	grid rowconfigur $BPF::topGui.nb.f2.frmP.frmTable 0 -weight 1

	BPF::outPutFrame $BPF::topGui.nb.f2.frmP.frmTable
	BPF::buildAboutFrame $BPF::topGui.nb.f3

}

proc BPF::resetBtt {} {
	$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb selection clear 0 end
	BPF::tablelistOUT $BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb
	destroy $BPF::topGui
	array unset BPF::cost; array set BPF::cost ""
	array unset BPF::prev; array set BPF::prev ""
	array unset BPF::vertex; array set BPF::vertex ""
	array unset BPF::edge; array set BPF::edge ""
	array unset BPF::point_dyn; array set BPF::point_dyn ""
	array unset BPF::point_frm; array set BPF::point_frm ""
	array unset BPF::point_dist; array set BPF::point_dist ""
	array unset BPF::point_coor; array set BPF::point_coor ""
	set BPF::startSelection ""
	set BPF::distcutoff 10
	set BPF::startpoint "index 1"
	set BPF::pathLayer ""
	set BPF::outPath ""
	set BPF::topLayer ""
	set BPF::barLayer ""
	set BPF::iniRep ""
	if {[molinfo top] != -1} {
		set BPF::repId [molinfo [molinfo top] get numreps]
	} else {
		set BPF::repId -1
	}

	set BPF::outRep ""
	set BPF::resRep ""
	set BPF::point_pair ""


}

proc BPF::SaveBtt {} {
	if {[molinfo top] != -1} {
		if {[file exists $BPF::outPut] ==1 } {
				file delete $BPF::outPut
		}
        set types {
		    {{CPT}  {.cpt}  }
            {{All}  {*}     }
		}
		set fil ""
		set fil [tk_getSaveFile -title "Save Data:" -filetypes $types -defaultextension ".cpt"]
		if {$fil != ""} {
			set BPF::outPath [file dirname $fil]
				set BPF::outPut [open "$fil" w+]
			puts $BPF::outPut "[string repeat = 4] INPUT PARAMETERS [string repeat = 150]"

			puts $BPF::outPut "\n# Dynamics analysis:"
			puts $BPF::outPut "FROM: [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]"
			puts $BPF::outPut "TO: [$BPF::topGui.nb.f1.fdyn.fs.spto get]"
			puts $BPF::outPut "STEP: [$BPF::topGui.nb.f1.fdyn.fs.spstep get]\n"
			puts $BPF::outPut "# Starting point:\n$BPF::startpoint\n"
			puts $BPF::outPut "# Cut-Off:\n[$BPF::topGui.nb.f1.f1.entryCoff get]\n"
			puts $BPF::outPut "# Data Points:\n"
			puts $BPF::outPut [string repeat _ 110]
			puts $BPF::outPut "Opt\tSelection"
			puts $BPF::outPut [string repeat _ 110]
			for {set a 0} {$a < [$BPF::topGui.nb.f1.f2.frmlist.lb2 size]} {incr a} {
				set opt [string trim [$BPF::topGui.nb.f1.f2.frmlist.lb2 get $a] " "]
				set sel [string trim [$BPF::topGui.nb.f1.f2.frmlist.lb3 get $a] " "]
				puts $BPF::outPut "$opt\t$sel"
			}
			puts $BPF::outPut "[string repeat _ 110]"
		} else {
			return no
		}
	}
}

proc BPF::LoadBtt {} {
	if {[molinfo top] != -1} {
		set types {
			{{CPT}  {.cpt}  }
           	{{All}  {*}     }
		}
		set outFile [tk_getOpenFile -filetypes $types]
		if {$outFile != ""} {
			if {[$BPF::topGui.nb.f1.f2.frmlist.lb2 size] != 0} {
				BPF::resetBtt
				BPF::path
			}
			$BPF::topGui.fbtload.entLoad delete 0 end
			$BPF::topGui.fbtload.entLoad insert end $outFile
			set fil [open $outFile r+]
			set stop 0
			$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb configure -state normal
			$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb delete 0 end
			while {[eof $fil] != 1 } {
				set linha [gets $fil]
				if {$stop != 1} {
					if {[string range $linha 0 4] == "FROM:"} {
						set linha [split $linha " "]
						$BPF::topGui.nb.f1.fdyn.fs.spfrom set [string trim [lindex $linha 1] " "]
						molinfo [molinfo top] set frame [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
					} elseif {[string range $linha 0 2] == "TO:"} {
						set linha [split $linha " "]
						$BPF::topGui.nb.f1.fdyn.fs.spto set [string trim [lindex $linha 1] " "]
					} elseif {[string range $linha 0 4] == "STEP:"} {
						set linha [split $linha " "]
						$BPF::topGui.nb.f1.fdyn.fs.spstep set [string trim [lindex $linha 1] " "]
					} elseif {[string range $linha 0 16] == "# Starting point:"} {
						set linha [gets $fil]
						$BPF::topGui.nb.f1.f1.entrySP delete 0 end
						$BPF::topGui.nb.f1.f1.entrySP insert end [string trim $linha " "]
						set BPF::startpoint [string trim [string trim $linha " "] " "]
					} elseif {[string range $linha 0 9] == "# Cut-Off:"} {
						set linha [gets $fil]
						$BPF::topGui.nb.f1.f1.entryCoff set [string trim $linha " "]
					} elseif {[string range $linha 0 13] == "# Data Points:"} {
						set i 0
						while {$i <= 1} {
							set linha [gets $fil]
							if {$linha == [string repeat "_" 110]} {
								incr i
							}
						}
						set linha [gets $fil]
						set i 0
						while {$linha != [string repeat "_" 110]} {
							set linha [split $linha "\t"]
							$BPF::topGui.nb.f1.f2.frmlist.lb2 insert $i [lindex $linha 0]
							$BPF::topGui.nb.f1.f2.frmlist.lb3 insert $i [lindex $linha 1]
							set linha [gets $fil]
							incr i
						}
						BPF::highlight 4 [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
						set startingpointcoordr [BPF::highlightStartPoint [$BPF::topGui.nb.f1.fdyn.fs.spfrom get] 1]
						set BPF::vertex(1) [lrange $startingpointcoordr 0 2]
						set BPF::vertex(1,0) [lindex $startingpointcoordr 3]
						set BPF::vertex(1,1) 100
						set stop 1
					}
				} else {
					if {$linha == [string repeat "_" 110]} {
						set linha [gets $fil]
						while {$linha != [string repeat "_" 110]} {
							set linha [gets $fil]
						}
						set linha [gets $fil]
						while {$linha != [string repeat "_" 110]} {
							$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb insert end $linha
							set linha [split $linha "\t"]
							set clor ""
							if {[$BPF::topGui.nb.f1.f1.cb get] == "Percentage"} {
								set max [expr [colorinfo max] - [colorinfo num] -1]
								set clor [expr round([expr 100 - [lindex $linha 6]] * $max)/ 100]
								set clor [expr $clor + [colorinfo num]]
							} else {
								set clor [$BPF::topGui.nb.f1.f1.cb get]
							}
							graphics $BPF::pathLayer color $clor
							set BPF::outFind [lappend BPF::outFind [graphics $BPF::pathLayer line $BPF::vertex([string trimleft [lindex $linha 0] " "]) $BPF::vertex([string trimleft [lindex $linha 2] " "])  width 4]]
							set linha [gets $fil]
						}
						if {[$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 2 -text] != ""} {
							set i 0
							set lis_aux ""
							set lis [lappend lis [join [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 2 -text]] [join [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 0 -text]]]
							set lis [join $lis]
							while {$i < [llength $lis]} {
								if {[lsearch $lis_aux [lindex $lis $i]] == -1 } {
									set lis_aux [lappend lis_aux [lindex $lis $i]]
								}
								incr i
							}
							$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbto configure -values [lsort -real $lis_aux]
							$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbfrom configure -values [lsort -real $lis_aux]
						}
					}
				}
			}

		}
	}
}

proc BPF::outPutFrame {frame} {

	grid [ttk::frame $frame.f1 ] -row 0 -column 0 -sticky news -padx 2 -pady 2
	grid columnconfigure $frame.f1 0 -weight 1
	grid rowconfigure $frame.f1 0 -weight 2

	grid [ttk::frame $frame.f1.frmlist] -row 0 -column 0 -sticky nesw
	grid rowconfigure $frame.f1.frmlist 0 -weight 2
	grid columnconfigure $frame.f1.frmlist 0 -weight 1

	set fro2 $frame.f1.frmlist
	option add *Tablelist.activeStyle       frame
	option add *Tablelist.background        gray98
	option add *Tablelist.stripeBackground  #e0e8f0
	#option add *Tablelist.setGrid           yes
	option add *Tablelist.movableColumns    yes
	option add *Tablelist.labelCommand      tablelist::sortByColumn


    	tablelist::tablelist $fro2.tb \
		-columns { 0 "Point1"	 center
				0 "Res1"	 center
				0 "Point2"     center
				0 "Res2" 	 center
				0 "DistMean(Å)"	 center
				0 "STDV(Å)" center
				0 "Perc(%)" center} \
                -yscrollcommand [list $fro2.scr1 set] -xscrollcommand [list $fro2.scr2 set] \
                -showseparators 0 -labelrelief groove  -labelbd 1 -selectbackground cyan -selectforeground black\
                -foreground black -background white -state disable -selectmode multiple -stretch "0 2 4 6" -movablecolumns false

	$fro2.tb columnconfigure 0 -sortmode real -name "Point1"
	$fro2.tb columnconfigure 1 -sortmode dictionary -name "Res1"
	$fro2.tb columnconfigure 2 -sortmode real -name "Point2"
	$fro2.tb columnconfigure 3 -sortmode dictionary -name "Res2"
	$fro2.tb columnconfigure 4 -sortmode real -name "DistMean Å"
	$fro2.tb columnconfigure 5 -sortmode real -name "STDV(Å)"
	$fro2.tb columnconfigure 6 -sortmode real -name "Perc(%)"

	grid $fro2.tb -row 0 -column 0 -sticky news
	grid columnconfigure $fro2.tb 0 -weight 1; grid rowconfigure $fro2.tb 0 -weight 1

	##Scrool_BAr V
	scrollbar $fro2.scr1 -orient vertical -command [list $fro2.tb  yview]
  grid $fro2.scr1 -row 0 -column 1  -sticky ens

	## Scrool_Bar H
	scrollbar $fro2.scr2 -orient horizontal -command [list $fro2.tb xview]
	grid $fro2.scr2 -row 1 -column 0 -sticky swe

	bind [$fro2.tb bodytag] <ButtonRelease> {
		BPF::tablelistOUT $BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb
	}

	grid [ttk::labelframe $frame.f1.srch -text "Path Highlight"]  -row 2 -column 0 -sticky wnse -pady 2
	grid columnconfigure $frame.f1.srch 1 -weight 1
	grid columnconfigure $frame.f1.srch 3 -weight 1

	grid [ttk::label $frame.f1.srch.lbindex -text "Index: "] -row 0 -column 0 -sticky we -padx 4
	grid [ttk::label $frame.f1.srch.lbfrom -text "From: "] -row 1 -column 0 -sticky we -padx 4
	grid [ttk::combobox $frame.f1.srch.cmbfrom -width 4 ] -row 1 -column 1 -sticky we -pady 2

	grid [ttk::label $frame.f1.srch.lbto -text "To" -padding "6 0 0 0"] -row 1 -column 2 -sticky we -pady 2
	grid [ttk::combobox $frame.f1.srch.cmbto -width 4 ] -row 1 -column 3 -sticky we -pady 2

	grid [ttk::button $frame.f1.srch.but -text "Highlight" -padding "2 0 2 0" -command BPF::buttonFind] -row 1 -column 4 -sticky e -padx 4

	grid [ttk::checkbutton $frame.f1.chpoint -text "Show Points" -command {BPF::showPoints} -variable BPF::points -onvalue 1] -row 3 -column 0 -sticky w -padx 2

}

proc BPF::buttonFind {} {
	set i 0
		set size [expr [array size BPF::pFind] /2]
		if {$size != 0} {
			while {$i <= $size} {
				if {[winfo exists $BPF::guiFind$i] != 1} {
					BPF::showFind $i

					break
				}
				incr i
			}
		} else {
			BPF::showFind $i
		}
}

proc BPF::chagePath {} {
	set i 0
	while {$i < [llength $BPF::outFind]} {
		graphics $BPF::pathLayer delete [lindex $BPF::outFind	$i]
		incr i
	}
	if {[$BPF::topGui.nb.f1.f1.cb get] != "Off"} {
		set index1 [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 0 -text]
		set index2 [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 2 -text]
		set percAll [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 6 -text]
		set i 0
		while {$i < [llength $index1]} {
			set ind1 [lindex $index1 $i]
			set ind2 [lindex $index2 $i]
			set perc [lindex $percAll $i]
			if {[$BPF::topGui.nb.f1.f1.cb get] == "Percentage"} {
				set max [expr [colorinfo max] - [colorinfo num] -1]
				set clor [expr round([expr 100 - $perc] * $max)/ 100]
				set clor [expr $clor + [colorinfo num]]
			} else {
				set clor [$BPF::topGui.nb.f1.f1.cb get]
			}

			graphics $BPF::pathLayer color $clor
			set BPF::outFind [lappend BPF::outFind [graphics $BPF::pathLayer line $BPF::vertex($ind1) $BPF::vertex($ind2) width 4]]
			incr i
		}
	}
}


proc BPF::chageFindPath {win} {

	set wnds [string range [lindex [split $win "."] 1] 4 end]

	set i 0
	while {$i < [llength $BPF::pFind($wnds,graph)]} {
		graphics $BPF::pathLayer delete [lindex $BPF::pFind($wnds,graph) $i]
		incr i
	}
	if {[$win get] != "Off"} {
		set i 0
		set pair $BPF::pFind($wnds,path)
		while {$i < [llength $pair]} {
			graphics $BPF::pathLayer color [$win get]
			set BPF::pFind($wnds,graph) [lappend BPF::pFind($wnds,graph) [graphics $BPF::pathLayer line $BPF::vertex([lindex [lindex $pair $i] 0]) $BPF::vertex([lindex [lindex $pair $i] 1]) width 4]]
			incr i
		}

	}
}

proc BPF::showFind {wind} {
	if {[$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbfrom get] != [$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbto get] && [string trim [$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbto get] " "]!= ""} {
			set pair [BPF::findPath [$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbfrom get] [$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbto get]]

			#BPF::delgraph
			set i 0
			if {[winfo exists $BPF::guiFind$wind]} {wm deiconify $BPF::guiFind$wind;return}
			toplevel $BPF::guiFind$wind

			wm protocol $BPF::guiFind$wind WM_DELETE_WINDOW {
				set wnds [focus]
				set wnds [string range [lindex [split $wnds "."] 1] 4 end]
				if {$wnds != ""} {

					set i 0
					while {$i < [llength $BPF::pFind($wnds,graph)]} {
						graphics $BPF::pathLayer delete [lindex $BPF::pFind($wnds,graph)	$i]
						incr i
					}
					set BPF::pFind($wnds,graph) ""
					set BPF::pFind($wnds,path) ""
					destroy ".find$wnds"
				}
			}
			## Title of the windows
			wm title $BPF::guiFind$wind "Shortest Partial Path from index [$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbfrom get] to \
						[$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbto get]" ;# titulo da pagina

			grid rowconfigure $BPF::guiFind$wind 0 -weight 1
			grid columnconfigure $BPF::guiFind$wind 0 -weight 1

			set wnds $BPF::guiFind$wind

			set BPF::pFind([string range $wnds 5 end],path) $pair

			grid [ttk::frame $wnds.fp] -row 0 -column 0 -sticky news
			grid rowconfigure $wnds.fp 1 -weight 1
			grid columnconfigure $wnds.fp 0 -weight 1

			grid [ttk::frame $wnds.fp.findex] -row 0 -column 0 -sticky news
			grid columnconfigure $wnds.fp 0 -weight 1
			#grid columnconfigure $wnds.fp 1 -weight 1
			grid [ttk::label $wnds.fp.findex.lb -text "Path Color "] -row 0 -column 0 -sticky ew -padx 2 -pady 4

			foreach color [colorinfo colors] {
				set colors [lappend colors $color]
			}
			set colors [lappend colors "Off"]

			grid [ttk::combobox $wnds.fp.findex.cb -values $colors -width 10 -state readonly] -row 0 -column 1 -sticky w -padx 2 -pady 2
			$wnds.fp.findex.cb current [string range $wnds 5 end]


			bind $wnds.fp.findex.cb <<ComboboxSelected>> {BPF::chageFindPath [focus]}



			grid [ttk::frame $wnds.fp.ftmtb] -row 1 -column 0 -sticky nsew -ipadx 2
			grid rowconfigure $wnds.fp.ftmtb 0 -weight 1
			grid columnconfigure $wnds.fp.ftmtb 0 -weight 1
			set fro2 $wnds.fp.ftmtb
		option add *Tablelist.activeStyle       frame
		option add *Tablelist.background        gray98
		option add *Tablelist.stripeBackground  #e0e8f0
		#option add *Tablelist.setGrid           yes
		option add *Tablelist.labelCommand      tablelist::sortByColumn


				tablelist::tablelist $fro2.tb \
			-columns { 0 "Point1"	 center
					0 "Res1"	 center
					0 "Point2"     center
					0 "Res2" 	 center
					0 "DistMean(Å)"	 center
					0 "STDV(Å)" center
					0 "Perc(%)" center} \
									-yscrollcommand [list $fro2.scr1 set] \
									-showseparators 0 -labelrelief groove -selectbackground cyan -selectforeground black\
									-foreground black -background white -selectmode multiple -stretch "0 2 4 6" -movablecolumns false -height 3

		$fro2.tb columnconfigure 0 -sortmode real -name "Point1"
		$fro2.tb columnconfigure 1 -sortmode dictionary -name "Res1"
		$fro2.tb columnconfigure 2 -sortmode real -name "Point2"
		$fro2.tb columnconfigure 3 -sortmode dictionary -name "Res2"
		$fro2.tb columnconfigure 4 -sortmode real -name "DistMean Å"
		$fro2.tb columnconfigure 5 -sortmode real -name "STDV(Å)"
		$fro2.tb columnconfigure 6 -sortmode real -name "Perc(%)"

		grid $fro2.tb -row 0 -column 0 -sticky news
		grid columnconfigure $fro2.tb 0 -weight 1; grid rowconfigure $fro2.tb 0 -weight 1

		##Scrool_BAr V
		scrollbar $fro2.scr1 -orient vertical -command [list $fro2.tb  yview]
		grid $fro2.scr1 -row 0 -column 1  -sticky ens

			bind [$fro2.tb bodytag] <ButtonRelease> {
				set tb [focus]
				BPF::tablelistOUT [string range $tb 0 [expr [string length $tb] - 6]]
			}


		grid [ttk::frame $wnds.fp.frmInfo] -row 2 -column 0 -sticky ew

		grid rowconfigure $wnds.fp.frmInfo 1 -weight 1
		grid rowconfigure $wnds.fp.frmInfo 2 -weight 1
		grid columnconfigure $wnds.fp.frmInfo 0 -weight 1


		grid [ttk::frame $wnds.fp.frmInfo.frmPar] -row 0 -column 0 -sticky ew -padx 2 -pady 2
		grid columnconfigure $wnds.fp.frmInfo.frmPar 0 -weight 1
		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbPART -text "Partial Distances statistics: "] -row 0 -column 0 -sticky w -padx 2

		grid [ttk::frame $wnds.fp.frmInfo.frmPar.lbParLB] -row 1 -column 0 -sticky ew -padx 2 -pady 2

		grid columnconfigure $wnds.fp.frmInfo.frmPar.lbParLB 1 -weight 1
		grid columnconfigure $wnds.fp.frmInfo.frmPar.lbParLB 3 -weight 1
		grid columnconfigure $wnds.fp.frmInfo.frmPar.lbParLB 5 -weight 1
		grid columnconfigure $wnds.fp.frmInfo.frmPar.lbParLB 7 -weight 1

		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbParLB.lbAVG -text "Distance AVG "] -row 0 -column 0 -sticky w -pady 4 -padx 2
		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbParLB.lbAVGVAL -background white -relief sunken -width 7] -row 0 -column 1 -sticky w -padx 2

		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbParLB.lbSTDV -text "Varience "] -row 0 -column 2 -sticky w -pady 4 -padx 2
		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbParLB.lbSTDVAL -background white -relief sunken -width 7] -row 0 -column 3 -sticky w -padx 2

		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbParLB.lbPRB -text "Perc AVG "] -row 0 -column 4 -sticky w -pady 4 -padx 2
		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbParLB.lbPROBVAL -background white -relief sunken -width 7] -row 0 -column 5 -sticky w -padx 2

		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbParLB.lbPercSTDV -text "Perc STDV "] -row 0 -column 6 -sticky w -pady 4 -padx 2
		grid [ttk::label $wnds.fp.frmInfo.frmPar.lbParLB.lbPercSTDVBVAL -background white -relief sunken -width 7] -row 0 -column 7 -sticky w -padx 2

		grid [ttk::frame $wnds.fp.frmInfo.frmTOT] -row 2 -column 0 -sticky ew -padx 2 -pady 2
		grid rowconfigure $wnds.fp.frmInfo.frmTOT 1 -weight 1
		grid columnconfigure $wnds.fp.frmInfo.frmTOT 0 -weight 1

		grid [ttk::label $wnds.fp.frmInfo.frmTOT.lbTOT -text "Total Path statistics: "] -row 0 -column 0 -sticky w -padx 2

		grid [ttk::frame $wnds.fp.frmInfo.frmTOT.frmTOTLB] -row 1 -column 0 -sticky ew -padx 2 -pady 2
		grid columnconfigure $wnds.fp.frmInfo.frmTOT.frmTOTLB 1 -weight 1
		grid columnconfigure $wnds.fp.frmInfo.frmTOT.frmTOTLB 3 -weight 1
		grid columnconfigure $wnds.fp.frmInfo.frmTOT.frmTOTLB 5 -weight 1
		grid columnconfigure $wnds.fp.frmInfo.frmTOT.frmTOTLB 7 -weight 1

		grid [ttk::label $wnds.fp.frmInfo.frmTOT.frmTOTLB.lbAVG -text "Total Distance "] -row 0 -column 0 -sticky w -pady 4 -padx 2
		grid [ttk::label $wnds.fp.frmInfo.frmTOT.frmTOTLB.lbAVGVAL -background white -relief sunken -width 7] -row 0 -column 1 -sticky w -padx 2

		grid [ttk::label $wnds.fp.frmInfo.frmTOT.frmTOTLB.lbSTDV -text "Varience "] -row 0 -column 2 -sticky w -pady 4 -padx 2
		grid [ttk::label $wnds.fp.frmInfo.frmTOT.frmTOTLB.lbSTDVAL -background white -relief sunken -width 7] -row 0 -column 3 -sticky w -padx 2

		grid [ttk::label $wnds.fp.frmInfo.frmTOT.frmTOTLB.lbPRB -text "Perc AVG "] -row 0 -column 4 -sticky w -pady 4 -padx 2
		grid [ttk::label $wnds.fp.frmInfo.frmTOT.frmTOTLB.lbPROBVAL -background white -relief sunken -width 7] -row 0 -column 5 -sticky w -padx 2

		grid [ttk::label $wnds.fp.frmInfo.frmTOT.frmTOTLB.lbPercSTDV -text "Perc STDV "] -row 0 -column 6 -sticky w -pady 4 -padx 2
		grid [ttk::label $wnds.fp.frmInfo.frmTOT.frmTOTLB.lbPercSTDVBVAL -background white -relief sunken -width 7] -row 0 -column 7 -sticky w -padx 2

		set i 0
		set lines ""
		while {$i < [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb size]} {
			set lines [lappend lines [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb rowcget $i -text]]
			incr i
		}
		set i 0
		$wnds.fp.ftmtb.tb delete 0 end
		while {$i < [llength $pair]} {
			graphics $BPF::pathLayer color [$wnds.fp.findex.cb get]
			set BPF::pFind([string range $wnds 5 end],graph) [lappend BPF::pFind([string range $wnds 5 end],graph) [graphics $BPF::pathLayer line $BPF::vertex([lindex [lindex $pair $i] 0]) $BPF::vertex([lindex [lindex $pair $i] 1]) width 4]]
			set st "[lindex [lindex $pair $i] 0] $BPF::vertex([lindex [lindex $pair $i] 0],0) [lindex [lindex $pair $i] 1] $BPF::vertex([lindex [lindex $pair $i] 1],0)"
			set index [lsearch -inline $lines "$st *" ]
			$wnds.fp.ftmtb.tb insert end $index
			incr i
		}
		set dist [$wnds.fp.ftmtb.tb columncget 4 -text]
		set avgDis [::math::statistics::mean $dist]
		set stdvI [::math::statistics::mean [$wnds.fp.ftmtb.tb columncget 5 -text]]
		set i 0
		set stdv ""
		while {$i < [llength $stdvI]} {
			set stdv [lappend stdv [expr [lindex $stdvI $i]*[lindex $stdvI $i] ]]
			incr i
		}
		set varie [expr [::math::sum $stdv]/ [llength $stdv] ]
		set perc [$wnds.fp.ftmtb.tb columncget 6 -text]
		set avgPerc [::math::statistics::mean $perc]
		set stdvPerc [::math::statistics::stdev $perc]
		$wnds.fp.frmInfo.frmPar.lbParLB.lbAVGVAL configure -text [format "%3.2f" $avgDis]
		$wnds.fp.frmInfo.frmPar.lbParLB.lbSTDVAL configure -text [format "%3.2f" $varie]
		$wnds.fp.frmInfo.frmPar.lbParLB.lbPROBVAL configure -text [format "%3.2f" $avgPerc]
		$wnds.fp.frmInfo.frmPar.lbParLB.lbPercSTDVBVAL configure -text [format "%3.2f" $stdv]


		$wnds.fp.frmInfo.frmTOT.frmTOTLB.lbAVGVAL configure -text [format "%3.2f" [expr double($avgDis) * [llength $dist]]]
		$wnds.fp.frmInfo.frmTOT.frmTOTLB.lbSTDVAL configure -text [format "%3.2f" $varie]
		$wnds.fp.frmInfo.frmTOT.frmTOTLB.lbPROBVAL configure -text [format "%3.2f" $avgPerc]
		$wnds.fp.frmInfo.frmTOT.frmTOTLB.lbPercSTDVBVAL configure -text [format "%3.2f" $stdv]
	}
}

proc BPF::showPoints {} {

	set i 0
	while {$i < [llength $BPF::outRep]} {
		if {$BPF::points == 1} {
			mol showrep $BPF::pathLayer [mol repindex $BPF::pathLayer [lindex $BPF::outRep $i]] on
		} else {
			mol showrep $BPF::pathLayer [mol repindex $BPF::pathLayer [lindex $BPF::outRep $i]] off
		}
		incr i
	}

}

proc BPF::spinfrom {} {
	if {[expr [$BPF::topGui.nb.f1.fdyn.fs.spto get] - [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]] > 0} {
		$BPF::topGui.nb.f1.fdyn.fs.spstep configure -to [expr [$BPF::topGui.nb.f1.fdyn.fs.spto get] - [$BPF::topGui.nb.f1.fdyn.fs.spfrom get] +2]

	}
	if {[expr [$BPF::topGui.nb.f1.fdyn.fs.spto get] - [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]] < 0} {
		$BPF::topGui.nb.f1.fdyn.fs.spto set [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
	}
}


#### syncronize listbox

proc BPF::listboxset {args} {
    eval [linsert $args 0 $BPF::topGui.nb.f1.f2.sb set]
    BPF::scrollview moveto [lindex [$BPF::topGui.nb.f1.f2.sb get] 0]
  }



proc BPF::scrollview {args} {
	eval [linsert $args 0 $BPF::topGui.nb.f1.f2.frmlist.lbc yview]
	eval [linsert $args 0 $BPF::topGui.nb.f1.f2.frmlist.lb2 yview]
	eval [linsert $args 0 $BPF::topGui.nb.f1.f2.frmlist.lb3 yview]

}






proc BPF::synchrolistbox {w1 w2} {
	set sel [$w1 cursel]
	if {$sel != ""} {
		$w1 selection clear 0 end
		$w2 selection clear 0 end

		foreach item $sel {
			$w1 selection set $item
			$w2 selection set $item
		}

		$BPF::topGui.nb.f1.f4.ent delete 0 end; $BPF::topGui.nb.f1.f4.ent insert end [$BPF::topGui.nb.f1.f2.frmlist.lb3 get $item]
		$BPF::topGui.nb.f1.f4.cb set [$BPF::topGui.nb.f1.f2.frmlist.lb2 get $item]

	}
}

proc BPF::tablelistOUT {win} {
	set sel [$win curselection]
	if {$sel != ""} {
		set i 0
		while {$i < [llength $BPF::resRep] } {
			if {[mol repindex $BPF::topLayer [string trim [lindex $BPF::resRep $i] " "]] != -1} {
				mol delrep [mol repindex $BPF::topLayer [string trim [lindex $BPF::resRep $i] " "]] $BPF::topLayer
				incr BPF::repId -1
			}
			incr i
		}
		BPF::selectRes $win
	} else {
		set i 0
		while {$i < [llength $BPF::resRep] } {
			if {[mol repindex $BPF::topLayer [string trim [lindex $BPF::resRep $i] " "]] != -1} {
				mol delrep [mol repindex $BPF::topLayer [string trim [lindex $BPF::resRep $i] " "]] $BPF::topLayer
				incr BPF::repId -1
			}
			incr i
		}
	}
}

proc BPF::selectRes {win} {
	set sel1 [$win curselection]
	set i 0

	while {$i < [llength $sel1]} {
		set resIdCh [$win cellcget [lindex $sel1 $i],1 -text]
		set resname1 [string range $resIdCh 0 2]
		set chain1 [string index $resIdCh end]
		set Id1 [string range $resIdCh 3 [expr [string length $resIdCh ] -2]]

		set resIdCh [$win cellcget [lindex $sel1 $i],3 -text]
		set resname2 [string range $resIdCh 0 2]
		set chain2 [string index $resIdCh end]
		set Id2 [string range $resIdCh 3 [expr [string length $resIdCh ] -2]]

		mol selection "(resname $resname1 and chain $chain1 and resid $Id1) or (resname $resname2 and chain $chain2 and resid $Id2)"
		mol representation Licorice
		mol color Name
		mol addrep $BPF::topLayer
		update
		set BPF::resRep [lappend BPF::resRep [mol repname $BPF::topLayer $BPF::repId]]
		incr BPF::repId
		incr i
	}

}
#### Comands ComboBox,  Add, Delete, Modify and Highlight


proc BPF::combo {} {
	foreach item $BPF::selectData {
		if {[lsearch $item [$BPF::topGui.nb.f1.f3.cb2 get] ]==0} {
			$BPF::topGui.nb.f1.f4.ent delete 0 end; $BPF::topGui.nb.f1.f4.ent insert end [lindex $item 3]
			$BPF::topGui.nb.f1.f4.cb set [lindex $item 2]
		}
	}
}


proc BPF::add {pos cmd2 cmd3 frm} {
	if {[molinfo top] != -1} {
		## See if the selection exist
		set sel [atomselect $BPF::topLayer $cmd2 frame $frm]
		if {[$sel get index] ==""} {
			tk_messageBox -message "Custom Selection is not right. \nPlease modify it according to the VMD rules.\n Examples (resname GLU, index 100, etc). " -type ok
			return
		}

		## Add item
		if {[$BPF::topGui.nb.f1.f3.cb2 get] ==  "HBonds"}  {
			set res_aux ""
			set type_aux ""
			set res_list ""
			array set res ""

			foreach type [$sel get type] resname [$sel get resname] {
				if {[info exists res($resname)]== 1} {
					if {[lsearch $res($resname) $type] == -1} {
						lappend res($resname) $type
					}

				} else {
					set res($resname) $type
				}
			}
			set names [array names res]
			for {set i 0} {$i < [array size res]} {incr i} {
				set name [lindex $names $i]
				$BPF::topGui.nb.f1.f2.frmlist.lb3 insert $pos "resname $name and name $res($name)"
				if {[llength $res($name)] > 1} {
					$BPF::topGui.nb.f1.f2.frmlist.lb2 insert $pos "Avg"
				} else {
					$BPF::topGui.nb.f1.f2.frmlist.lb2 insert $pos "Pt"
				}

			}

		} else {
			$BPF::topGui.nb.f1.f2.frmlist.lb3 insert $pos $cmd2
			$BPF::topGui.nb.f1.f2.frmlist.lb2 insert $pos $cmd3
		}



		## select added item

		$BPF::topGui.nb.f1.f2.frmlist.lb2 selection clear 0 end
		$BPF::topGui.nb.f1.f2.frmlist.lb3 selection clear 0 end

		$BPF::topGui.nb.f1.f2.frmlist.lb2 selection set end
		$BPF::topGui.nb.f1.f2.frmlist.lb3 selection set end

		## highlight addition
		set do [BPF::highlight 1 [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]]
		if {$do == 0} {
			$BPF::topGui.nb.f1.f2.frmlist.lbc delete $pos
			$BPF::topGui.nb.f1.f2.frmlist.lb2 delete $pos
			$BPF::topGui.nb.f1.f2.frmlist.lb3 delete $pos
		}

	}
}

proc BPF::delete {} {
	if {[molinfo top] != -1} {
		set ind [$BPF::topGui.nb.f1.f2.frmlist.lb2 curselection]
		if {[$BPF::topGui.nb.f1.f2.frmlist.lb2 curselection]!= ""} {
			$BPF::topGui.nb.f1.f2.frmlist.lb2 selection clear $ind
			$BPF::topGui.nb.f1.f2.frmlist.lb3 selection clear $ind
			if {[$BPF::topGui.nb.f1.f2.frmlist.lb2 size] != 0} {
				$BPF::topGui.nb.f1.f2.frmlist.lbc delete $ind
				$BPF::topGui.nb.f1.f2.frmlist.lb2 delete $ind
				$BPF::topGui.nb.f1.f2.frmlist.lb3 delete $ind
				BPF::resetLayer
				#incr outRep -1
				if {[$BPF::topGui.nb.f1.f2.frmlist.lb2 size] != 0} {
					$BPF::topGui.nb.f1.f2.frmlist.lb2 selection set end
					$BPF::topGui.nb.f1.f2.frmlist.lb3 selection set end
				}
			}
			BPF::highlight 1 [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
		} else {tk_messageBox -message "Please Select or Add a selection first" -type ok}

		#BPF::highlight 0 [molinfo [molinfo top] get frame]
	}
}

proc BPF::modify {} {
	if {[molinfo top] != -1} {
		BPF::resetLayer
		if {[$BPF::topGui.nb.f1.f2.frmlist.lb2 curselection]!= "" } {

			set pos [$BPF::topGui.nb.f1.f2.frmlist.lb2 curselection]
			BPF::delete
			BPF::add $pos [$BPF::topGui.nb.f1.f4.ent get]  [$BPF::topGui.nb.f1.f4.cb get] 0

			$BPF::topGui.nb.f1.f2.frmlist.lb2 selection clear 0 end
			$BPF::topGui.nb.f1.f2.frmlist.lb3 selection clear 0 end

			$BPF::topGui.nb.f1.f2.frmlist.lb2 selection set $pos
			$BPF::topGui.nb.f1.f2.frmlist.lb3 selection set $pos

			 ## highlight addition
			BPF::highlight 1 [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]

		} else {tk_messageBox -message "Please Add some data first" -type ok}

	}
}


proc BPF::highlight {option frm} {
	## reset path
	if {$option == 1 || $option == 2 || $option == 4} {
		BPF::resetLayer
	}

	## read all the selections
	set localdataPoints ""
	set coord ""
	set index 2
	set lis ""
	set selectList ""
	set do 0
	set coordList ""


	for {set a 0} {$a < [$BPF::topGui.nb.f1.f2.frmlist.lb2 size]} {incr a} {
		set st $index
		# get values
		set weight    100
		set selection [$BPF::topGui.nb.f1.f2.frmlist.lb3 get $a]
		set opt       [$BPF::topGui.nb.f1.f2.frmlist.lb2 get $a]

		## draw spheres of the selections

		##  if selection is average
		if {$opt=="Avg"} {
			set coord [BPF::averagePoint $selection $frm]
			set txt [lindex $coord 1]
			set coord [lindex $coord 0]

			set i 0
			if {$option == 1 || $option == 2 || $option == 4} {
				$BPF::topGui.nb.f1.f2.frmlist.lbc delete $a
				$BPF::topGui.nb.f1.f2.frmlist.lbc insert $a ""
				$BPF::topGui.nb.f1.f2.frmlist.lbc itemconfigure $a -background "#[BPF::rgbtoHEX [colorinfo rgb $a]]"
			}
			while {$i < [llength $coord]} {
				set x [lindex $coord $i]
				if {[lsearch $coordList $x] == -1} {
					BPF::addVertex [lindex $x 0] [lindex $x 1] [lindex $x 2] on $a 0.5
					set lis [lappend lis "0.8 AVG [lindex $txt $i] [string range [lindex $txt $i] 0 2] [string index [lindex $txt $i] end] [lindex [lindex $txt $i] 2] $x 0"]
					if {$option == 3 || $option == 4} {
						if {$frm == [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]} {
							set BPF::point_frm($index) [lindex $txt $i]
							set BPF::point_coor($index) $x
						}

						set BPF::vertex($index) $x
						set BPF::vertex($index,0) [lindex $txt $i]
						set BPF::vertex($index,1) $weight

					}
					set coordList [lappend coordList $x]
					incr index
				}

				incr i
			}

		}

		## if selection is standard
		if {$opt=="Pt"} {
			set atomselection [atomselect $BPF::topLayer $selection frame $frm]
			if {$option == 1 || $option == 2 || $option == 4} {
				$BPF::topGui.nb.f1.f2.frmlist.lbc delete $a
				$BPF::topGui.nb.f1.f2.frmlist.lbc insert $a ""
				$BPF::topGui.nb.f1.f2.frmlist.lbc itemconfigure $a -background "#[BPF::rgbtoHEX [colorinfo rgb $a]]"
			}
			foreach resid [$atomselection get resid] resname [$atomselection get resname] coord [$atomselection get {x y z }] chain [$atomselection get chain] {
				if {[lsearch $coordList $coord] == -1} {
					set lis [lappend lis "0.5 Pt $resname$resid$chain $resname $chain $coord 0"]
					BPF::addVertex [lindex $coord 0] [lindex $coord 1] [lindex $coord 2] on $a 0.5
					if {$option == 3 || $option == 4} {
						if {$frm == [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]} {
							set BPF::point_frm($index) $resname$resid$chain
							set BPF::point_coor($index) $coord
						}
						set BPF::vertex($index) $coord
						set BPF::vertex($index,0) $resname$resid$chain
						set BPF::vertex($index,1) $weight
					}
					set coordList [lappend coordList $coord]
					incr index
				}

			}
			unset upproc_var_$atomselection
		}
		if {$index != 2} {
			set selectList [lappend selectList "$st to [expr $index -1]"]
		}

	}
	if {$selectList != "" && $option != 3} {
		set do 1

		set sel [atomselect $BPF::pathLayer "index 2 to [expr $index -1]"]
		$sel set {radius element name resname chain x y z beta} $lis


		unset upproc_var_$sel
		set i 0
		while {$i < [llength $selectList]} {
			if {[lindex $selectList $i] != ""} {
				if {$option == 1 || $option == 2 || $option == 4} {
					mol selection "index [lindex $selectList $i]"
					mol representation CPK
					mol color "ColorID $i"
					mol material "Opaque"
					mol addrep $BPF::pathLayer

				}
				mol top $BPF::topLayer
				update
			}
			incr i

		}
		if {[llength $selectList] == 0} {
			set i 0
			while {$i < [llength $BPF::outRep]} {
					mol delrep [mol repindex v [string trim [lindex $BPF::outRep $i] " "] $BPF::topLayer
					incr BPF::repId -1
				incr i
			}
			set BPF::outRep ""
		}
	}
	update
	return $do
}



proc BPF::rgbtoHEX {rgb} {
	set rgb [split $rgb " "]
	set i 0
	set hex ""
	while {[lindex $rgb $i] != ""} {
		set st ""
		set frst_int [expr int([expr [lindex $rgb $i]*100] /16)]
		if {$frst_int < 10 } {
			set st $frst_int
		} else {
			switch $frst_int {
				10 {
					set st "A"
				}
				11 {
					set st "B"
				}
				12 {
					set st "C"
				}
				13 {
					set st "D"
				}
				14 {
					set st "E"
				}
				15 {
					set st "F"
				}
			}
		}
		set hex [append hex $st]
		set frst_mod [expr int([expr fmod([expr [lindex $rgb $i]*100]  ,16)])]
		if {$frst_mod <10} {
			set st $frst_mod
		} else {
			switch $frst_mod {
				10 {
					set st "A"
				}
				11 {
					set st "B"
				}
				12 {
					set st "C"
				}
				13 {
					set st "D"
				}
				14 {
					set st "E"
				}
				15 {
					set st "F"
				}
			}
		}
		set hex [append hex $st]
		incr i
	}
	return $hex

}





proc BPF::averagePoint  {sel frm} {


	set pointList ""
	set update 0
	set atomselection [atomselect $BPF::topLayer $sel frame $frm]
	set x  [$atomselection get x]
	set y  [$atomselection get y]
	set z  [$atomselection get z]





	set i 0
	set resname [$atomselection get resname]
	set resid [$atomselection get resid]
	set resaux ""
	set residList ""
	set chain [$atomselection get chain]
	set chainaux ""
	set ini ""
	set fin ""
	set txt ""
	set j 0
	while {$i < [llength $resid]} {
		if {[lsearch $residList  "[lindex $resid $i]_[lindex $chain $i]"] ==-1} {
			set ini $i
			set residaux [lindex $resid $i]
			set chainaux [lindex $chain $i]
			set txt [lappend txt "[lindex $resname $i][lindex $resid $i][lindex $chain $i]"]

			while {[lindex $resid $i] == $residaux && [lindex $chain $i] == $chainaux} {
				set residaux [lindex $resid $i]
				set chainaux [lindex $chain $i]
				incr i
			}
			set fin $i
			set minx [::math::statistics::min [lrange $x $ini [expr $fin -1] ]]
			set maxx [::math::statistics::max [lrange $x $ini [expr $fin -1] ]]
			set miny [::math::statistics::min [lrange $y $ini [expr $fin -1] ]]
			set maxy [::math::statistics::max [lrange $y $ini [expr $fin -1] ]]
			set minz [::math::statistics::min [lrange $z $ini [expr $fin -1] ]]
			set maxz [::math::statistics::max [lrange $z $ini [expr $fin -1] ]]

			set meanX [expr $maxx - [expr [expr $maxx- $minx] /2]]
			set meanY [expr $maxy - [expr [expr $maxy- $miny] /2]]
			set meanZ [expr $maxz - [expr [expr $maxz- $minz] /2]]
			set pointList [lappend pointList "$meanX $meanY $meanZ"]
			set residList "[lindex $resid [expr $i -1]]_[lindex $chain [expr $i -1]]"
			incr j
		} else {
			incr i

		}


	}
	unset upproc_var_$atomselection

	return "{$pointList} {$txt}"

}


#### Highlight starting point

proc BPF::highlightStartPoint {frm opt} {


	if {[molinfo top] != -1} {
		## reset Layer
		if {$BPF::pathLayer == "" && $opt != 0} {
			BPF::resetLayer
		}
		# get average point
		set BPF::startpoint [$BPF::topGui.nb.f1.f1.entrySP get]
		set coord [BPF::averagePoint $BPF::startpoint $frm]



		set name [lindex $coord 1]
		set coord [lindex $coord 0]
		if {$coord != ""} {


			set x ""
			set y ""
			set z ""
			set coorx ""
			set coory ""
			set coorz ""
			if {[llength $coord] > 1} {
				set i 0
				while {$i < [llength $coord]} {
					set coori [split [string trim [string trim [lindex $coord $i] "}"] "{"] " "]
					set x [lappend x [lindex $coori 0]]
					set y [lappend y [lindex $coori 1]]
					set z [lappend z [lindex $coori 2]]
					incr i
				}
				set minx [::math::statistics::min [lrange $x 0 end ]]
				set maxx [::math::statistics::max [lrange $x 0 end ]]
				set miny [::math::statistics::min [lrange $y 0 end]]
				set maxy [::math::statistics::max [lrange $y 0 end ]]
				set minz [::math::statistics::min [lrange $z 0 end]]
				set maxz [::math::statistics::max [lrange $z 0 end ]]
				set coord ""
				set coord [lappend coord [expr $maxx - [expr [expr $maxx- $minx] /2]]]
				set coord [lappend coord [expr $maxy - [expr [expr $maxy- $miny] /2]]]
				set coord [lappend coord [expr $maxz - [expr [expr $maxz- $minz] /2]]]
			}



			# Draw starting point
			set name [lindex $name 0]
			if {[lindex $coord 0] != ""} {

				if {$BPF::iniRep != "" && $opt != 0} {
					mol delrep [mol repindex $BPF::pathLayer $BPF::iniRep] $BPF::pathLayer
					incr BPF::repId -1
				}
				set lis ""
				set lis [lappend lis "1 INI $name [string range $name 0 2] [string index $name end] [lindex $coord 0] [lindex $coord 1] [lindex $coord 2] 0"]
				set sel [atomselect $BPF::pathLayer "index 1"]
				$sel set {radius element name resname chain x y z beta} $lis

				unset upproc_var_$sel
				if {$opt == 1} {

					mol selection "index 1"
					mol representation VDW
					mol color "ColorID 4"
					mol material "Opaque"
					mol addrep $BPF::pathLayer
					#set BPF::iniRep [mol repname $BPF::topLayer $BPF::repId]
					incr BPF::repId
				}
				mol top $BPF::topLayer


			}
			update
			if {[lindex $coord 0] == ""} {
				tk_messageBox -message "Invalide starting point" -title "No Starting Point"
			}
			return "[lindex $coord 0] [lindex $coord 1] [lindex $coord 2] $name"
		}
	}
}

proc BPF::resetLayer {} {
# Create or search for the BPFLayer

		# set topLayer
		set BPF::topLayer [molinfo top]

		# Create or see if exists the layer for the box
		set nameLayer ""
		foreach x [molinfo list] {set nameLayer [linsert $nameLayer end [molinfo $x get name]]}


		# save orientation and zoom parameters
		set viewpoint [molinfo $BPF::topLayer get {center_matrix rotate_matrix scale_matrix global_matrix}]


		if {[lsearch $nameLayer "ChemPathTrackerData"]==-1} {

				# Creates a new layer for the drawing
				mol new atoms [expr [molinfo $BPF::topLayer get numatoms] * 2]
				mol rename top "ChemPathTrackerData"
				animate dup [molinfo top]
				set BPF::pathLayer [molinfo top]

				molinfo $BPF::pathLayer set {center_matrix rotate_matrix scale_matrix global_matrix} $viewpoint
				molinfo $BPF::topLayer set {center_matrix rotate_matrix scale_matrix global_matrix} $viewpoint
				#if {$BPF::barLayer != ""} {
				##	mol free $BPF::barLayer
				#	molinfo $BPF::barLayer set {center_matrix rotate_matrix scale_matrix global_matrix} $viewpoint
				#	mol fix $BPF::barLayer
				#}

		} else {
			set BPF::pathLayer [molinfo index [lsearch $nameLayer "ChemPathTrackerData"]]
			set i 0
			while {$i < [llength $BPF::outRep]} {
				mol delrep [mol repindex $BPF::pathLayer [lindex $BPF::outRep $i]] $BPF::pathLayer
				incr BPF::repId -1
				incr i
			}
			set BPF::outRep ""
		}

		# puts the previous layer as the toplevel
		mol top $BPF::topLayer
		update

}

proc BPF::addVertex {x y z opt color radius} {

	if {![info exists BPF::seq]} {set BPF::seq 0}

	# Draw Vertex
		update

		incr BPF::seq
	return
}



proc BPF::addEdge {a b distcutoff weight {bidi 1}} {
# a          - point 1
# b          - point 2
# bidi       - ?
# weight     - cost
# distcutoff - distance cutoff between two points


	set a [string trim $a " "]
	set b [string trim $b " "]
	if {$a == $b} {return}


	#incr a ; incr b

	set dx [expr {[lindex $BPF::vertex($b) 0]-[lindex $BPF::vertex($a) 0]}]
	set dy [expr {[lindex $BPF::vertex($b) 1]-[lindex $BPF::vertex($a) 1]}]
	set dz [expr {[lindex $BPF::vertex($b) 2]-[lindex $BPF::vertex($a) 2]}]
	set dist [expr sqrt (pow($dx,2) + pow($dy,2) + pow($dz,2) )]




	##Socring Function
	set scfun [BPF::scfunction $a $b $weight]

	# mark Edge
	if {$scfun <=$BPF::distcutoff }  {
		set BPF::edge($a:$b) $scfun
		if $bidi {set BPF::edge($b:$a) $scfun}
		if {$scfun == 0} {return}


		# Draw line and text - weight



		BPF::debugP text "[format "%5s" $a] > [format "%-5s" $b] [format "%8.2f" $dist] [format "%8.2f" $scfun]"
		set BPF::point_dist($a,$b) [format "%8.2f" $scfun]


	}
}

proc BPF::adj {v} {
    set r {}
    foreach v [array names BPF::edge $v:*] {lappend r [lindex [split $v :] 1]}
    return $r
}

# here's the algorithm itself

proc BPF::dijkstra {s} {


	## Debug
	BPF::debugP text  ""
	BPF::debugP title "Dijkstra Algorithm"

	# Algorithm
	set i 1
	set lis ""

	while {$i <= [expr [array size BPF::vertex]/3]} {
		set lis [lappend lis $i]
		incr i
	}
		set T $lis
		set S [list]

		set cur $s

		lappend S $cur
		set T [lreplace $T [lsearch -exact $T $cur] [lsearch -exact $T $cur]]
		foreach v [BPF::adj $cur] {
			set BPF::cost($v) $BPF::edge($cur:$v)
			set BPF::prev($v) $cur
		}

		set v_min -1
		set step 0

		BPF::debugP text ""
		BPF::debugP text "================================================================"
		BPF::debugP text " [format "%12s" Interactions ] [format "%14s" "Points     "] [format "%8s" "Cost"] "
		BPF::debugP text "================================================================"

	set numfrm  [expr round([expr double([expr [$BPF::topGui.nb.f1.fdyn.fs.spto get] - [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]]) / [$BPF::topGui.nb.f1.fdyn.fs.spstep get]])]
	if {$numfrm <= 1} {
		set numfrm 1
		$BPF::topGui.nb.f1.fpg.pg configure -value 1
		$BPF::topGui.nb.f1.fpg.pg configure -maximum $i

	}
		while 1 {
			incr step
			update
			BPF::updateState $step 0
			set stop 1


			foreach t $T {if {[info exists BPF::cost($t)]} {set stop 0; break} }
			if $stop {break}

			unset v_min

			foreach j $T {
				if {![info exists BPF::cost($j)]} {continue}
				if {![info exists v_min] || $BPF::cost($j) <= $BPF::cost($v_min)} {set v_min $j}
			}

			set cur $v_min

			lappend S $v_min
			set T [lreplace $T [lsearch -exact $T $v_min] [lsearch -exact $T $v_min]]
			if {[llength $T] == 0} {break}

			foreach i [BPF::adj $v_min] {
				if {[lsearch -exact $T $i] < 0} {continue}
				if {![info exists BPF::cost($i)] || $BPF::cost($i) > [expr {$BPF::cost($v_min)+$BPF::edge($v_min:$i)}]} {
					set BPF::cost($i) [expr {$BPF::cost($v_min)+$BPF::edge($v_min:$i)}]
					set BPF::prev($i) $v_min
				}
			}
			if {$numfrm == 1} {
				$BPF::topGui.nb.f1.fpg.pg step 1
				update
			}
		}
		if {$numfrm == 1} {
			$BPF::topGui.nb.f1.fpg.pg configure -value $i
		}
		set indexs [BPF::updateState $step 1]
		return $indexs

}


proc BPF::updateState {step opt} {

	set test 0
	set indexs ""
	foreach v [array names BPF::prev] {


                # Prints table
    if {$test==0} {
			if {$BPF::debug==1 || $BPF::debug==2} {
				puts "-nonewline" "."
			}
			set test 1
			BPF::debugP text " [format %12s "$step / [expr [array size BPF::vertex] /3] -->"] [format %5s $BPF::prev($v)] > [format %-5s $v] [format %8.2f $BPF::cost($v)] "
			set indexs [lappend indexs "$BPF::prev($v)_$v"]
        } else {
			BPF::debugP text " [format %12s " "] [format %5s $BPF::prev($v)] > [format %-5s $v] [format %8.2f $BPF::cost($v)] "
			set indexs [lappend indexs "$BPF::prev($v)_$v"]
		}

		# Draws only the final result"

		if {$opt==1} {

			# Draw line
			set x 0
			set point_1 "[expr [lindex $BPF::vertex($BPF::prev($v)) 0]+$x] [expr [lindex $BPF::vertex($BPF::prev($v)) 1]+$x] [expr [lindex $BPF::vertex($BPF::prev($v)) 2] +$x]"
			set point_2 "[expr [lindex $BPF::vertex($v) 0] +$x] [expr [lindex $BPF::vertex($v) 1] +$x] [expr [lindex $BPF::vertex($v) 2]+ $x]"

		}
	}

	return $indexs
}



proc BPF::debugP {type text} {

##
##  Usage: debug $text
##
##  type   - title or text
##  text   - text to be displayed
##
##  There is a global variable that varies from YES to NO depending on what we want

	set file [open "$BPF::outPath/debug.txt" a]

	## see if it is title or text
	set charTitle "="
	if {$type=="title"} {set repeat [string repeat $charTitle [expr (60-[string length $text])] ]; set text "$charTitle$charTitle $text $repeat"}

	if {$type=="time"} {set text "» Time spend in procedure: $text"}

	if {$BPF::debug==0} {puts $file "debug:    $text"}
	close $file
}


#### DRAW porcedure

proc BPF::Draw {} {

	# Clear variables




	# Add Vertex from points

	#BPF::debugP text ""
	#BPF::debugP title  "Points Generated (Vertexes)"
	#BPF::debugP text ""
	#BPF::debugP text "==========================================="
	#BPF::debugP text "[format "%6s" "Point"] [format "%8s" "X"] [format "%8s" "Y"] [format "%8s" "Z"]"
	#BPF::debugP text "==========================================="


	BPF::debugP text ""
	BPF::debugP title  "Calculated distances between points (add Edges)"
	BPF::debugP text  ""
	BPF::debugP text  "Distance cut-off: $BPF::distcutoff"
	BPF::debugP text  ""
    BPF::debugP text  "================================================================"
	BPF::debugP text  "[format "%14s" "Points     "] [format "%8s" "Distance"] [format "%8s" "Final_Dist"]"
    BPF::debugP text  "================================================================"
	# Generate all the poossible distances between points and the weight them
	set distances ""
	set un "_"
	set numfrm  [expr round([expr double([expr [$BPF::topGui.nb.f1.fdyn.fs.spto get] - [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]]) / [$BPF::topGui.nb.f1.fdyn.fs.spstep get]])]
	if {$numfrm <= 1} {
		set numfrm 1
		$BPF::topGui.nb.f1.fpg.pg configure -value 1
		$BPF::topGui.nb.f1.fpg.pg configure -maximum [expr ([array size BPF::vertex])/3]

	}



	for {set a 1} {$a <= [expr ([llength [array names BPF::vertex]])/3]} {incr a} {

		set sel [atomselect $BPF::pathLayer "(all within [$BPF::topGui.nb.f1.f1.entryCoff get] of index $a) and (index 1 to [expr ([llength [array names BPF::vertex]])/3]) and not index $a"]
		foreach index [$sel get index] {
			set index [string trim $index " "]
			if {$index > $a && ([lsearch $distances "$a$un$index"] == -1 && [lsearch $distances "$index$un$a"] == -1)} {
				set weight_A $BPF::vertex($a,1)

				# get the weight of point B
				set weight_B $BPF::vertex($index,1)

				# set total weight
				set weigth [expr ($weight_A + $weight_B)/2]

				#store the distance and the weight
				BPF::addEdge $a $index $BPF::distcutoff $weigth
				set distances [lappend distances "$a$un$index"]
			}



		}
		if {$numfrm == 1} {
			$BPF::topGui.nb.f1.fpg.pg step 1
			update
		}
		unset upproc_var_$sel
	}

}




proc BPF::Run {} {


	set numrep [molinfo $BPF::pathLayer get numreps]
	set i 0
	while {[molinfo $BPF::pathLayer get numreps] != 0} {
		mol delrep $i $BPF::pathLayer
	}

	graphics $BPF::pathLayer delete all

	$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb selection clear 0 end
	BPF::tablelistOUT $BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb
	set BPF::repId [expr [molinfo [molinfo top] get numreps] -1]
	set numfrm ""
	if {[$BPF::topGui.nb.f1.f2.frmlist.lb2 size] == 0} {
		return
	}


	set BPF::debug 0
	## Write Data Variables

	set do [BPF::SaveBtt]
	if {$do != "no"} {

		#set BPF::pFind ""
		set BPF::outFind ""
		if {[file exists "$BPF::outPath/debug.txt"] ==1 } {
				file delete "$BPF::outPath/debug.txt"
		}


		$BPF::topGui.nb.f1.fpg.pg configure -value 0
		set numfrm  [expr round([expr double([expr [$BPF::topGui.nb.f1.fdyn.fs.spto get] - [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]]) / [$BPF::topGui.nb.f1.fdyn.fs.spstep get]])]
		if {$numfrm <= 0} {
			set numfrm 1
		} else {
			$BPF::topGui.nb.f1.fpg.pg configure -maximum $numfrm
		}



		array unset BPF::point_coor;array set BPF::point_coor ""
		array unset BPF::point_frm;array set BPF::point_frm ""
		array unset BPF::point_dyn; array set BPF::point_dyn ""
		array unset BPF::point_dist;array set BPF::point_dist ""
		array unset BPF::cost; array set BPF::cost ""
		array unset BPF::prev; array set BPF::prev ""
		array unset BPF::vertex; array set BPF::vertex ""
		array unset BPF::edge; array set BPF::edge ""
		set BPF::point_pair ""
		set numfor 0
		for {set frm [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]} {$frm < [$BPF::topGui.nb.f1.fdyn.fs.spto get]} {incr frm [$BPF::topGui.nb.f1.fdyn.fs.spstep get]} {

			array unset BPF::cost; array set BPF::cost ""
			array unset BPF::prev; array set BPF::prev ""
			array unset BPF::vertex; array set BPF::vertex ""
			array unset BPF::edge; array set BPF::edge ""



			BPF::debugP text "\n\n\n\n================================================================"
			BPF::debugP text " Frame $frm"
			BPF::debugP text "================================================================\n\n\n"

			BPF::debugP text " ==== Data Variables ==================================="
			BPF::debugP text ""
			BPF::debugP text " Debug Level           : $BPF::debug"
			BPF::debugP text " Starting Point        : $BPF::startpoint"

			set startingpointcoordr [BPF::highlightStartPoint $frm 0]

			set BPF::vertex(1) [lrange $startingpointcoordr 0 2]
			set BPF::vertex(1,0) [lindex $startingpointcoordr 3]
			set BPF::vertex(1,1) 100
			if {$frm == [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]} {
				set BPF::point_frm(1) [lindex $startingpointcoordr 3]
				set BPF::point_coor(1) [lrange $startingpointcoordr 0 2]
			}

			if {[lindex $BPF::point_coor(1) 0] == ""} {
				tk_messageBox -message "Invalide starting point" -title "No Starting Point"
				break
			}

			BPF::debugP text " Starting Point Coord  : x:[format %-6.2f [lindex $startingpointcoordr 0] ] y:[format %-6.2f [lindex $startingpointcoordr 1] ] z:[format %-6.2f [lindex $startingpointcoordr 2] ] "
			BPF::debugP text " Distance cut-off      : $BPF::distcutoff"


				## reset variable

				## Add starting point


			BPF::highlight 3 $frm

			BPF::debugP text " Number of Data Points : [expr [array size BPF::vertex] /3]"
			if {$BPF::debug==1 || $BPF::debug==2} {puts "-nonewline" " Analysing "; puts "-nonewline" ".\n"}
			## Draw possibilities and Edges

			BPF::Draw; update


			if {$BPF::debug==1 || $BPF::debug==2} {puts "-nonewline" " Running "; puts "-nonewline" "."}


			## Run Dijkstra algorithm
			set index ""
			set indexs [BPF::dijkstra 1]
			set i 0

			set numberAtoms ""
			set numberAtoms [lappend numberAtoms 1]
			while {$i < [llength $indexs]} {
				set do 1
				set ind [split [lindex $indexs $i] "_"]
				set ind1 [string trim [lindex $ind 0] " "]
				set ind2 [string trim [lindex $ind 1] " "]
				set un "_"
				set distL ""
				set ind_aux ""
				if {[lsearch $numberAtoms $ind1] == -1} {
					set numberAtoms [lappend numberAtoms $ind1]
				}
				if {[lsearch $numberAtoms $ind2] == -1} {
					set numberAtoms [lappend numberAtoms $ind2]
				}

				if {[info exists BPF::point_dist($ind1,$ind2)] == 1} {
					if {[lsearch $BPF::point_pair $ind1$un$ind2] == -1 && [lsearch $BPF::point_pair $ind2$un$ind1] == -1} {
						set BPF::point_pair [lappend BPF::point_pair $ind1$un$ind2]
					}
					set distL $BPF::point_dist($ind1,$ind2)
				} elseif {[info exists BPF::point_dist($ind2,$ind1)] == 1} {
					if {[lsearch $BPF::point_pair $ind1$un$ind2] == -1 && [lsearch $BPF::point_pair $ind2$un$ind1] == -1} {
						set BPF::point_pair [lappend BPF::point_pair $ind2$un$ind1]
					}
					set distL $BPF::point_dist($ind2,$ind1)
					set ind_aux $ind1
					set ind1 $ind2
					set ind2 $ind_aux

				} else {
					set do 0
				}


				if {$do != 0} {
					set BPF::point_dyn($ind1,$ind2,ind1) $BPF::point_frm($ind1)
					set BPF::point_dyn($ind1,$ind2,ind2) $BPF::point_frm($ind2)
					set BPF::point_dyn($ind1,$ind2,dist) [lappend BPF::point_dyn($ind1,$ind2,dist) $distL]

				}
				incr i
			}
			$BPF::topGui.nb.f1.fpg.pg step 1
			update
			incr numfor
		}


		set sel ""

		mol top $BPF::pathLayer
		set i 0
		set pairList ""
		puts $BPF::outPut "\n\n\n[string repeat = 4] OUTPUT VALUES [string repeat "=" 150]"
		puts $BPF::outPut "\n* Legend: ResnameResidChain\n"
		puts $BPF::outPut [string repeat _ 110]

		puts $BPF::outPut "[format "%10s" "Point1"]\t[format "%10s" "Resname1*"]\t[format "%10s" "Point2"]\t[format "%10s" "Resname2*"]\t[format "%10s" "Dist_Mean (A)"]\t[format "%10s" "Dist_STDV (A)"]\t[format "%13s" "Perc (%)"]"
		puts $BPF::outPut [string repeat "_" 110]
		$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb delete 0 end


		while {$i < [llength $BPF::point_pair]} {

			set ind [split [lindex $BPF::point_pair $i] "_"]
			set ind1 [lindex $ind 0]
			set ind2 [lindex $ind 1]

			set mean ""
			set stdv ""
			if {[llength $BPF::point_dyn($ind1,$ind2,dist)] > 1 } {
				set mean [::math::statistics::mean $BPF::point_dyn($ind1,$ind2,dist)]
				set stdv [::math::statistics::stdev $BPF::point_dyn($ind1,$ind2,dist)]
			} else {
				set mean [lindex $BPF::point_dyn($ind1,$ind2,dist) 0]
				set stdv 0.00
			}

			mol top $BPF::topLayer

			set perc [expr [expr double([llength $BPF::point_dyn($ind1,$ind2,dist)]) / $numfor] * 100]
			if {[$BPF::topGui.nb.f1.f1.cb get] == "Percentage" ||[$BPF::topGui.nb.f1.f1.cb get] == "Off" } {
				$BPF::topGui.nb.f1.f1.cb set Percentage
				set max [expr [colorinfo max] - [colorinfo num] -1]
				set clor [expr round([expr 100 - $perc] * $max)/ 100]
				set clor [expr $clor + [colorinfo num]]
			} else {
				set clor [$BPF::topGui.nb.f1.f1.cb get]
			}

			graphics $BPF::pathLayer color $clor
			set BPF::outFind [lappend BPF::outFind [graphics $BPF::pathLayer line $BPF::point_coor($ind1) $BPF::point_coor($ind2) width 4]]

			$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb configure -state normal
			$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb insert end "[format "%10s" "$ind1"][format "%10s" "$BPF::point_dyn($ind1,$ind2,ind1)"][format "%10s" "$ind2"][format "%10s" "$BPF::point_dyn($ind1,$ind2,ind2)"][format "%10.2f" "$mean"][format "%10.2f" "$stdv"][format "%10.2f" "$perc"]"

			puts $BPF::outPut "[format "%10s" "$ind1"]\t[format "%10s" "$BPF::point_dyn($ind1,$ind2,ind1)"]\t[format "%10s" "$ind2"]\t[format "%10s" "$BPF::point_dyn($ind1,$ind2,ind2)"]\t\
			[format "%7.2f" "$mean"]\t[format "%9.2f" "$stdv"]\t[format "%12.2f" "$perc"]"
			incr i
		}
		puts $BPF::outPut [string repeat _ 110]

		set viewpoints [molinfo $BPF::topLayer get {center_matrix rotate_matrix scale_matrix global_matrix}]

		#if {$BPF::barLayer == ""} {
		#	set BPF::barLayer [mol new atoms 1]
		#	mol rename top "BAR"
		#	BPF::color_scale_bar 40 8 0 100 4
		#	molinfo $BPF::barLayer set {center_matrix rotate_matrix scale_matrix global_matrix} $viewpoints
		#	mol fix $BPF::barLayer
		#	mol top $BPF::topLayer
		#}
		$BPF::topGui.nb.f1.fpg.pg configure -maximum 1
		$BPF::topGui.nb.f1.fpg.pg configure -value 1
		set BPF::vertex(1) [lrange [BPF::highlightStartPoint [$BPF::topGui.nb.f1.fdyn.fs.spfrom get] 1] 0 2]
		BPF::highlight 3 [$BPF::topGui.nb.f1.fdyn.fs.spfrom get]
		if {[$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 2 -text] != ""} {
			set i 0
			set lis_aux ""
			set lis [lappend lis [join [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 2 -text]] [join [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 0 -text]]]
			set lis [join $lis]
			while {$i < [llength $lis]} {
				if {[lsearch $lis_aux [lindex $lis $i]] == -1 } {
					set lis_aux [lappend lis_aux [lindex $lis $i]]
				}
				incr i
			}
			$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbto configure -values [lsort -real $lis_aux]
			$BPF::topGui.nb.f2.frmP.frmTable.f1.srch.cmbfrom configure -values [lsort -real $lis_aux]
		}
		puts  "\n Done."
		close $BPF::outPut
	}
}

proc BPF::color_scale_bar {length width min max label_num } {

	display update off
	set loc [axes locations]
	set loc_cur [axes location]
	axes location lowerright
	set x 0
	set y 0
	set z 0
	# draw the color bar
	set start_y [expr -0.5 * $length]
	set step [expr $length / ([colorinfo max] * 1.0) ]
	set i 0
	for {set colorid [expr [colorinfo max] -1] } { $colorid > [colorinfo num] } {incr colorid -1} {
		draw color $colorid
		set cur_y [ expr $start_y + ([expr [colorinfo num] + $i] - [colorinfo num]) * $step ]
		draw line " $x [expr $cur_y +$y] 0 "  " [expr $width + $x]  [expr $cur_y +$y]  0"
		incr i
	}

	# draw the labels
	set coord_x [expr 1.2*$width + $x];
	set step_size [expr $length / $label_num]
	set color_step [expr ([colorinfo max] * 1.0)/$label_num]
	set value_step [expr ($max - $min ) / double ($label_num)]

	for {set i 0} {$i <= $label_num } { incr i} {

		set cur_color_id white
		draw color $cur_color_id
		set coord_y [expr $start_y+$i * $step_size  + $y]
		set cur_text [expr $min + $i * $value_step ]
		draw text  " $coord_x $coord_y 0"  [format %6.2f  $cur_text]
	}

	display update on
}

proc BPF::findPath {from to} {
	set from_aux ""
	set to_aux ""
	set index1 [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 0 -text]
	set index2 [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 2 -text]
	set pair ""
	set path ""
	set i 0
	while {$i < [llength $index1]} {
		set pair [lappend pair "[lindex $index1 $i] [lindex $index2 $i]"]
		incr i
	}
	set mpair $pair
	set id1 $from
	set start ""
	set end 0
	set do 1
	set to_aux $from
	set old_start ""
	while {$end != 1} {
			set start [lsearch $pair "$to_aux *"]
			if {$start == -1} {
				set start [lsearch $pair "* $to_aux"]
			}
			if {$start == -1} {
				set do 0
			} else {
				set old_start $start
			}
			if {$do == 1} {
				set pair_aux $pair
				set start_aux ""
				set avg [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 4 -text]
				set stdv [$BPF::topGui.nb.f2.frmP.frmTable.f1.frmlist.tb columncget 5 -text]
				set pair_aux [lreplace $pair_aux $start $start ""]
				set stop 0
				set brnch 0
				set min [expr double([lindex $avg $start] - [lindex $stdv $start])]
				if {[lsearch [lindex $pair $start] $to] == -1} {
					while {$stop != 1} {
						set start_aux [lsearch $pair_aux "$to_aux *"]
						if {$start_aux == -1} {
							set start_aux [lsearch $pair_aux "* $to_aux"]
						}
						if {$start_aux != -1 && [lsearch $path $start_aux] == -1} {
							if {$brnch == 0} {
								#set pair [lreplace $pair $start $start ""]
								set pair_aux [lreplace $pair_aux $start $start ""]
								set brnch 1
							}
							if {[expr double([lindex $avg $start_aux] - [lindex $stdv $start_aux])]  < $min} {
								set pair [lreplace $pair $start $start ""]
								set pair_aux [lreplace $pair_aux $start $start ""]
								set start $start_aux
								set old_start $start
								set pair_aux [lreplace $pair_aux $start $start ""]
								set min [expr double([lindex $avg $start] - [lindex $stdv $start])]
								if { [lsearch [lindex $pair_aux $start] $to] != -1} {
									set pair_aux [lreplace $pair_aux $start $start ""]
									set stop 1
									break
								}
							}
						} else {
							if {[lsearch $path $start_aux] != -1} {
								set pair [lreplace $pair $start_aux $start_aux ""]
								set path ""
							} else {
								set pair_aux [lreplace $pair_aux $start_aux $start_aux ""]
								set stop 1
								break
							}
						}
						set pair_aux [lreplace $pair_aux $start_aux $start_aux ""]
					}
				}

				if {[lsearch [lindex $pair $start] $to] == -1} {
					if {[lsearch [lindex $pair $start] $to_aux] == 0} {
						set to_aux [lindex [lindex $pair $start] 1]
					} else {
						set to_aux [lindex [lindex $pair $start] 0]
					}
					set i 0
					set count 0
					set path_aux [join $path]
					while {$i < [llength $path]} {
					if {[lsearch [lindex $path $i] $to_aux] != -1 || [lsearch [lindex $path $i] $to_aux] != -1} {
						incr count
					}
					incr i
					}
					if {($to_aux == $from) && $count > 0} {
						set pair $mpair
						set pair [lreplace $pair $start $start ""]
						set mpair $pair
						set path ""
						set to_aux $from
					} elseif {($to_aux != $from) && $count > 1} {
						set pair $mpair
						set pair [lreplace $pair $start $start ""]
						set mpair $pair
						set path ""
						set to_aux $from
					} else {
						set path [lappend path [lindex $pair $start]]
					}


				} else {
					set path [lappend path [lindex $pair $start]]
					set end 1
					break
				}
				set pair [lreplace $pair $start $start ""]
			} else {
				set pair $mpair
				set pair [lreplace $pair $old_start $old_start ""]
				set mpair $pair
				set path ""
				set to_aux $from
				set do 1
			}
	}
	return $path
}

proc BPF::scfunction {a b weight} {
	# a          - point 1
# b          - point 2
# bidi       - ?
# weight     - cost
# distcutoff - distance cutoff between two points


		set dx [expr {[lindex $BPF::vertex($b) 0]-[lindex $BPF::vertex($a) 0]}]
	set dy [expr {[lindex $BPF::vertex($b) 1]-[lindex $BPF::vertex($a) 1]}]
	set dz [expr {[lindex $BPF::vertex($b) 2]-[lindex $BPF::vertex($a) 2]}]
	set dist [expr sqrt (pow($dx,2) + pow($dy,2) + pow($dz,2) )]


	set weightF [expr $dist + [expr [expr 100 - $weight ] / 100] ]
	return $weightF
}
