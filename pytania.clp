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
)

; First question
(defrule ask-whos-drinking
    (whos-drinking unknown)
    =>
    (printout t "Question: Who's drinking it?" crlf)
    (printout t "Type 'myself' or 'friend': ")
    (bind ?answer (read))
    (assert (whos-drinking ?answer))
)

(defrule ask-gathering
    (whos-drinking friend)
    (gathering unknown)
    =>
    (printout t "Question: Are you at a social gathering?" crlf)
    (printout t "Type 'yes' or 'no': ")
    (bind ?answer (read))
    (assert (gathering ?answer))
)

(defrule ask-wine-lover
    (whos-drinking friend)
    (gathering no)
    (wine-lover unknown)
    =>
    (printout t "Question: Are they a wine lover?" crlf)
    (printout t "Type 'yes' or 'no': ")
    (bind ?answer (read))
    (assert (wine-lover ?answer))
)

(defrule ask-really-know-them
    (whos-drinking friend) 
    (gathering no)
    (wine-lover yes)
    (really-know-them unknown)
    =>
    (printout t "Question: Do you really know them?" crlf)
    (printout t "Type 'yes' or 'no': ")
    (bind ?answer (read))
    (assert (really-know-them ?answer))
)

(defrule ask-your-favorite
    (whos-drinking friend)
    (or (and (gathering no) (wine-lover yes) (really-know-them yes))
        (and (gathering yes) (what-gathering get_together) (know-them yes) (wine-lover-2 yes)))
    (your-favorite unknown)
    =>
    (printout t "Question: Are they your favorite people in the world?" crlf)
    (printout t "Type 'yes' or 'no': ")
    (bind ?answer (read))
    (assert (your-favorite ?answer))
)

(defrule ask-what-gathering
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering unknown)
    =>
    (printout t "Question: What type of gathering?" crlf)
    (printout t "Pick one: beach_bbq, art_opening, get_together, bachelor, dinner: ")
    (bind ?answer (read))
    (assert (what-gathering ?answer))
)

(defrule ask-who-cooks
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering dinner)
    (who-cooks unknown)
    =>
    (printout t "Question: Who is cooking?" crlf)
    (printout t "Type 'me' or 'them':")
    (bind ?answer (read))
    (assert (who-cooks ?answer))
)

(defrule ask-know-them
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering get_together)
    (know-them unknown)
    =>
    (printout t "Question: Do you know them?" crlf)
    (printout t "Type 'yes' or 'no':")
    (bind ?answer (read))
    (assert (know-them ?answer))
)

(defrule ask-wine-lover-2
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering get_together)
    (know-them yes)
    (wine-lover-2 unknown)
    =>
    (printout t "Question: are they wine lovers?" crlf)
    (printout t "Type 'yes' or 'no':")
    (bind ?answer (read))
    (assert (wine-lover-2 ?answer))
)

; ---- PERSONAL USE ----
(defrule ask-you-at-home
    (whos-drinking myself) 
    (you-at-home unknown)
    =>
    (printout t "Question: Are you at home?" crlf)
    (printout t "Type 'yes' or 'no': ")
    (bind ?answer (read))
    (assert (you-at-home ?answer))
)

(defrule ask-you-alone
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone unknown)
    =>
    (printout t "Question: Are you alone?" crlf)
    (printout t "Type 'yes' or 'no': ")
    (bind ?answer (read))
    (assert (you-alone ?answer))
)

(defrule ask-recovering-from-work
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work unknown)
    =>
    (printout t "Question: Recovering from work?" crlf)
    (printout t "Type 'yes' or 'no': ")
    (bind ?answer (read))
    (assert (recovering-from-work ?answer))
)

; ------------ RECOMMENDATIONS ------------

; Recommendation: not a wine lover -> they don't deserve wine. 
(defrule recommend-nothing
    (whos-drinking friend)
    (or (and (gathering no)
             (or (wine-lover no)                                   
                 (and (wine-lover yes) (really-know-them no))
                 (and (wine-lover yes) (really-know-them yes) (your-favorite no))))
        (and (gathering yes) (what-gathering get_together) (know-them yes) (wine-lover-2 yes) (your-favorite no)))
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: They don't deserve any wine." crlf)
    (printout t "========================" crlf)
)

(defrule 2-recommend-nothing
    (whos-drinking friend) 
    (gathering yes)
    (or (and (what-gathering dinner) (who-cooks me))
        (and (what-gathering get_together) (know-them yes) (wine-lover-2 no)))
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: They don't deserve any wine." crlf)
    (printout t "========================" crlf)
)

; Recommendation: California pinot noir
(defrule recommend-california-pinot-noir
    (whos-drinking friend)
    (or (and (gathering no) (wine-lover yes) (really-know-them yes))
        (and (gathering yes) (what-gathering get_together) (know-them yes) (wine-lover-2 yes)))
    (your-favorite yes)
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: California pinot noir." crlf)
    (printout t "========================" crlf)
)


; Recommendation: whisky or vodka
(defrule recommend-whisky-vodka
    (whos-drinking friend)
    (gathering yes)
    (what-gathering bachelor)
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: Forget about the wine. Bring whisky or vodka. Or both :P" crlf)
    (printout t "========================" crlf)
)

; Recommendation: 2 buck chuck
(defrule recommend-buck-chuck
    (whos-drinking friend)
    (gathering yes)
    (what-gathering art_opening)
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: They rarely have a sense of taste. Pick 2-buck chuck" crlf)
    (printout t "========================" crlf)
)

; Recommendation: no glass on the beach
(defrule recommend-glass-on-beach
    (whos-drinking friend)
    (gathering yes)
    (what-gathering beach_bbq)
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: Can't drink on the beach. The glass will be confiscated." crlf)
    (printout t "========================" crlf)
)

; Recommendation: pinot noir
(defrule recommend-pinot-noir
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work yes)
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: Sniff your glass of pinot noir" crlf)
    (printout t "========================" crlf)
)

; Recommendation: red blend
(defrule recommend-red-blend
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering dinner)
    (who-cooks them)
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: Buy the biggest red blend bottle." crlf)
    (printout t "========================" crlf)
)

; Recommendation: boring bottle
(defrule recommend-boring-bottle
    (whos-drinking friend) 
    (gathering yes)
    (what-gathering get_together)
    (know-them no)
    =>
    (printout t "========================" crlf)
    (printout t "Recommendation: Bring boring bottle." crlf)
    (printout t "========================" crlf)
)