; ------------ RECOMMENDATIONS ------------

(defrule recommend-nothing
    (whos-drinking friend)
    (or (and (gathering no)
             (or (wine-lover no)                                   
                 (and (wine-lover yes) (really-know-them no))
                 (and (wine-lover yes) (really-know-them yes) (your-favorite no))))
        (and (gathering yes) (what-gathering get_together) (know-them yes) (wine-lover-2 yes) (your-favorite no)))
    =>
    (assert (recommendation "RECOMMENDATION|They don't deserve any wine."))
)

(defrule 2-recommend-nothing
    (whos-drinking friend) 
    (gathering yes)
    (or (and (what-gathering dinner) (who-cooks me))
        (and (what-gathering get_together) (know-them yes) (wine-lover-2 no)))
    =>
    (assert (recommendation "RECOMMENDATION|They don't deserve any wine."))
)

(defrule recommend-california-pinot-noir
    (whos-drinking friend)
    (or (and (gathering no) (wine-lover yes) (really-know-them yes))
        (and (gathering yes) (what-gathering get_together) (know-them yes) (wine-lover-2 yes)))
    (your-favorite yes)
    =>
    (assert (recommendation "RECOMMENDATION|California pinot noir."))
)

(defrule recommend-whisky-vodka
    (whos-drinking friend)
    (gathering yes)
    (what-gathering bachelor)
    =>
    (assert (recommendation "RECOMMENDATION|Forget about the wine. Bring whisky or vodka. Or both :P"))
)

(defrule recommend-buck-chuck
    (whos-drinking friend)
    (gathering yes)
    (what-gathering art_opening)
    =>
    (assert (recommendation "RECOMMENDATION|They rarely have a sense of taste. Pick 2-buck chuck"))
)

(defrule recommend-glass-on-beach
    (whos-drinking friend)
    (gathering yes)
    (what-gathering beach_bbq)
    =>
    (assert (recommendation "RECOMMENDATION|Can't drink on the beach. The glass will be confiscated."))
)

(defrule recommend-pinot-noir
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work yes)
    =>
    (assert (recommendation "RECOMMENDATION|Sniff your glass of pinot noir"))
)

(defrule recommend-red-blend
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering dinner)
    (who-cooks them)
    =>
    (assert (recommendation "RECOMMENDATION|Buy the biggest red blend bottle."))
)

(defrule recommend-boring-bottle
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering get_together)
    (know-them no)
    =>
    (assert (recommendation "RECOMMENDATION|Bring boring bottle."))
)