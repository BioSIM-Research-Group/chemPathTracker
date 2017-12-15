#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

package require Tk

set logo "
R0lGODdhSgHsAPcAAAAAABAQECAgIO0hKSsrK+8wNwM6gzo6OgRAi/BCSQRDlUtKSgdLoBZQmvBR
VwJSvglSr1RUVAFWwgVaxQRbyRBbultcXCBdrQpeyDpfkAdgzw9gxjBhoA1izfFiZwxj0RVjxCNj
s1JkfGRkZBNlzUxlhhFm0RZozmtpZhVq1Bxqy1Jr1GJrdhZs2Tdsr2xsbCNtyxlu2E5vmiRx0nNx
bh1y3PJydztzukZzr2RzhwF0YC50zXR0dCF14Fx1l3F1enp3dpV313d4eSV543t5doN60g97aTl7
z2t7j3x7e0l8vSp95zV93GF9oYB/gYJ/flaAtXiAi3+Af/OAhS2B6zSB40iDz4ODgw2E5RyEcz6E
3zKF7oOFiYmGhmaHtIaIizaJ8T2J64qJh0OL54yLizqM9ViMzXyMoaCM5U+N3oqNkj2P+JGPjvSP
kzSQgD6R+Y2RlpORjkSS9IKTqpOTk0KU/GiUzk6V75WWmpmXlkSY/1yY5ZeYmn2Zvp6alWib30uc
jn6c85ycnCmd8DGdKGid8Xedz5ueo6GfnvWfonih3p6ho6KhnqWh7FWilTWjLICjz5Cju6Sjozul
M0OmO6Kmq6mnpaeoqaqppkSq8kurQ1Sr946r0Kurq4Wt4aitsmuuorGvrfWvsVixULOxrq2yt9Sy
1p2z0Gi0+rS0tGO1XHq2q4G2+qW2+LW2uZe34Lm3trq4tre5vKW622+7abu7u6q90si99/e9wNq+
3b2/wcPAvXvBdbfD0cPDw9vD9anE5ZPFvZjF+obGgMTGysjGxYHJ+8rJxrbK4sXK0LzLu5PMjszM
zM3O0NDPzfnP0M7Q0Z3RmbbS+NPSz9TT08XU3bTW0drW0KnXpdjX2tXY3NfZ18na8N/a8dzc3Lfd
tN7d4Z3e/eDf3u7f6/rf4OLh38XkwuTk5NLl+Njm5vDm+evn5Lvo+tHpz+bp6eDq+OXr5fvr7Nrs
2+3t7fHu6uPy4+3z9O/z+/Pz8+306/v19NX2/fX5+/T69P///wAAACH5BAkAAP8AIf8LSUNDUkdC
RzEwMTL/AAAMSExpbm8CEAAAbW50clJHQiBYWVogB84AAgAJAAYAMQAAYWNzcE1TRlQAAAAASUVD
IHNSR0IAAAAAAAAAAAAAAAAAAPbWAAEAAAAA0y1IUCAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARY3BydAAAAVAAAAAzZGVzYwAAAYQAAABsd3RwdAAAAfAA
AAAUYmtwdAAAAgQAAAAUclhZWgAAAhgAAAAUZ1hZWgAAAiwAAAAUYlhZWgAAAkAAAAAUZG1uZAAA
AlQAAABwZG1kZAAAAsQAAACIdnVlZAAAA0wAAACGdmll/3cAAAPUAAAAJGx1bWkAAAP4AAAAFG1l
YXMAAAQMAAAAJHRlY2gAAAQwAAAADHJUUkMAAAQ8AAAIDGdUUkMAAAQ8AAAIDGJUUkMAAAQ8AAAI
DHRleHQAAAAAQ29weXJpZ2h0IChjKSAxOTk4IEhld2xldHQtUGFja2FyZCBDb21wYW55AABkZXNj
AAAAAAAAABJzUkdCIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAAEnNSR0IgSUVDNjE5NjYtMi4xAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABYWVogAAAAAAAA
81EAAf8AAAABFsxYWVogAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAA
AAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z2Rlc2MAAAAAAAAAFklFQyBodHRwOi8v
d3d3LmllYy5jaAAAAAAAAAAAAAAAFklFQyBodHRwOi8vd3d3LmllYy5jaAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkZXNjAAAAAAAAAC5JRUMgNjE5NjYtMi4x
IERlZmF1bHQgUkdCIGNvbG91ciBzcGFjZSAtIHNSR0L/AAAAAAAAAAAAAAAuSUVDIDYxOTY2LTIu
MSBEZWZhdWx0IFJHQiBjb2xvdXIgc3BhY2UgLSBzUkdCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGRl
c2MAAAAAAAAALFJlZmVyZW5jZSBWaWV3aW5nIENvbmRpdGlvbiBpbiBJRUM2MTk2Ni0yLjEAAAAA
AAAAAAAAACxSZWZlcmVuY2UgVmlld2luZyBDb25kaXRpb24gaW4gSUVDNjE5NjYtMi4xAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAB2aWV3AAAAAAATpP4AFF8uABDPFAAD7cwABBMLAANcngAAAAFY
WVog/wAAAAAATAlWAFAAAABXH+dtZWFzAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAACjwAAAAJz
aWcgAAAAAENSVCBjdXJ2AAAAAAAABAAAAAAFAAoADwAUABkAHgAjACgALQAyADcAOwBAAEUASgBP
AFQAWQBeAGMAaABtAHIAdwB8AIEAhgCLAJAAlQCaAJ8ApACpAK4AsgC3ALwAwQDGAMsA0ADVANsA
4ADlAOsA8AD2APsBAQEHAQ0BEwEZAR8BJQErATIBOAE+AUUBTAFSAVkBYAFnAW4BdQF8AYMBiwGS
AZoBoQGpAbEBuQHBAckB0QHZAeEB6QHyAfoCAwIMAv8UAh0CJgIvAjgCQQJLAlQCXQJnAnECegKE
Ao4CmAKiAqwCtgLBAssC1QLgAusC9QMAAwsDFgMhAy0DOANDA08DWgNmA3IDfgOKA5YDogOuA7oD
xwPTA+AD7AP5BAYEEwQgBC0EOwRIBFUEYwRxBH4EjASaBKgEtgTEBNME4QTwBP4FDQUcBSsFOgVJ
BVgFZwV3BYYFlgWmBbUFxQXVBeUF9gYGBhYGJwY3BkgGWQZqBnsGjAadBq8GwAbRBuMG9QcHBxkH
Kwc9B08HYQd0B4YHmQesB78H0gflB/gICwgfCDIIRghaCG4IggiWCKoIvgjSCOcI+wkQCSUJOglP
CWT/CXkJjwmkCboJzwnlCfsKEQonCj0KVApqCoEKmAquCsUK3ArzCwsLIgs5C1ELaQuAC5gLsAvI
C+EL+QwSDCoMQwxcDHUMjgynDMAM2QzzDQ0NJg1ADVoNdA2ODakNww3eDfgOEw4uDkkOZA5/DpsO
tg7SDu4PCQ8lD0EPXg96D5YPsw/PD+wQCRAmEEMQYRB+EJsQuRDXEPURExExEU8RbRGMEaoRyRHo
EgcSJhJFEmQShBKjEsMS4xMDEyMTQxNjE4MTpBPFE+UUBhQnFEkUahSLFK0UzhTwFRIVNBVWFXgV
mxW9FeAWAxYmFkkWbBaPFrIW1hb6Fx0XQRdlF4kX/64X0hf3GBsYQBhlGIoYrxjVGPoZIBlFGWsZ
kRm3Gd0aBBoqGlEadxqeGsUa7BsUGzsbYxuKG7Ib2hwCHCocUhx7HKMczBz1HR4dRx1wHZkdwx3s
HhYeQB5qHpQevh7pHxMfPh9pH5Qfvx/qIBUgQSBsIJggxCDwIRwhSCF1IaEhziH7IiciVSKCIq8i
3SMKIzgjZiOUI8Ij8CQfJE0kfCSrJNolCSU4JWgllyXHJfcmJyZXJocmtyboJxgnSSd6J6sn3CgN
KD8ocSiiKNQpBik4KWspnSnQKgIqNSpoKpsqzysCKzYraSudK9EsBSw5LG4soizXLQwtQS12Last
4f8uFi5MLoIuty7uLyQvWi+RL8cv/jA1MGwwpDDbMRIxSjGCMbox8jIqMmMymzLUMw0zRjN/M7gz
8TQrNGU0njTYNRM1TTWHNcI1/TY3NnI2rjbpNyQ3YDecN9c4FDhQOIw4yDkFOUI5fzm8Ofk6Njp0
OrI67zstO2s7qjvoPCc8ZTykPOM9Ij1hPaE94D4gPmA+oD7gPyE/YT+iP+JAI0BkQKZA50EpQWpB
rEHuQjBCckK1QvdDOkN9Q8BEA0RHRIpEzkUSRVVFmkXeRiJGZ0arRvBHNUd7R8BIBUhLSJFI10kd
SWNJqUnwSjdKfUrESwxLU0uaS+JMKkxyTLpNAk3/Sk2TTdxOJU5uTrdPAE9JT5NP3VAnUHFQu1EG
UVBRm1HmUjFSfFLHUxNTX1OqU/ZUQlSPVNtVKFV1VcJWD1ZcVqlW91dEV5JX4FgvWH1Yy1kaWWlZ
uFoHWlZaplr1W0VblVvlXDVchlzWXSddeF3JXhpebF69Xw9fYV+zYAVgV2CqYPxhT2GiYfViSWKc
YvBjQ2OXY+tkQGSUZOllPWWSZedmPWaSZuhnPWeTZ+loP2iWaOxpQ2maafFqSGqfavdrT2una/9s
V2yvbQhtYG25bhJua27Ebx5veG/RcCtwhnDgcTpxlXHwcktypnMBc11zuHQUdHB0zHUodYV14XY+
/3abdvh3VnezeBF4bnjMeSp5iXnnekZ6pXsEe2N7wnwhfIF84X1BfaF+AX5ifsJ/I3+Ef+WAR4Co
gQqBa4HNgjCCkoL0g1eDuoQdhICE44VHhauGDoZyhteHO4efiASIaYjOiTOJmYn+imSKyoswi5aL
/IxjjMqNMY2Yjf+OZo7OjzaPnpAGkG6Q1pE/kaiSEZJ6kuOTTZO2lCCUipT0lV+VyZY0lp+XCpd1
l+CYTJi4mSSZkJn8mmia1ZtCm6+cHJyJnPedZJ3SnkCerp8dn4uf+qBpoNihR6G2oiailqMGo3aj
5qRWpMelOKWpphqmi6b9p26n4KhSqMSpN6mpqv8cqo+rAqt1q+msXKzQrUStuK4trqGvFq+LsACw
dbDqsWCx1rJLssKzOLOutCW0nLUTtYq2AbZ5tvC3aLfguFm40blKucK6O7q1uy67p7whvJu9Fb2P
vgq+hL7/v3q/9cBwwOzBZ8Hjwl/C28NYw9TEUcTOxUvFyMZGxsPHQce/yD3IvMk6ybnKOMq3yzbL
tsw1zLXNNc21zjbOts83z7jQOdC60TzRvtI/0sHTRNPG1EnUy9VO1dHWVdbY11zX4Nhk2OjZbNnx
2nba+9uA3AXcit0Q3ZbeHN6i3ynfr+A24L3hROHM4lPi2+Nj4+vkc+T85YTmDeaW5x/nqegy6LxU
6Ubp0Opb6uXrcOv77IbtEe2c7ijutO9A78zwWPDl8XLx//KM8xnzp/Q09ML1UPXe9m32+/eK+Bn4
qPk4+cf6V/rn+3f8B/yY/Sn9uv5L/tz/bf//ACwAAAAASgHsAAAI/wD9CRxIsKDBgwgTKlzIsKHD
hxAjSpxIsaLFixgzatzIsaPHjyBDihxJsqTJkyhTqlzJsqXLlzBjypxJs6bNmzhz6tzJs6fPn0CD
Ch1KtKjRo0iTKl3KtKlTnvjmzcOnMCrVp1izAo16zhszX6kkCaJDR9I5hPg60RHUyZe3qVrjylXJ
1Rs1X7XCChIkSVKnTqlqMaNGTRIzhNQEUWOWqpNYtr6onbs6t7JliFHndf2a1/FetoF9DfZ2Tqpp
06l8HcSXGp9rrndrddoLOPLky7jnarYL1nHfvn9TD6ZG+rTx41JTH0w89bVz17uZyf7dVjLl3Nh7
Qj+3GK9evn5Dj/8+V9p4ZuTok6sumNbX8/fsNd9tLLaT4LPZ87vMbFd65758AVaLaMSVl96BCJ6m
XEHeSNLcexCuNo9Xsimm34Uh1cWZb8AFRyBp5UF3XoIkIrjgQO1BqKJrC6VFDYYwVjThYrVM91l4
AzIDYok89njgiQI1+OCKzxn0mj/4FHZdjEwyFBaOH5Ln45RUHjggQay5R2SE7FEVlSTrNSnmQoL4
YppzVaap5mk1EuSNIENu6VyXAjEjyJJj5klQa2v26ec8bQqUVi1yrogkklfNY5iejCIpmUBgjfjn
pD0G6s+bkxWqKTWd4NlojL6slYpdkkhK6akIBopPjZoW6s88nbz/+GmezNDB2F5kTIbqrqnWEqQg
3rS6paOlzprnPGWeo40vh9DRSbC8Rmtcm6x1KiyRr3ZymLF51iKJN+CA4w0xlThLzVTSRtvmOcBe
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
lE4plVaplV4plmaplm4pl3apl34pmIapdAQEADs="


## Windows Creation
    wm title . "Chem-Path-Tracker Installation"
    wm resizable . 0 0
    grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 0
    grid [ttk::frame .setup -width 350 -height 600] -row 0 -column 0 -sticky news

    ####  General

        # Logo Image
        image create photo img1 -data $logo
        grid [ttk::label .setup.logo -image img1 -justify center] -row 0 -column 0 -sticky ew

        # frame with commands
        grid [ttk::frame .setup.f  -height 200] -row 1 -column 0 -stick ew


        # Buttons
        grid [ttk::frame .setup.buttons -relief sunken -padding "1 2 1 1" ] -row 2 -column 0 -sticky news 
        grid [ttk::button .setup.buttons.previous -text "Previous" -command {cmd previous}] -in .setup.buttons -row 0 -column 0
        grid [ttk::button .setup.buttons.next -text "Next" -command {cmd next} ] -in .setup.buttons -row 0 -column 1 -sticky e

        grid columnconfigure .setup.buttons 1 -weight 1

#### Page 1
proc page1 {} {
        set text1 {Chem-Path-Tracker is a VMD plug-in that allows the user to highlight and reveal potential chemical motifs \
            in molecular structures requiring only few selections. The analysis is based on atoms/residues pair distances applying a modified version\
            of Dijkstra’s algorithm, and it makes possible to monitor the distances of large pathways, even during a molecular\
            dynamics simulation.}
            
        grid [ttk::label .setup.f.label1 -text $text1 -justify center -wraplength 300 -padding "20 10 20 10"] -in .setup.f -row 0 -column 0 -sticky news -padx 1

        set text2 {This software was developed by Theoretical Chemistry Group of Faculty of Science of Universidade do Porto}
        grid [label .setup.f.label2 -background grey  -text $text2 -justify center -wraplength 280 ] -in .setup.f -row 1 -column 0 -sticky ew -padx 1 -pady 10

}


#### Page 2
proc page2 {} {
    global directory
    set text {Directory where the Chem-Path-Tracker will be installed:}
    grid [ttk::label .setup.f.label3 -text $text -justify center -wraplength 300 -padding "20 10 20 10"] -in .setup.f -row 0 -column 0
    grid [ttk::button .setup.f.button1 -text "Click to Choose the Diretory" -padding "20 10 1 10" -command {chooseDir}] -in .setup.f -row 1 -column 0 -pady 20
    grid [ttk::label .setup.f.label4 -textvariable directory  -justify center -wraplength 300 -padding "10 10 10 10"] -in .setup.f -row 2 -column 0 -pady 5
}


#### Page 3
proc page3 {} {
    global directory
    set text {CONGRATULATIONS !}
    grid [ttk::label .setup.f.label5 -text $text -justify center -wraplength 300 -padding "10 10 10 10"] -in .setup.f -row 0 -column 0

    set text1 {The installation of the Chem-Path-Tracker Plug-in is complete.}
    grid [ttk::label .setup.f.label6 -text $text1 -justify center -wraplength 300 -padding "10 10 10 10"] -in .setup.f -row 1 -column 0


    set text2 {The plug-in can be found in the Extensions Menu of the VMD application under the PortoBioComp submenu.}
    grid [label .setup.f.label7 -background grey -text $text2 -justify center -wraplength 300 ] -in .setup.f -row 2 -column 0 -padx 10

    set text3 {More informations can be found at:}
    set text4 {http://www2.fc.up.pt/PortoBioComp/database/doku.php?id=chem-path-Tracker }
    grid [ttk::label .setup.f.label8 -text $text3 -justify center -wraplength 300 -padding "10 20 10 10"] -in .setup.f -row 3 -column 0
    grid [ttk::label .setup.f.label9 -text $text4 -justify center -wraplength 300 -padding "10 10 10 10"] -in .setup.f -row 4 -column 0
}

#### Commands

proc install {} {
    global directory page


    set Path $directory

    #### COPY Files
    set fileList [lsort [glob *]]

    ## Creating Directory
    set path_ini [pwd]
    if { [file isdirectory $Path]==0} {
        file mkdir $Path
    } else {

        ## Directory already exists
    
        set answer [tk_messageBox -message "The Directory already exists!\nDo you want to overwrite it?" \
            -icon question -type yesno \
            -detail "Directory: $directory"]

        switch -- $answer {

        yes {if {$Path != $path_ini} {foreach a $fileList { file delete -force $Path/$a} } }

        no {set directory "."; return}
        }
        
    }

    ## Copying files
    if {$Path != $path_ini} {foreach a $fileList {file copy -force $a $Path}}

    #### Change VMDRC

    set file ""
    if {[string first "Windows" $::tcl_platform(os)] != -1} {
        if {[file exists "C:/Program Files/University of Illinois/VMD/vmd.rc" ]!= 1} {
            tk_messageBox -message "VMD is not in C:/Program Files/University of Illinois/VMD\nPlease indicate where VMD is located" -title "VMD directory"
            set vmdpath [tk_chooseDirectory -title "Choose VMD directory"]
            set file "$vmdpath/vmd.rc"
            if {$vmdpath == ""} {break}
        } else {
            set vmdpath "C:/Program Files/University of Illinois/VMD"
            set file "$vmdpath/vmd.rc"
        }
    } else {set file "[file nativename ~]/.vmdrc"}

    if {[file exists $file ]!= 1} {
        set vmdrc [open $file w+]
    } else {
        set vmdrc [open $file r+]
        set vmdrcF [read $vmdrc]
        close $vmdrc
        set vmdrcF [split $vmdrcF "\n"]
        set vmdrc [open $file w+]
        set i 0
        while {$i <= [llength $vmdrcF]} {
             ##set line [gets $vmdrc]
            if {[lindex $vmdrcF $i] == "###Chem-Path-Tracker"} {
                incr i
                while {[lindex $vmdrcF $i] != "##END" && [string range [lindex $vmdrcF $i] 0 2] != "###"} {incr i}
                }
            if {[lindex $vmdrcF $i] != ""} {
                puts $vmdrc [lindex $vmdrcF $i]
                }
                incr i
        }
     }

     # Add new libraries required for ChemPathtracker
     puts $vmdrc "###Chem-Path-Tracker"
     puts $vmdrc "lappend auto_path $Path/"
     puts $vmdrc "lappend auto_path $Path/LIB"
     
     # Add  ChemPathtracker extension
     puts $vmdrc "vmd_install_extension BPF \"BPF::BPF\" \"PortoBioComp/Chem-Path-Tracker\""

     puts $vmdrc "menu main on"
     puts $vmdrc "##END"
     close $vmdrc
}



proc chooseDir {} {
    global directory
    set directory [tk_chooseDirectory \
        -initialdir ~ -title "Choose a directory"]/chemPathTracker
    if {$directory !="."} {.setup.buttons.next configure -state normal ; .setup.buttons.next configure -text "Install"}
}


proc cmd {opt} {
    global page directory
    # destroy all widgets
    destroy .setup.f.label1 .setup.f.label2 .setup.f.label3  .setup.f.button1   .setup.f.label4  .setup.f.label5  .setup.f.label6  .setup.f.label7  .setup.f.label8  .setup.f.label9
    #move frame
     .setup.buttons.next configure -state normal
    if {$opt=="next"} {incr page} else {set page [expr $page -1]}
    if {$page <1} {exit}
    if {$page >3} {exit}
    if {$page==1} {.setup.buttons.previous configure -text "Exit"}
    if {$page==2 && $directory =="."} {.setup.buttons.next configure -state disabled; .setup.buttons.previous configure -text "Previous"}
    if {$page==2 && $directory !="."} {.setup.buttons.next configure -text "Install"; } else {.setup.buttons.next configure -text "Next"}
    if {$page==3 && $directory !="."} {install; if { $directory !="."} {.setup.buttons.next configure -text "Exit"} else {set page 2; .setup.buttons.next configure -state disabled }}
    page$page
}


#### variables

set directory "."
set page 2
cmd 0

