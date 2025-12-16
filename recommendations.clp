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
    (or (and 
            (whos-drinking friend)
            (or (and (gathering no) (wine-lover yes) (really-know-them yes))
                (and (gathering yes) (what-gathering get_together) (know-them yes) (wine-lover-2 yes)))
            (your-favorite yes)
        )
        (and
            (whos-drinking myself) 
            (you-at-home no)
            (on-the-go special_occasions)
            (or
                (and
                    (special-occasions anniversary)
                    (anniversary 1st)
                )
                (and
                    (special-occasions birthday)
                    (birthday old)
                )
            )
        )
    )
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

(defrule recommend-zinfandel
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk yes)
    =>
    (assert (recommendation "RECOMMENDATION|Go for high octane: zinfandel or shiraz."))
)

(defrule recommend-sangiovese
(and
  (whos-drinking myself)
  (or
    ;; HOME BRANCH
    (and
      (you-at-home yes)
      (you-alone yes)
      (recovering-from-work no)
      (getting-drunk no)
      (feeling-fancy yes)
    )

    (and
      (you-at-home no)
      (on-the-go new_years)
      (special-occasions new_years)
      (new-years alone)
    )

    (and
      (you-at-home no)
      (on-the-go dinner)
      (wine-main-course yes)
    )
  )
)
    =>
    (assert (recommendation "RECOMMENDATION|Go for something exotic: sangiovese or grenache."))
)

(defrule recommend-argentinian-malbec
    (whos-drinking myself)
    (or (and (you-at-home yes) (you-alone yes) (recovering-from-work no) (getting-drunk no) (feeling-fancy no) (daily-drinking yes))
        (and (you-at-home no) (on-the-go dinner) (wine-main-course no) (microwave-dinner no) (cook-with-wife no)))
    (kool-aid yes)
    =>
    (assert (recommendation "RECOMMENDATION|Fruit forward wine: argentinian malbec."))
)

(defrule recommend-chinon
    (whos-drinking myself)
    (or (and (you-at-home yes) (you-alone yes) (recovering-from-work no) (getting-drunk no) (feeling-fancy no) (daily-drinking yes))
        (and (you-at-home no) (on-the-go dinner) (wine-main-course no) (microwave-dinner no) (cook-with-wife no)))
    (kool-aid no)
    (eat-dirt yes)
    =>
    (assert (recommendation "RECOMMENDATION|Something earthy: chinon or bourgueil."))
)

(defrule recommend-buttery
    (whos-drinking myself)
    (or (and (you-at-home yes) (you-alone yes) (recovering-from-work no) (getting-drunk no) (feeling-fancy no) (daily-drinking yes))
        (and (you-at-home no) (on-the-go dinner) (wine-main-course no) (microwave-dinner no) (cook-with-wife no)))
    (kool-aid no)
    (eat-dirt no)
    (spray-butter yes)
    =>
    (assert (recommendation "RECOMMENDATION|Please bring me my: buttery chardonnay."))
)

(defrule recommend-get-out
    (whos-drinking myself)
    (or (and (you-at-home yes) (you-alone yes) (recovering-from-work no) (getting-drunk no) (feeling-fancy no) (daily-drinking yes))
        (and (you-at-home no) (on-the-go dinner) (wine-main-course no) (microwave-dinner no) (cook-with-wife no)))
    (or (and (kool-aid no) (eat-dirt no) (spray-butter no))
        (and (daily-drinking no) (new-old what)))
    =>
    (assert (recommendation "RECOMMENDATION|Thx for playing, now get out of my program!"))
)

(defrule recommend-bordeaux
    (whos-drinking myself) 
    (you-at-home yes)
    (you-alone yes)
    (recovering-from-work no)
    (getting-drunk no)
    (feeling-fancy no)
    (daily-drinking no)
    (new-old old)
    =>
    (assert (recommendation "RECOMMENDATION|Why buy anything but bordeaux or burgundy."))
)

(defrule recommend-california-cabernet
    (and
        (new-old new)
        (into-cults no)
        (or
            (and
                (whos-drinking myself) 
                (you-at-home yes)
                (you-alone yes)
                (recovering-from-work no)
                (getting-drunk no)
                (feeling-fancy no)
                (daily-drinking no)
            )
            (and
                (whos-drinking myself) 
                (you-at-home no)
                (on-the-go restaurant)
                (restaurant fancy)
                (menu-pronounceable yes)
            )
        )
    )
    =>
    (assert (recommendation "RECOMMENDATION|Drink a bottle of sun california cabernet"))
)

(defrule recommend-sine-qua
    (and
        (new-old new)
        (into-cults yes)
        (or
            (and
                (whos-drinking myself) 
                (you-at-home no)
                (on-the-go restaurant)
                (restaurant fancy)
                (menu-pronounceable yes)
            )    
            (and    
                (whos-drinking myself) 
                (you-at-home yes)
                (you-alone yes)
                (recovering-from-work no)
                (getting-drunk no)
                (feeling-fancy no)
                (daily-drinking no)
            )
        )
    )
    =>
    (assert (recommendation "RECOMMENDATION|Cult classic: sine qua non or cayuse"))
)

(defrule recommend-merlot
    (whos-drinking myself) 
    (you-at-home no)
    (on-the-go special_occasions)
    (special-occasions anniversary)
    (anniversary 2+)
    =>
    (assert (recommendation "RECOMMENDATION|Merlot."))
)

(defrule recommend-riesling-or-chenin-blanc
    (and
        (whos-drinking myself) 
        (you-at-home no)
        (on-the-go special_occasions)
        (or
            (special-occasions eloping)
            (and
                (special-occasions birthday)
                (birthday young)
            )
            (special-occasions blind_date)
        )
    )
    =>
    (assert (recommendation "RECOMMENDATION|Something Sweet: Riesling or Chenin Blanc."))
)

(defrule recommend-spanish-cava
    (whos-drinking myself) 
    (you-at-home no)
    (on-the-go special_occasions)
    (special-occasions new-years)
    (new-years alone)
    =>
    (assert (recommendation "RECOMMENDATION|Cheap Bubbly: Spanish Cava."))
)

(defrule recommend-single_serve_box_wine
    (and
        (whos-drinking myself) 
        (you-at-home no)
        (or
            (on-the-go camping)
            (on-the-go drinking_in_public)
        )
    )
    =>
    (assert (recommendation "RECOMMENDATION|No Cork Screw Red: Single Serve Box Wine."))
)

(defrule recommend-cotes_du_rhone
    (whos-drinking myself) 
    (you-at-home no)
    (on-the-go restaurant)
    (restaurant not_fancy)
    (pronounceable-menu no)
    =>
    (assert (recommendation "RECOMMENDATION|Ask for: Cotes de Rhone."))
)

(defrule recommend-3liter-box
    (whos-drinking myself) 
    (you-at-home no)
    (on-the-go dinner)
    (wine-main-course no)
    (microwave-dinner yes)
    =>
    (assert (recommendation "RECOMMENDATION|3 liter box wine."))
)

(defrule recommend-blanc
    (whos-drinking myself) 
    (you-at-home no)
    (on-the-go dinner)
    (wine-main-course no)
    (microwave-dinner no)
    (cook-with-wife yes)
    =>
    (assert (recommendation "RECOMMENDATION|Sauvignon blanc."))
)