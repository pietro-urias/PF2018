(require 2htdp/image)
(require 2htdp/universe)


;Prologues: How to Program
;Author:    Victoria Maria Veloso Rodrigues


#|
> (+ 1 1)
2
> (+ 2 2)
4
> (* 3 3)
9
> (- 4 2)
2
> (/ 6 2)
3
|#
#|
> (+ 2 (+ (* 3 3) 4))
15
> (+ 2 (+ (* 3 (/ 12 4)) 4))
15
> (+ (* 5 5) (+ (* 3 (/ 12 4)) 4))
38

> (+ 1 2 3 4 5 6 7 8 9 0)
45
> (* 1 2 3 4 5 6 7 8 9 0)
0

> "hello world"
"hello world"
> (string-append "hello" "world")
"helloworld"
> (string-append "hello " "world")
"hello world"
> (+ (string-length "hello world") 20)
(number->string 42)
31
"42"
> (string->number "42")
42
> (string->number "hello world")
#false

> (> 10 9)
#true
> (< -1 0)
#true
> (= 42 9)
#false
> (>= 10 10)
#true
> (<= -1 0)
#true
> (string=? "design" "tinker")
#false
> (and (or (= (string-length "hello world")
            (string->number "11"))
         (string=? "hello world" "good morning"))
     (>= (+ (string-length "hello world") 60) 80))
#false

> (* (image-width .) (image-height  .))
4420
> (circle 10 "solid" "red")
.
> (rectangle 30 20 "outline" "blue")
.
> (overlay (circle 5 "solid" "red")
           (rectangle 20 20 "solid" "blue"))
.
> (overlay (rectangle 20 20 "solid" "blue")
           (circle 5 "solid" "red"))

.
> (image-width (square 10 "solid" "red"))
10
> (image-width
    (overlay (rectangle 20 20 "solid" "blue")
             (circle 5 "solid" "red")))
20
> (place-image (circle 5 "solid" "green")
             50 80
             (empty-scene 100 100))
.
|#
(define BATGIRL "../T1/20145-2-batgirl-free-download-thumb.png")


(define (y x) (* x x))
#|
> (y 1)
1
> (y 2)
4
> (y 3)
9
> (y 4)
16
> (y 5)
25

> (empty-scene 100 60)
.

> (place-image BATGIRL 50 23 (empty-scene 100 60))
.

> (place-image BATGIRL 50 20 (empty-scene 100 60))
.

> (place-image BATGIRL 50 30 (empty-scene 100 60))
.

> (place-image BATGIRL 50 40 (empty-scene 100 60))
.
|#



(define (picture-of-batgirl height)
  (place-image BATGIRL  50 height (empty-scene 100 60)))

#|
> (picture-of-batgirl 0)
.
> (picture-of-batgirl 10)
.
> (picture-of-batgirl 20)
.
> (picture-of-batgirl 30)

.
> (animate picture-of-batgirl)
67
|#



(animate picture-of-batgirl)

(define (sign x)
  (cond
    [(> x 0) 1]
    [(= x 0) 0]
    [(< x 0) -1]))
#|
> (sign 10)
1
> (sign -5)
-1
> (sign 0)
0
|#

(define (picture-of-batgirl.v2 height)
  (cond
    [(<= height 60)
     (place-image BATGIRL 50 height
                  (empty-scene 100 60))]
    [(> height 60)
     (place-image BATGIRL 50 60
                  (empty-scene 100 60))]))
#|
> (picture-of-batgirl 5555)
.
> (picture-of-batgirl.v2 5555)
.
> (animate picture-of-batgirl.v2)
41
|#


(animate picture-of-batgirl.v2)

(- 60 (/ (image-height BATGIRL) 2))

(place-image BATGIRL 50 (- 60 (/ (image-height BATGIRL) 2))
             (empty-scene 100 60))

(- 60 (/ (image-height BATGIRL) 2))

(define (picture-of-batgirl.v3 height)
  (cond
    [(<= height (- 60 (/ (image-height BATGIRL) 2)))
     (place-image BATGIRL 50 height
                  (empty-scene 100 60))]
    [(> height (- 60 (/ (image-height BATGIRL) 2)))
     (place-image BATGIRL 50 (- 60 (/ (image-height BATGIRL) 2))
                  (empty-scene 100 60))]))


(animate picture-of-batgirl.v3)
;> (animate picture-of-batgirl.v3)
;67

(define (picture-of-batgirl.v4 h)
  (cond
    [(<= h (- HEIGHT (/ (image-height BATGIRL) 2)))
     (place-image BATGIRL 50 h (empty-scene WIDTH HEIGHT))]
    [(> h (- HEIGHT (/ (image-height BATGIRL) 2)))
     (place-image BATGIRL
                  50 (- HEIGHT (/ (image-height BATGIRL) 2))
                  (empty-scene WIDTH HEIGHT))]))
#|
(define WIDTH 100)
(define HEIGHT 400)

(animate picture-of-batgirl.v4)

(define BATGIRL-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))


(define CENTER 100)
(define HEIGHT (* 2 CENTER))
|#
#|
; constants 
(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT))

(define BATGIRL-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))
 
; functions
(define (picture-of-batgirl.v5 h)
  (cond
    [(<= h BATGIRL-CENTER-TO-TOP)
     (place-image BATGIRL 50 h MTSCN)]
    [(> h BATGIRL-CENTER-TO-TOP)
     (place-image BATGIRL 50 BATGIRL-CENTER-TO-TOP MTSCN)]))
|#
;posso mudar o programa para criar uma cena de 200 por 400
;trocando o valor das constantes WIDTH e HEIGHT
#|
> (overlay (circle 10 "solid" "pink")
         (rectangle 40 4 "solid" "blue"))

.
(define (picture-of-batgirl height)
  (place-image BATGIRL 50 height (empty-scene 100 60 "blue")))


|#
#|
(define (picture-of-batgirl.v7 t)
  (cond
    [(<= t BATGIRL-CENTER-TO-TOP)
     (place-image BATGIRL 50 t MTSCN)]
    [(> t BATGIRL-CENTER-TO-TOP)
     (place-image BATGIRL
                  50 BATGIRL-CENTER-TO-TOP
                  MTSCN)]))

(animate picture-of-batgirl.v7)
|#

#|
(define V 3)
 
(define (distance t)
  (* V t))

|#

; properties of the "world" and the descending rocket
(define WIDTH  100)
(define HEIGHT  300)
(define V 3)
(define X 50)
 
; graphical constants 
(define MTSCN  (empty-scene WIDTH HEIGHT))

(define BATGIRL-CENTER-TO-TOP
  (- HEIGHT (/ (image-height BATGIRL) 2)))
 
; functions
(define (picture-of-batgirl.v6 t)
  (cond
    [(<= (distance t) BATGIRL-CENTER-TO-TOP)
     (place-image BATGIRL X (distance t) MTSCN)]
    [(> (distance t) BATGIRL-CENTER-TO-TOP)
     (place-image BATGIRL X BATGIRL-CENTER-TO-TOP MTSCN)]))
 
(define (distance t)
  (* V t))

(animate picture-of-batgirl.v6)
;> (animate picture-of-batgirl.v6)
;101
