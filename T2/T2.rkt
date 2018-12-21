;Author:    Victoria Maria Veloso Rodrigues
;E-mail:    vicmrodrigues@hotmail.com

;1)
(define x 3)
(define y 4)

(define (distancia x y)
  (sqrt(+(* x x) (* y y))))
#|
> (distancia x y)
5
|#

;2)
(define prefix "hello")
(define suffix "world")

#|
> (string-append prefix (string-append "_" suffix))
"hello_world"
|#

;3)
(define str "helloworld")
(define i 5)

(string-append (string-ith str 0)(string-append (string-ith str 1)(string-append (string-ith str 2)
(string-append (string-ith str 3)(string-append (string-ith str 4) (string-append "_" (string-append (string-ith str 5)
(string-append (string-ith str 6) (string-append (string-ith str 7) (string-append (string-ith str 8) (string-ith str 9)))))))))))


;4)
(string-append (string-ith str 0)(string-append (string-ith str 1)(string-append (string-ith str 2)
(string-append (string-ith str 3)(string-append (string-ith str 4)(string-append (string-ith str 6) 
(string-append (string-ith str 7) (string-append (string-ith str 8) (string-ith str 9)))))))))

;5)
;a)
#|
(overlay/offset (overlay/offset (rectangle 60 40 "solid" "black")
                                  -32 28
                                  (circle 10 "solid" "darkorange"))
                  33 24
                  (circle 10 "solid" "darkorange"))
.
|#

;b)
#|
(overlay/align "middle" "bottom"
                 (rectangle 80 30 "solid" "orange")
                 (ellipse 30 60 "solid" "purple"))
.
|#
;c)
#|
(underlay/align "middle" "top"
                  (rectangle 10 60 "solid" "orange")
                  (ellipse 60 30 "solid" "green"))

.
|#

;6)
(define cat "../T2/cat.png")
#|
 (image-width cat)
 (image-height cat)


320
310
|#

;7)
(define sunny #true)
(define friday #false)

#|
> (and friday sunny)
#false
|#

;8)
#|
(define (grande a)
(if (> (image-width cat) a)
    "wide"
    "tall"))
|#

;9)
(define a "hello")

(define (convert a)
  (if  (string? a)
       (string-length a)
       (if (image? a)
           (* (image-width a) (image-height a))
           (if (number? a)
               (if (>= 0 a)
                   "olha, não dá"
                   (- a 1))
                   (if (and #true a)
                       10
                       20)))))

#|
> (convert #true)
10
> (convert #false)
20
> (convert 4)
3
> (convert "alo")
3
> 
|#
                   
;11)
#|
(define (distancia x y)
  (sqrt(+(* x x) (* y y))))
|#

;12)
(define (volume l)
  (* l l l))
#|
> (volume 3)
27
|#

;13)
(define (string-first strin)
  (string-ith strin 0))
#|
> (string-first "hello")
"h"
|#

;14)
(define (string-last strin)
  (string-ith strin (string-length "hello")))
#|
> (string-last "hello")
string-ith: expected an exact integer in [0, 5) (i.e., less than the length of the given string) for the second argument, but received 5
|#


;15)
(define (func friday sunny)
  (if (or (and #true friday) (and #false sunny))
      #true
      #false))
#|
> (func #true #true)
#true
> (fun #false #false)
fun: this function is not defined
> (func #false #false)
#false
|#

;16)
(define (image-area ima)
  (* (image-width a) (image-height a))) 

;17)
(define (grande a)
(if (> (image-width cat) a)
    "wide"
    (if (equal? (image-width cat) a)
        "square"
        "tall")))
;18)
(define (string-join prefix sufix)
  (string-append prefix (string-append "_" suffix)))

;19)
(define (string-insert str i)
  (string-append (substring str 0 i) 
  (string-append "_" (substring str i
  (string-length str)))))
#|
> (string-insert "helloworld" 5)
"hello_world"
|#

;20)
(define (string-delete str i)
  (string-append (substring str 0 i)
  (substring str (+ i 1)
  (string-length str))))
#|
> (string-delete "hello_world" 5)
"helloworld"
|#

;21)
#|
(define (ff a) (* 10 a))
(ff (ff 1)) 
(+ (ff 1) (ff 1))
**********stepper***********
(ff (* 10 1))
(ff 10)
(* 10 10)
100

(+ (* 10 1) (ff 1))
(+ 10 (ff 1))
(+ 10 (* 10 1))
(+ 10 10)
20
Ele não reutiliza os resultaods de operações já feitas
|#

;22)
#|
(define (distance-to-origin x y)
(sqrt (+ (sqr x) (sqr y))))
(distance-to-origin 3 4)

*************stepper************
(sqrt
 (+ (sqr 3) (sqr 4)))
(sqrt (+ 9 (sqr 4)))
(sqrt (+ 9 16))
(sqrt 25)
5
Sim
|#

;23)
#|
(define (string-first s)
(substring s 0 1))
(string-first "hello")

****************stepper***********
(substring "hello" 0 1)
"h"
Ela pega a primeira parte da string, o "h"
|#

;24)
#|
(define (==> x y)
(or (not x) y))
(==> #true #false)

*************stepper**********
(or (not #true) #false)
(or #false #false)
#false
|#

;25)
#|
(define (image-classify img)
(cond
[(>= (image-height img) (image-width img))
"tall"]
[(= (image-height img) (image-width img))
"square"]
[(<= (image-height img) (image-width img))
"wide"]))
(image-classify (circle 3 "solid" "red"))

não sugere
|#

;26)
#|
(define (string-insert s i)
(string-append (substring s 0 i)
"_"
(substring s i)))
(string-insert "helloworld" 6)

"hellow_orld"
|#

;27)
#|
(define pessoas 120)
(define variagente 15)
(define preco 5.0)
(define cent 0.1)
(define custo 180)
(define custoppessoa 0.04)

(define (attendees ticket-price)
(- pessoas (* (- ticket-price preco) (/ variagente cent))))

(define (revenue ticket-price)
(* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
(+ custo (* custoppessoa (attendees ticket-price))))

(define (profit ticket-price)
(- (revenue ticket-price)
(cost ticket-price)))

> (profit 1)
511.2
> (profit 2)
937.2
> (profit 3)
1063.2
> (profit 4)
889.2
> (profit 5)
415.2
|#

;28)
#|
(define (profit price)
(- (* (+ 120
(* (/ 15 0.1)
(- 5.0 price)))
price)
(+ 180
(* 0.04
(+ 120
(* (/ 15 0.1)
(- 5.0 price)))))))

> (profit 1)
511.2
> (profit 2)
937.2
> (profit 3)
1063.2     ************lucro máximo com ingresso a $3
> (profit 4)
889.2
> (profit 5)
415.2

|#

;29)
#|
(define pessoas 120)
(define variagente 15)
(define preco 5.0)
(define cent 0.1)
(define custoppessoa 1.5)

(define (attendees ticket-price)
(- pessoas (* (- ticket-price preco) (/ variagente cent))))

(define (revenue ticket-price)
(* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
 (* custoppessoa (attendees ticket-price)))

(define (profit ticket-price)
(- (revenue ticket-price)
(cost ticket-price)))

> (profit 3)
630
> (profit 4)
675
> (profit 5)
420

(define (profit price)
(- (* (+ 120
(* (/ 15 0.1)
(- 5.0 price)))
price)
(* 1.5
(+ 120
(* (/ 15 0.1)
(- 5.0 price))))))

> (profit 3)
630
> (profit 4)
675
> (profit 5)
420

O lucro diminuiu comparado com o método anterior
|#

;30)
#|
(define VARIACAO (/ variagente cent))

> (profit 3)
630
|#

;31)
(require 2htdp/batch-io)
#|
> (write-file "sample.dat" "212")
"sample.dat"
> (read-file "sample.dat")
"212"
> (write-file 'stdout "212\n")
212
'stdout

(define (main in-fst in-lst in-signature out)
(write-file out
(letter (read-file in-fst)
(read-file in-lst)
(read-file in-signature))))

foi como o esperado
|#
