## bMotion plugin: bhar (etc)

#

# $Id$

#



###############################################################################

# This is a bMotion plugin

# Copyright (C) James Michael Seward 2000-2002

#

# This program is covered by the GPL, please refer the to LICENCE file in the

# distribution; further information can be found in the headers of the scripts

# in the modules directory.

###############################################################################



bMotion_plugin_add_complex "fact" {[[:<:]](is|was|=|am)[[:>:]]} 100 bMotion_plugin_complex_fact "en"


proc bMotion_plugin_complex_fact { nick host handle channel text } {
  global bMotionFacts
  if {[string range $text end end] == "?"} { return 0 }
  if [regexp -nocase {[[:<:]]([^ !"]+)[!" ]+(is|was|==?|am) ?([a-z0-9 '_-]+)} $text matches item blah fact] {
    set item [string tolower $item]
    if {([string length $fact] < 3) || ([string length $fact] > 12)} { return 0 }
    if [regexp "(what|which|have|it|that|when|where|there|then|this|who|you|you|yours|why|he|she)" $item] {
      return 0
    }
    if {$item == "i"} {
      set item [string tolower $nick]
    }
    regsub {[[:<:]]me[[:>:]]} $fact $nick fact
    set fact [string tolower [string trim $fact]]
    regsub {[[:<:]]my[[:>:]]} $fact "%OWNER{$nick}" fact
    putlog "fact: $item == $fact"
    lappend bMotionFacts(what,$item) $fact
  }
  return 0
}
