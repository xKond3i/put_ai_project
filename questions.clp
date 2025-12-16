; Reguła startowa
(defrule start
    =>
    (printout t "=== System startuje ===" crlf)
    (assert (whos-drinking unknown))
    (assert (gathering unknown))
    (assert (what-gathering unknown))
    (assert (wine-lover unknown))
    (assert (wine-lover-2 unknown))
    (assert (really-know-them unknown))
    (assert (your-favorite unknown))
    (assert (you-at-home unknown))
    (assert (you-alone unknown))
    (assert (recovering-from-work unknown))
    (assert (who-cooks unknown))
    (assert (know-them unknown))
    (assert (getting-drunk unknown))
    (assert (feeling-fancy unknown))
    (assert (daily-drinking unknown))
    (assert (kool-aid unknown))
    (assert (eat-dirt unknown))
    (assert (spray-butter unknown))
    (assert (new-old unknown))
    (assert (into-cults unknown))
)

; Questions
(defrule ask-whos-drinking
    (whos-drinking unknown)
    =>
    (assert (question "QUESTION|whos-drinking|Who's drinking it?|myself|Myself|friend|Friend"))
)

(defrule ask-gathering
    (whos-drinking friend)
    (gathering unknown)
    =>
    (assert (question "QUESTION|gathering|Are you at a social gathering?|yes|Yes|no|No"))
)

(defrule ask-wine-lover
    (whos-drinking friend)
    (gathering no)
    (wine-lover unknown)
    =>
    (assert (question "QUESTION|wine-lover|Are they a wine lover?|yes|Yes|no|No"))
)

(defrule ask-really-know-them
    (whos-drinking friend) 
    (gathering no)
    (wine-lover yes)
    (really-know-them unknown)
    =>
    (assert (question "QUESTION|really-know-them|Do you really know them?|yes|Yes|no|No"))
)

(defrule ask-your-favorite
    (whos-drinking friend)
    (or (and (gathering no) (wine-lover yes) (really-know-them yes))
        (and (gathering yes) (what-gathering get_together) (know-them yes) (wine-lover-2 yes)))
    (your-favorite unknown)
    =>
    (assert (question "QUESTION|your-favorite|Are they your favorite people in the world?|yes|Yes|no|No"))
)

(defrule ask-what-gathering
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering unknown)
    =>
    (assert (question "QUESTION|what-gathering|What type of gathering?|beach_bbq|Beach BBQ|art_opening|Art Opening|get_together|Get Together|bachelor|Bachelor Party|dinner|Dinner"))
)

(defrule ask-who-cooks
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering dinner)
    (who-cooks unknown)
    =>
    (assert (question "QUESTION|who-cooks|Who is cooking?|me|Me|them|Them"))
)

(defrule ask-know-them
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering get_together)
    (know-them unknown)
    =>
    (assert (question "QUESTION|know-them|Do you know them?|yes|Yes|no|No"))
)

(defrule ask-wine-lover-2
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering get_together)
    (know-them yes)
    (wine-lover-2 unknown)
    =>
    (assert (question "QUESTION|wine-lover-2|Are they wine lovers?|yes|Yes|no|No"))
)

(defrule ask-you-at-home
    (whos-drinking myself) 
    (you-at-home unknown)
    =>
    (assert (question "QUESTION|you-at-home|Are you at home?|yes|Yes|no|No"))
)

(defrule ask-you-alone
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone unknown)
    =>
    (assert (question "QUESTION|you-alone|Are you alone?|yes|Yes|no|No"))
)

(defrule ask-recovering-from-work
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work unknown)
    =>
    (assert (question "QUESTION|recovering-from-work|Recovering from work?|yes|Yes|no|No"))
)

(defrule ask-getting-drunk
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk unknown)
    =>
    (assert (question "QUESTION|getting-drunk|Getting drunk?|yes|Yes|no|No"))
)

(defrule ask-feeling-fancy
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk no)
    (feeling-fancy unknown)
    =>
    (assert (question "QUESTION|feeling-fancy|Feeling fancy?|yes|Yes|no|No"))
)

(defrule ask-daily-drinking
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk no)
    (feeling-fancy no)
    (daily-drinking unknown)
    =>
    (assert (question "QUESTION|daily-drinking|Daily drinking wine?|yes|Yes|no|No"))
)

(defrule ask-kool-aid
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk no)
    (feeling-fancy no)
    (daily-drinking yes)
    (kool-aid unknown)
    =>
    (assert (question "QUESTION|kool-aid|Kool-aid man?|yes|Yes|no|No"))
)

(defrule ask-eat-dirt
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk no)
    (feeling-fancy no)
    (daily-drinking yes)
    (kool-aid no)
    (eat-dirt unknown)
    =>
    (assert (question "QUESTION|eat-dirt|Eat dirt as a child?|yes|Yes|no|No"))
)

(defrule ask-spray-butter
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk no)
    (feeling-fancy no)
    (daily-drinking yes)
    (kool-aid no)
    (eat-dirt no)
    (spray-butter unknown)
    =>
    (assert (question "QUESTION|spray-butter|Spray butter in your mouth?|yes|Yes|no|No"))
)

(defrule ask-new-old
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk no)
    (feeling-fancy no)
    (daily-drinking no)
    (new-old unknown)
    =>
    (assert (question "QUESTION|new-old|New vs old world?|new|New|old|Old|what|What"))
)

(defrule ask-into-cults
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk no)
    (feeling-fancy no)
    (daily-drinking no)
    (new-old new)
    (into-cults unknown)
    =>
    (assert (question "QUESTION|into-cults|Are you into cults?|yes|Yes|no|No"))
)