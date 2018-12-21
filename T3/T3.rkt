;Author:    Victoria Maria Veloso Rodrigues
;E-mail:    vicmrodrigues@hotmail.com

(require 2htdp/universe)
(require 2htdp/image)
#|
#|
33)
Para economizar memória e processamento, os sistemas armazenavam exibiam dados de forma resumida.
Um desses dados reduzidos era o ano, sistemas assi velhos processavam apenas os dois últimos algarismos do ano.
O "bug do milênio" ocorreu porque esses softwares não fora capazes de processar a virada do milênio e "voltaram" para 1900. 
|#

;34)
(define str "Asneira")
(define n (string-length str))

(define (string-first str)
  (string-ith str 0))
#|
> (string-first str)
"A"
> 
|#

;35)
(define(string-last str n)
  (string-ith str (- n 1)))
#|
> (string-last str n)
"a"
|#

;36)
(define (image-area img)
  (* (image-width img) (image-height img)))

#|
> (image-area .)
3600
|#

;37)
(define (string-rest str n)
  (substring str 1 n))
#|
> (string-rest str n)
"sneira"
|#
;38)
(define (string-remove str n)
  (substring str 0 (- n 1)))
#|
>  (string-remove str n)
"Asneir"
|#

;39)
(define CAR .)

;(define BACKGROUND (empty-scene 100 100))


(define WIDTH-OF-WORLD 200)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
(circle WHEEL-RADIUS "solid" "black"))

(define SPACE
(rectangle 4 5 WHEEL-RADIUS "white"))
(define BOTH-WHEELS
(beside WHEEL SPACE WHEEL))


;(define (render x)
 ;   BACKGROUND)
;(define (tock x)
;(+ x 3))
#|
(define (main ws)
(big-bang ws
[on-tick tock]
[to-draw render]))
|#
;(main 90)
(define (tamanho x)
(scale x WHEEL))
#|
> (scale 2 WHEEL)
.
> (tamanho 2)
.
|#
;BACKGROUND: this variable is not defined


;40)
#|
(define BACKGROUND (empty-scene 250 50))

(define (render x)
(place-image CAR x 40 BACKGROUND))

(check-expect (render 50) .)

(check-expect (render 100) .)

(check-expect (render 150) .)

(check-expect (render 200) .)

|#
;All 4 tests passed!


;41)
(define tree
(underlay/xy (circle 10 "solid" "green")
9 15
(rectangle 2 20 "solid" "brown")))

(define (desenho x)
  (place-image tree x 40 BACKGROUND))
#|
(define (main ws)
(big-bang ws
[on-tick tock]
[to-draw desenho]))

> (main 20)
20
|#

;42)
#|
(define final (image-width BACKGROUND))

(define (maislonge x)
(place-image CAR final 40 BACKGROUND))

> (maislonge 2)
.
|#
;43)
(define BACKGROUND (empty-scene 250 100))
(define (render x)
(place-image CAR x 40 BACKGROUND))
#|
(define (main1 ws)
(big-bang ws
[on-tick tock]
[to-draw render]))

> (main1 200)
200
|#


(define (hyper x-position-of-car x-mouse y-mouse me)
(cond
[(string=? "button-down" me) x-mouse]
[else x-position-of-car]))
#|
(define (main ws)
(big-bang ws
[on-tick tock]
[on-mouse hyper]
[to-draw render]))

;> (main1 1)
;318
|#

;45)
(define cat1 "../T2/cat.png")
#|
(define (coloca x)
(place-image cat1 x 40 BACKGROUND))

(define (border x)
  (if (equal? x 300)
      (- 295 x)
      x))

(define (tock x)
(if (equal? x 300)
      (- x 299)
      (+ x 3)))

(define (main2 ws)
(big-bang ws
[on-tick tock]
[to-draw coloca]))
|#
;47)

(define (tock s)
  (+ s 1))

(define (reset s ke)
(cond
  [(equal? ke "up") (- s 0.3)]
  [(equal? ke "up") (- s 0.1)]))

(define (number->square s)
(square s "solid" "red"))

(define (main3 ws)
(big-bang ws
[to-draw number->square]
[on-tick tock ]
[on-key reset]))
|#
;48)
(define (reward s)
(cond
[(<= 0 s 10) "bronze"]
[(and (< 10 s) (<= s 20)) "silver"]
[else "gold"]))
(reward 18)

;49)
#|
(define WIDTH 100)
(define HEIGHT 60)
(define MTSCN (empty-scene WIDTH HEIGHT))
(define ROCKET .)
(define ROCKET-CENTER-TO-TOP
(- HEIGHT (/ (image-height ROCKET) 2)))

(define (create-rocket-scene.v5 h)
(cond
[(<= h ROCKET-CENTER-TO-TOP)
(place-image ROCKET 50 h MTSCN)]
[(> h ROCKET-CENTER-TO-TOP)
(place-image ROCKET 50 ROCKET-CENTER-TO-TOP MTSCN)]))

(create-rocket-scene.v5 100)
(create-rocket-scene.v5 210)

.
.
|#
;50)
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

(define (traffic-light-next s)
(cond
[(string=? "red" s) "green"]
[(string=? "green" s) "yellow"]
[(string=? "yellow" s) "red"]))





;52)
;3, 4, 5
; 4, 5
;3, 4
;4


;54)
(define HEIGHT 300) ; distances in pixels
(define WIDTH 100)
(define YDELTA 3)
(define BACKG (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define CENTER (/ (image-height ROCKET) 2))

(define (poeNoMeio x)
  (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(define (show x)
(cond
[(string? x)
(poeNoMeio x)]
[(<= -3 x -1)
(place-image (text (number->string x) 20 "red")
10 (* 3/4 WIDTH)
(poeNoMeio x))]
[(>= x 0)
(poeNoMeio x)]))


#|
> (show -3)
.
> (show "resting")
.
|#

;56)
(define BATGIRL-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

(define (desenho t)
  (cond
    [(>= t BATGIRL-CENTER-TO-TOP)
     (place-image ROCKET 50 BATGIRL-CENTER-TO-TOP BACKG)]
    [(< t BATGIRL-CENTER-TO-TOP)
     (place-image ROCKET
                  50 t
                  BACKG)]))

(define (toc x)
  (- x 1))

(define (main2 ws)
(big-bang ws
[on-tick toc]
[to-draw desenho]
[stop-when zero?]))

;(main2 HEIGHT)

;58)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))

;All 6 tests passed!

(define luxo 10000)
(define tax-maior 0.08)
(define tax-menor 0.05)
(define soCaroMesmo 1000)
(define deGraça 0)

(define (sales-tax p)
(cond
[(and (<= deGraça p) (< p soCaroMesmo)) deGraça]
[(and (<= soCaroMesmo p) (< p luxo)) (* tax-menor p)]
[(>= p luxo) (* tax-maior p)]))

;59)
(define RED (beside  (circle 10 "solid" "red")
         (circle 10 "outline" "yellow")
         (circle 10 "outline" "green")))

(define YELLOW (beside  (circle 10 "outline" "red")
         (circle 10 "solid" "yellow")
         (circle 10 "outline" "green")))

(define GREEN (beside  (circle 10 "outline" "red")
         (circle 10 "outline" "yellow")
         (circle 10 "solid" "green")))


(define sinal-vermelho (place-image RED 35 20(empty-scene 70 40)))

(define sinal-amarelo (place-image YELLOW 35 20(empty-scene 70 40)))

(define sinal-verde (place-image GREEN 35 20(empty-scene 70 40)))

(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

(define (tl-render cs)
  (cond
   [(= cs 0) RED]
   [(= cs 1) GREEN]
   [(= cs 2) YELLOW]))

(define (traffic-light-simulation initial-state)
(big-bang initial-state
[to-draw tl-render]
[on-tick tl-next-numeric 1]))

;60) Sim pois limita ps números de 0 a 2
;61) Ajuda

;62)
(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")
(define OPEN1 "open")
(define OPEN2 "open")

(define (door-closer state-of-door)
(cond
[(string=? LOCKED state-of-door) LOCKED ]
[(string=? CLOSED state-of-door) CLOSED ]
[(string=? OPEN state-of-door) OPEN1 ]
[(string=? OPEN state-of-door) OPEN2 ]
[(string=? OPEN state-of-door) CLOSED ]))

(define (door-actions s k)
(cond
[(and (string=? LOCKED s) (string=? "u" k))
CLOSED]
[(and (string=? CLOSED s) (string=? "l" k))
LOCKED]
[(and (string=? CLOSED s) (string=? " " k))
OPEN]
[else s]))

(check-expect (door-actions LOCKED "u") CLOSED)

(define (door-render s)
(text s 40 "red"))

(check-expect (door-render CLOSED)
(text CLOSED 40 "red"))

(define (door-simulation initial-state)
(big-bang initial-state
[on-tick door-closer]
[on-key door-actions]
[to-draw door-render]))

;63)
;5
;10
;130

;64)
(define (manhattan-distance x y)
  (sqrt(+ (* x x) (* y y))))
;65)
#|
constructors:make-entry 
selectors: entry-title, entry-name, entry-artist, entry-material, entry-producer, entry-hair, entry-size, entry-number
predicates: entry? 
|#

;66)
#|
(define-struct movie [title producer year])
(make-entry "BvS" "Mrs.Snyder" "2016")
         
|#
#|
;67)
(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

;68)
(define-struct ballf [x y deltax deltay])
(make-entry "10" "10" "5" "2")
|#
