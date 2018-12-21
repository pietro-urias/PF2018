
(require 2htdp/image)
(require 2htdp/universe)


(define GAME-OVER "../spaceInvaders/imagens/game-over.png")
(define START "../spaceInvaders/imagens/start.png" )
(define WIN "../spaceInvaders/imagens/win.png")
(define ZERO 0)
(define ONE 1)
(define TWO 2)
(define TEXT-SIZE 28)
(define START-SIZE 100)
(define SSHIP-MOVE-UNIT 10)
(define ROW-NUM-INVADER 7)
(define COL-NUM-INVADER 12)
(define BULLET-RADIUS 9)
(define BULLET-RED (rectangle 5 BULLET-RADIUS 'solid "green"))
(define BULLET-BLK (rectangle 5 BULLET-RADIUS 'solid "white"))
(define BULLET-MAX-INVADER 8)
(define BULLET-MAX-SPACESHIP 50)
(define INVADER-LENGTH 15)
(define INVADER-RECT1 (scale 1.5 "../spaceInvaders/imagens/nave2a.jpg"))
(define INVADER-RECT2 (scale 1.5 "../spaceInvaders/imagens/nave2b.jpg"))
(define GAP-BETWEEN-ROWS 3)
(define CANVAS-WIDTH (* 2 COL-NUM-INVADER INVADER-LENGTH))
(define CANVAS-HEIGHT 600)
(define BACKGROUND (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "black"))
(define SPACESHIP-L 30)
(define SPACESHIP-W 20)
(define SPACESHIP-RECT (scale 1.2 "../spaceInvaders/imagens/player.jpg"))
(define SPACESHIP-DIR-INIT 'up)
(define MAX-LIVES-MSHIP 1)
(define MAX-LIVES-SSHIP 3)
(define MAX-LIVES-OB 5)
(define MIN-LIVES 0)
(define MIN-SCORE 0)
(define SCORE-HIT-INVDR 5)
(define OBSTACLE1 "../spaceInvaders/imagens/prot1.jpg") 
(define OBSTACLE2  "../spaceInvaders/imagens/prot2.jpg") 
(define OBSTACLE3  "../spaceInvaders/imagens/prot3.jpg") 
(define OBSTACLE4  "../spaceInvaders/imagens/prot4.jpg") 
(define OBSTACLE5  "../spaceInvaders/imagens/prot5.jpg") 
(define OBSTACLE-LENGTH (image-width OBSTACLE5))
(define TICK-0 0)
(define TICK-10 25)
(define TICK-3O 30)
(define TOP-LEFT (make-posn 20 20))
(define MSHIP-RECT  "../spaceInvaders/imagens/nave-mae.jpg")
(define MSHIP-MOVE-LEN 20)
(define SCORE-HIT-MSHIP 20)

;; A Direction is one of
;; - 'left
;; - 'right
;; INTERP: represents the direction of either left or right of the spaceship

;; Deconstructor Template
;; direction-fn: Direction -> ???
#;(define (direction-fn direction)
    (cond
      [(symbol=? direction 'left) ...]
      [(symbol=? direction 'right) ...]))


;;;; Data Definition
(define-struct spaceship [position direction lives])
(define-struct obstacleL [position lives shape])
(define-struct obstacleM [position lives shape])
(define-struct obstacleR [position lives shape])
                                                   

;; Constructor Template:
;; A Spaceship is a (make-spaceship Posn Direction Natural)
;; INTERP: represents a spaceship on the canvas

;; Examples




(define SPACESHIP-INIT (make-spaceship 
                        (make-posn (/ CANVAS-WIDTH 2) (- CANVAS-HEIGHT 20))
                        SPACESHIP-DIR-INIT
                        MAX-LIVES-SSHIP))

(define OBSTACLE-MID (make-obstacleM 
                        (make-posn (/ CANVAS-WIDTH 2) (- CANVAS-HEIGHT 125))
                        MAX-LIVES-OB OBSTACLE1))
             
(define OBSTACLE-LEFT (make-obstacleL 
                        (make-posn (-  (/ CANVAS-WIDTH 2) 150) (- CANVAS-HEIGHT 125))
                        MAX-LIVES-OB OBSTACLE1))

(define OBSTACLE-RIGHT (make-obstacleR 
                        (make-posn (+  (/ CANVAS-WIDTH 2) 150) (- CANVAS-HEIGHT 125))
                        MAX-LIVES-OB OBSTACLE1))




(define SPACESHIP-DEAD (make-spaceship 
                        (make-posn (/ CANVAS-WIDTH 2) (- CANVAS-HEIGHT 20))
                        SPACESHIP-DIR-INIT
                        0))
(define MSHIP-INIT (make-spaceship TOP-LEFT 'right 0))
(define MSHIP-DEAD (make-spaceship TOP-LEFT 'right 0))
(define MSHIP-APPEAR (make-spaceship TOP-LEFT 'right 1))

;;;; Data Definitions:
;; An Invader is a Posn
;; INTERP: represents an invader on the canvas

;; An Bullet is a Posn
;; INTERP: represents a bullet on the canvas

;; An SBullet is a Bullet
;; INTERP: represents a spaceship bullet on the canvas

;; An IBullet is a Bullet
;; INTERP: represents an invader bullet on the canvas

;; A ListOfPosns (LoP) is one of
;; - empty
;; - (cons Posn LoP)
;; INTERP: represents a list of posns



;; Deconstructor Template:
;; lop-fn: LoP -> ???
#; (define (lop-fn lop)
     (cond
       [(empty? lop) ...]
       [(cons? lop) ... (posn-fn (first lop)) ... 
                    ... (lop-fn (rest lop) )...]))


;; A ListOfInvaders (LoI) is a LoF<Invader>
;; INTERP: represents a list of invaders on the canvas



;; Deconstructor Template:
;; loi-fn: LoI -> ???
#; (define (loi-fn loi)
     (cond
       [(empty? loi) ...]
       [(cons? loi) ... (posn-fn (first loi)) ... 
                    ... (loi-fn (rest loi) )...]))

;; A ListOfBullets (LoB) is a LoF<Posn>
;; INTERP: represents a list of bullets on the canvas



;; Deconstructor Template:
;; lob-fn: LoB -> ???
#; (define (lob-fn lob)
     (cond
       [(empty? lob) ...]
       [(cons? lob) ... (posn-fn (first lob)) ... 
                    ... (lob-fn (rest lob) )...]))

;; An SBullets (LoSB) is a LoF<SBullet>
;; represents a list of bullets from the spaceship

;; An IBullets (LoIB) is a LoF<IBullet>
;; represents a list of bullets from invaders

;; A Score is a Natural
;; represents a list of bullets from invaders
(define-struct world 
                [invaders spaceship sbullets ibullets score ticks obstacleL obstacleM obstacleR mothership])

;; Constructor Template:
;; A World is a (make-world LoF<Invader> Spaceship LoF<SBullet> 
;;                          LoF<IBullet> Natural Natural Spaceship obstacle)
;; INTERP: invaders represents invaders in the game
;;         spaceship represents a spaceship in the game
;;         sbullets represents bullets from the spaceship in the game
;;         ibullets represents bullets from invaders in the game
;;         score represents the score of the current game
;;         ticks represents the ticks of the clock
;;         mothership represents a mothership in the game


;;;; Signature
;; first-x: Natural -> Real

;;;; Purpose
;; GIVEN: a natural number representing the number of columns
;; RETURNS: the appropriate x coordinate value for the first invader in a row

(define (first-x cols)
  (/ (- CANVAS-WIDTH (* (- cols ONE) TWO INVADER-LENGTH)) TWO))



;;;; Signature
;; invader-cons-col: Real Real Natural -> LoF<Invader>

;;;; Purpose
;; GIVEN: an x and a y coordinate value and 
;;        a natural number representing the number of columns
;; RETURNS: a list of invaders assigned with appropriate posns

(define (invader-cons-col x y cols)
  (cond
    [(= cols ZERO)	empty]
    [else (cons 
           (make-posn x y) 
           (invader-cons-col 
            (+ x (* TWO INVADER-LENGTH)) y (- cols ONE)))]))  ;2x o tamanho do invasor + x




;;;; Signature
;; invader-cons-row: Real Natural Natural-> LoF<Invader>

;;;; Purpose
;; GIVEN: a y coordinate value, number of rows and number of columns
;; RETURNS: a list of invaders assigned with appropriate posns

(define (invader-cons-row y rows cols)
  (cond
    [(= rows ZERO) empty]
    [else (append 
           (invader-cons-col 
            (first-x cols) y cols) 
           (invader-cons-row 
            (+ y INVADER-LENGTH GAP-BETWEEN-ROWS)   ;yinicial + espaço entre invasores + tamanho do trem
            (- rows ONE)
            cols))]))



;;;; Signature
;; draw-score: Natural Image -> Image

;;;; Purpose
;; GIVEN: a natural number and an image
;; RETURNS: a new image with the score on the given image

(define TOP-CENTER (make-posn (/ CANVAS-WIDTH 2) 15))

(define (draw-score score img)
  (place-image
   (text (number->string score) TEXT-SIZE "white")
   (posn-x TOP-CENTER)
   (posn-y TOP-CENTER)
   img))




;;;; Signature
;;;; draw-lives: Spaceship Image -> Image

;;;; Purpose
;; GIVEN: a natural number and an image
;; RETURNS: a new image with the score on the given image

(define BOTTOM-RIGHT-CORNER (make-posn (- CANVAS-WIDTH  30)
                                       (- CANVAS-HEIGHT 30)))
(define (draw-lives spaceship img)
  (place-image
   (text (number->string (spaceship-lives spaceship)) TEXT-SIZE "red")
   (posn-x BOTTOM-RIGHT-CORNER)
   (posn-y BOTTOM-RIGHT-CORNER)
   img))  


;;;; Signature
;; draw-lopsn: LoP Image Image -> Image

;;;; Purpose
;; GIVEN: a list of posns, a base image to be placed on
;;        and a shape image representing an item we are about to draw
;; RETURNS: an image with all items drawn on the base image

(define (draw-lopsn posns base-img shape-img)
  (local (
          ;;;; draw-posn: Posn Image -> Image
          (define (draw-posn posn image)
            (place-image 
             shape-img
             (posn-x posn)
             (posn-y posn)
             image)))
    (foldl draw-posn base-img posns)))





;;;; Signature
;; draw-invaders: LoF<Invader> Image -> Image

;;;; Purpose
;; GIVEN: a list of invaders and an image
;; RETURNS: a new image with the invaders on the given image


(define (draw-invaders world invaders img)
  (local ((define ticks (world-ticks world)))
     (if (and (not (equal? TICK-0 ticks))
             (equal? ZERO (modulo ticks 8)))
        (draw-lopsn invaders img INVADER-RECT2)
        (draw-lopsn invaders img INVADER-RECT1))))
  


;;;; Signature
;; draw-spaceship: Spaceship Image -> Image

;;;; Purpose
;; GIVEN: a spaceship and an image
;; RETURNS: a new image that draws the spaceship on the given image 

(define (draw-spaceship spaceship img)
  (place-image
   SPACESHIP-RECT
   (posn-x (spaceship-position spaceship))
   (posn-y (spaceship-position spaceship))
   img))


(define (draw-obstacleL obstacleL img)
    (if (> (obstacleL-lives obstacleL) 0)
     (place-image
     (obstacleL-shape obstacleL)
     (posn-x (obstacleL-position obstacleL))
     (posn-y (obstacleL-position obstacleL))
     img)
     img))

(define (draw-obstacleM obstacleM img)
  (if (> (obstacleM-lives obstacleM) 0)
    (place-image
     (obstacleM-shape obstacleM)
     (posn-x (obstacleM-position obstacleM))
     (posn-y (obstacleM-position obstacleM))
     img)
    img))

(define (draw-obstacleR obstacleR img)
  (if (> (obstacleR-lives obstacleR) 0)
    (place-image
     (obstacleR-shape obstacleR)
     (posn-x (obstacleR-position obstacleR))
     (posn-y (obstacleR-position obstacleR))
     img)
    img))

;;;; Signature
;; draw-mothership: Spaceship Image -> Image

;;;; Purpose
;; GIVEN: a mothership and an image
;; RETURNS: a new image with the mothership drawn on the given image

(define (draw-mothership mothership img)
  (place-image
   MSHIP-RECT
   (posn-x (spaceship-position mothership))
   (posn-y (spaceship-position mothership))
   img))



;;;; Signature
;; draw-sbullets: SBullets Image -> Image

;;;; Purpose
;; GIVEN: a list of spaceship bullets and an image
;; RETURNS: a new image that draws the list of 
;;          spaceship bullets on the given image

(define (draw-sbullets sbullets img)
  (draw-lopsn sbullets img BULLET-RED))




;;;; Signature
;; draw-ibullets: IBullets Image -> Image

;;;; Purpose
;; GIVEN: a list of invader bullets and an image
;; RETURNS: a new image that draws the list of 
;;          invader bullets on the given image

(define (draw-ibullets ibullets img)
  (draw-lopsn ibullets img BULLET-BLK))





;;;; Signature
;; draw-world : World -> Image

;;;; Purpose
;; GIVEN: a world 
;; RETURNS: an image representation of the given world 

(define (desenha world)
    (draw-invaders world (world-invaders world)
    (draw-spaceship (world-spaceship world)
      (draw-sbullets (world-sbullets world) 
        (draw-ibullets (world-ibullets world) 
          (draw-lives (world-spaceship world)
            (draw-score (world-score world)
              (draw-obstacleL (world-obstacleL world)
                 (draw-obstacleM (world-obstacleM world)
                    (draw-obstacleR (world-obstacleR world)
                                   (if (= ZERO (spaceship-lives (world-mothership world)))
                                       BACKGROUND
                                       (draw-mothership (world-mothership world) 
                                                        BACKGROUND))))))))))))

(define (draw-world world)
  (cond
    [(or (= (spaceship-lives (world-spaceship world)) ZERO)
      (invaders-reach-btm? (world-invaders world)))
    (place-image GAME-OVER
      (/ CANVAS-WIDTH  2)
      (/ CANVAS-HEIGHT 2)
      (desenha world))]
    [(eq? world WORLD-START)
      (place-image START
      (/ CANVAS-WIDTH  2)
      (/ CANVAS-HEIGHT 2)
      (desenha world))]
    [(eq? (world-invaders world) empty)
     (place-image WIN
      (/ CANVAS-WIDTH  2)
      (/ CANVAS-HEIGHT 2)
      (desenha world))]
     [else (desenha world)]))


;;;; Signature
;; spaceship-reach-left-corner?: Spaceship -> Boolean

;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: true if the spaceship reaches the left corner, false otherwise

(define (spaceship-reach-left-corner? spaceship)
  (<= (- (posn-x (spaceship-position spaceship)) (/ SPACESHIP-L TWO)) ZERO))

 
;;;; Signature
;; spaceship-reach-right-corner?: Spaceship -> Boolean

;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: true if the spaceship reaches the right corner, false otherwise

(define (spaceship-reach-right-corner? spaceship)
  (>= (+ (posn-x (spaceship-position spaceship)) (/ SPACESHIP-L TWO)) 
      CANVAS-WIDTH))


;;;; Signature
;; spaceship-reach-corner?: Spaceship -> Boolean

;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: true if the spaceship reaches the left or right corner, 
;;          false otherwise

(define (spaceship-reach-corner? spaceship)
  (or 
   (spaceship-reach-left-corner?  spaceship)
   (spaceship-reach-right-corner? spaceship)))



;;;; Signature
;; move-spaceship: Spaceship -> Spaceship

;;;; Purpose
;; GIVEN: a spaceship
;; RETURNS: the spaceship after it moves by one unit distance in the
;;          correct direction, or the original spaceship if it reaches corner

(define (move-spaceship spaceship)
  (cond
    [(spaceship-reach-corner? spaceship)  spaceship]
    [(symbol=? (spaceship-direction spaceship) 'left)
     (make-spaceship
      (make-posn (- (posn-x (spaceship-position spaceship)) SSHIP-MOVE-UNIT)
                 (posn-y (spaceship-position spaceship)))
      'left
      (spaceship-lives spaceship))]
    [(symbol=? (spaceship-direction spaceship) 'right)
     (make-spaceship
      (make-posn (+ (posn-x (spaceship-position spaceship)) SSHIP-MOVE-UNIT)
                 (posn-y (spaceship-position spaceship)))
      'right
      (spaceship-lives spaceship))]
     [(symbol=? (spaceship-direction spaceship) 'up)
     (make-spaceship
      (spaceship-position spaceship)
      'up
      (spaceship-lives spaceship))]))




;;;; Signature
;; mothership-stepper: World -> Spaceship

;;;; Purpose
;; GIVEN: the current world
;; RETURNS: the mothership after 1 tick
;;          - if the mothership is hit or goes out of bounds,
;;            it reappears (is reinitialized with 1 life) after 30 ticks
;;          - otherwise, it just moves one step to the right

(define (mothership-stepper world)
  (local ((define mothership (world-mothership world))
          (define ticks (world-ticks world))
          (define posn-init (spaceship-position MSHIP-INIT)))
    (if (or (= (spaceship-lives mothership) ZERO)  ;; mothership is hit or 
            (mothership-out-of-bounds? mothership))  ;; is out of bounds
        (if (and (= (modulo ticks TICK-3O) ZERO)
                 (>= ticks TICK-3O))
            MSHIP-APPEAR                    ;; reappears after 30 ticks
            MSHIP-DEAD)                     ;; remains dead
        (make-spaceship       ;; if not hit, move one step to the right
         (make-posn
          (+ MSHIP-MOVE-LEN (posn-x (spaceship-position mothership)))
          (posn-y posn-init)) 'right ONE))))





;;;; Signature
;; spaceship-step: World Boolean -> Spaceship

;;;; Purpose
;; GIVEN: the current world and a boolean
;;        representing if the mothership is hit by the spaceship
;; RETURNS: 1. a new spaceship after moving one unit to its direction 
;;             if it is not hit and does not hit mothership
;;          2. or a moved spaceship with 1 less life if it is hit
;;          3. or a moved spaceship with 1 more life it it hits the mothership

(define (spaceship-step world mothership-is-hit)
  (local ((define spaceship-orig (world-spaceship world))
          (define moved-spaceship (move-spaceship spaceship-orig)))
    (if (spaceship-is-hit? spaceship-orig (world-ibullets world))
        (make-spaceship  ;; if hit, re-init the spaceship with a life less
         (spaceship-position  SPACESHIP-INIT)
         (spaceship-direction SPACESHIP-INIT)
         (- (spaceship-lives spaceship-orig) ONE))
        (if (not mothership-is-hit)
            moved-spaceship
            (make-spaceship
             (spaceship-position moved-spaceship)
             (spaceship-direction moved-spaceship)
             (+ (spaceship-lives spaceship-orig) ONE))))))

(define (obstacleL-step world)
  (local ((define obstacleL-orig (world-obstacleL world)))
    (cond
      [(or (obstacleL-is-hit? obstacleL-orig (world-ibullets world)) (obstacleL-is-hit? obstacleL-orig (world-sbullets world)))
        (make-obstacleL  ;; if hit, re-init the spaceship with a life less
         (obstacleL-position  obstacleL-orig)
         (- (obstacleL-lives obstacleL-orig) ONE)
        (obstacleL-shape  obstacleL-orig))]
      [(= 4 (obstacleL-lives obstacleL-orig))
       (make-obstacleL  
         (obstacleL-position  obstacleL-orig)
         (obstacleL-lives obstacleL-orig)
        OBSTACLE2)]
      [(= 3 (obstacleL-lives obstacleL-orig))
       (make-obstacleL  
         (obstacleL-position  obstacleL-orig)
         (obstacleL-lives obstacleL-orig)
          OBSTACLE3)]
      [(= 2 (obstacleL-lives obstacleL-orig))
       (make-obstacleL  
         (obstacleL-position  obstacleL-orig)
         (obstacleL-lives obstacleL-orig)
        OBSTACLE4)]
      [(= 1 (obstacleL-lives obstacleL-orig))
       (make-obstacleL  
         (obstacleL-position  obstacleL-orig)
         (obstacleL-lives obstacleL-orig)
          OBSTACLE5)]
      [else
       (make-obstacleL  
         (obstacleL-position  obstacleL-orig)
         (obstacleL-lives obstacleL-orig)
        (obstacleL-shape  obstacleL-orig))])))

(define (obstacleM-step world)
  (local ((define obstacleM-orig (world-obstacleM world)))
    (cond
      [(or (obstacleM-is-hit? obstacleM-orig (world-ibullets world)) (obstacleM-is-hit? obstacleM-orig (world-sbullets world)))
        (make-obstacleM  ;; if hit, re-init the spaceship with a life less
         (obstacleM-position  obstacleM-orig)
         (- (obstacleM-lives obstacleM-orig) ONE)
        (obstacleM-shape  obstacleM-orig))]
      [(= 4 (obstacleM-lives obstacleM-orig))
       (make-obstacleM  
         (obstacleM-position  obstacleM-orig)
         (obstacleM-lives obstacleM-orig)
        OBSTACLE2)]
      [(= 3 (obstacleM-lives obstacleM-orig))
       (make-obstacleM  
         (obstacleM-position  obstacleM-orig)
         (obstacleM-lives obstacleM-orig)
          OBSTACLE3)]
      [(= 2 (obstacleM-lives obstacleM-orig))
       (make-obstacleM  
         (obstacleM-position  obstacleM-orig)
         (obstacleM-lives obstacleM-orig)
        OBSTACLE4)]
      [(= 1 (obstacleM-lives obstacleM-orig))
       (make-obstacleM  
         (obstacleM-position  obstacleM-orig)
         (obstacleM-lives obstacleM-orig)
          OBSTACLE5)]
      [else
       (make-obstacleM  
         (obstacleM-position  obstacleM-orig)
         (obstacleM-lives obstacleM-orig)
        (obstacleM-shape  obstacleM-orig))])))

(define (obstacleR-step world)
  (local ((define obstacleR-orig (world-obstacleR world)))
    (cond
      [(or (obstacleR-is-hit? obstacleR-orig (world-ibullets world)) (obstacleR-is-hit? obstacleR-orig (world-sbullets world)))
        (make-obstacleR  ;; if hit, re-init the spaceship with a life less
         (obstacleR-position  obstacleR-orig)
         (- (obstacleR-lives obstacleR-orig) ONE)
        (obstacleR-shape  obstacleR-orig))]
      [(= 4 (obstacleR-lives obstacleR-orig))
       (make-obstacleR  
         (obstacleR-position  obstacleR-orig)
         (obstacleR-lives obstacleR-orig)
        OBSTACLE2)]
      [(= 3 (obstacleR-lives obstacleR-orig))
      (make-obstacleR  
         (obstacleR-position  obstacleR-orig)
         (obstacleR-lives obstacleR-orig)
          OBSTACLE3)]
      [(= 2 (obstacleR-lives obstacleR-orig))
       (make-obstacleR  
         (obstacleR-position  obstacleR-orig)
         (obstacleR-lives obstacleR-orig)
        OBSTACLE4)]
      [(= 1 (obstacleR-lives obstacleR-orig))
       (make-obstacleR  
         (obstacleR-position  obstacleR-orig)
         (obstacleR-lives obstacleR-orig)
          OBSTACLE5)]
      [else
        (make-obstacleR  
         (obstacleR-position  obstacleR-orig)
         (obstacleR-lives obstacleR-orig)
        (obstacleR-shape  obstacleR-orig))])))



;;;; Signature
;; move-sbullets: SBullets -> SBullets

;;;; Purpose
;; GIVEN: a list of spaceship bullets
;; RETURNS: a list of spaceship bullets after they move by one unit distance 
;;          in the correct direction

(define (move-sbullets sbullets)
  (cond
    [(empty? sbullets) empty]
    [else
     (local (
             ;;;; Signature
             ;; move-sbullet : LoF<SBullet> -> LoF<SBullet>
             (define (move-sbullet sbullet)
               (make-posn (posn-x sbullet)
                          (- (posn-y sbullet) SSHIP-MOVE-UNIT))))
       (map move-sbullet sbullets))]))



;;;; Signature
;; move-ibullets: IBullets -> IBullets

;;;; Purpose
;; GIVEN: a list of invader bullets
;; RETURNS: a list of invader bullets after they move by one unit distance 
;;          in the correct direction

(define (move-ibullets ibullets)
  (cond
    [(empty? ibullets) empty]
    [else 
     (local (
             ;;;; Signature
             ;; move-ibullet : LoF<IBullet> -> LoF<IBullet>
             (define (move-ibullet ibullet)
               (make-posn (posn-x ibullet)
                          (+ (posn-y ibullet) SSHIP-MOVE-UNIT))))
       (map move-ibullet ibullets))]))




;;;; Purpose
;; GIVEN: a list of invaders
;; RETURNS: a new list of invaders in the new positions after
;;          they move down the amount of units as their length

;;;; move-invaders: LoF<Invader> -> LoF<Invader>

(define (move-invaders invaders)
  (if (empty? invaders)
      empty              ;INVASORES MORTOS
      (map
       ;;;; Invader -> Invader
       (lambda (i) 
         (make-posn (posn-x i)
                    (+ (posn-y i) INVADER-LENGTH)))
       invaders)))


;;;; Signature
;; invaders-step: World -> LoF<Invader>

;;;; Purpose
;; GIVEN: the current world
;; RETURNS: a new list of invaders,
;;          and the invaders only move down every 10 ticks

(define (invaders-step world)
  (local ((define ticks (world-ticks world))
          (define invaders (world-invaders world)))
    (if (and (not (= TICK-0 ticks))
             (= ZERO (modulo ticks TICK-10)))
        (move-invaders invaders)
        invaders)))




;;;; Signature
;; key-handler: World Key-Event -> World

;;;; Purpose
;; GIVEN: the current world and a key event
;; RETURNS: a new world with spaceship or its bullets updated
;;          according to the key event

(define INVADERS-4-9 (invader-cons-row (* 4 GAP-BETWEEN-ROWS) 
                                       ROW-NUM-INVADER COL-NUM-INVADER))



;;;; Function Definition
(define (key-handler world ke)
  (cond 
    [ (and (or (key=? ke "h") (key=? ke "H")) (eq? world WORLD-START))
     (make-world INVADERS-4-9 SPACESHIP-INIT 
    empty empty MIN-SCORE TICK-0 OBSTACLE-LEFT OBSTACLE-MID OBSTACLE-RIGHT MSHIP-INIT)]
    [(and (spaceship-reach-left-corner? (world-spaceship world))
          (key=? ke "right"))
     (make-world (world-invaders world)
                 (make-spaceship
                  (make-posn (+ 
                              (posn-x (spaceship-position 
                                       (world-spaceship world))) SSHIP-MOVE-UNIT)
                             (posn-y (spaceship-position 
                                      (world-spaceship world))))
                  'right
                  (spaceship-lives (world-spaceship world)))
                 (world-sbullets world)
                 (world-ibullets world)
                 (world-score world)
                 (world-ticks world)
                 (world-obstacleL world)
                 (world-obstacleM world)
                 (world-obstacleR world)
                 (world-mothership world))]
    [(and (spaceship-reach-right-corner? (world-spaceship world))
           (key=? ke "left"))
     (make-world (world-invaders world)
                 (make-spaceship
                  (make-posn (- 
                              (posn-x (spaceship-position 
                                       (world-spaceship world))) SSHIP-MOVE-UNIT)
                             (posn-y (spaceship-position 
                                      (world-spaceship world))))
                  'left
                  (spaceship-lives (world-spaceship world)))
                 (world-sbullets world)
                 (world-ibullets world)
                 (world-score world)
                 (world-ticks world)
                 (world-obstacleL world)
                 (world-obstacleM world)
                 (world-obstacleR world)
                 (world-mothership world))]
    [(or (key=? ke "left")      
         (key=? ke "right")
         (key=? ke "up"))
     (make-world (world-invaders world)
                 (make-spaceship 
                  (spaceship-position (world-spaceship world))
                  (string->symbol ke)
                  (spaceship-lives (world-spaceship world)))
                 (world-sbullets world)
                 (world-ibullets world)
                 (world-score world)
                 (world-ticks world)
                 (world-obstacleL world)
                 (world-obstacleM world)
                 (world-obstacleR world)
                 (world-mothership world))]
    [(and (key=? ke " ") 
          (< (length (world-sbullets world)) BULLET-MAX-SPACESHIP))
     (make-world (world-invaders world)
                 (world-spaceship world)
                 (cons (spaceship-position (world-spaceship world))
                       (world-sbullets world))
                 (world-ibullets world)
                 (world-score world)
                 (world-ticks world)
                 (world-obstacleL world)
                 (world-obstacleM world)
                 (world-obstacleR world)
                 (world-mothership world))] 
    [else world]))



;;;; Signature
;; world-step: World -> World

;;;; Purpose
;; GIVEN: the current world
;; RETURNS: the next world after one clock tick -
;;   1. If any of the spaceship or invader bullets, 
;;      or mothership go out of bounds,
;;      they will be removed from the canvas.
;;   2. If a spaceship bullet hits an invader, 
;;      it needs to be removed from the canvas.
;;   3. If an invader bullet hits the spaceship, 
;;      it needs to be removed from the canvas.
;;   4. Any of the invaders that are hit by the spaceship
;;      bullets will be removed from the canvas
;;   5. For all other spaceship and invader bullets, 
;;      and spaceship or mothership if not hit
;;      they just move to the next world-step position.
;;   6. the score will be updated if the spaceship bullets 
;;      hit any of the invaders, it will be further updated 
;;      if any of the bullets also hits the mothership
;;   7. the tick increases by 1 in each world step
;;   8. new invader bullets could be generated if there are enough invaders
;;      and the bullets have not reached the maximum amount
;;   9. the mothership will reappear in every 30 ticks if it has disappeared
;;      either because it was hit or it has moved out of bounds
;;   10. the invaders will all move down the amount of units as their length
;;       every 10 ticks MUDAR OS 10 AQUI


;;;; Function Definition
(define (world-step world)
  (if (eq? world WORLD-START)
  world
  (local ((define invaders
            (invaders-step world))
          (define remove-lst 
            (filter-sbullets-and-invaders-to-be-removed 
             world))
          (define obstacleL
            (obstacleL-step world))
          (define obstacleM
            (obstacleM-step world))
          (define obstacleR
            (obstacleR-step world))
          (define sbullets
            (move-sbullets
            (remove-sbullets-or-invaders-after-hit
              (world-sbullets world)
              remove-lst)))
          (define mothership-is-hit
            (mothership-is-hit? sbullets (world-mothership world)))
          (define spaceship
            (spaceship-step world mothership-is-hit))
          
          (define invaders-updated
            (remove-sbullets-or-invaders-after-hit
             invaders
             remove-lst)))
    
    (remove-bullets-out-of-bounds-world
     (make-world invaders-updated
                 spaceship
                 sbullets
                 (move-ibullets
                  (remove-ibullet-after-hit-obstacleR obstacleR
                  (remove-ibullet-after-hit-obstacleM obstacleM
                  (remove-ibullet-after-hit-obstacleL obstacleL
                   (remove-ibullet-after-hit                  
                   spaceship
                   (invaders-fire 
                    (random (length invaders))
                    (world-ibullets world)
                    invaders))))))
                 (update-score (world-score world)
                               invaders
                               invaders-updated
                               mothership-is-hit)
                 (+ ONE (world-ticks world))
                 obstacleL
                 obstacleM
                 obstacleR
                 (mothership-step world mothership-is-hit))))))



;;;; Signature
;; update-score: Score LoF<Invader> LoF<Invader> Boolean -> Score

;;;; Purpose
;; GIVEN: a score, an original list of invaders, an updated list of invaders
;;        and a boolean representing if the mothership is hit by the spaceship
;; RETURNS: 1. if the mothership is not hit, return an updated score
;;             calculated by checking how many invaders are destroyed
;;          2. otherwise, further update the score

(define (update-score old-score invaders-old invaders-new mothership-is-hit)
  (local ((define invaders-hit-num
            (- (length invaders-old)
               (length invaders-new)))
          (define new-score
            (+ old-score (* SCORE-HIT-INVDR invaders-hit-num))))
    (if (not mothership-is-hit) 
        new-score
        (+ SCORE-HIT-MSHIP new-score))))



;;;; Signature
;; posn=?: Posn Posn -> Boolean

;;;; Purpose
;; GIVEN: two posns
;; RETURNS: true if the two posns have the same coordinates, false otherwise

(define (posn=? p1 p2)
  (and (= (posn-x p1) (posn-x p2))
       (= (posn-y p1) (posn-y p2))))



;;;; Signature
;; sbullet-hits-invader? Posn Posn -> Boolean
(define (sbullet-hits-invader? sbullet invader)
  (and
   (< (- (posn-y sbullet)  BULLET-RADIUS)
      (+ (posn-y invader) (/ INVADER-LENGTH TWO)))
   (> (+ (posn-x sbullet)  BULLET-RADIUS)
      (- (posn-x invader) (/ INVADER-LENGTH TWO)))
   (< (- (posn-x sbullet)  BULLET-RADIUS)
      (+ (posn-x invader) (/ INVADER-LENGTH TWO)))))



;;;; Signature
;; sbullet-hits-invaders?: Bullet Invaders -> Boolean

;;;; Purpose
;; GIVEN: a spaceshit bullet and a list of invaders
;; RETURNS: true if the bullet given hits any invader in the list, 
;;          false otherwise

(define (sbullet-hits-invaders? sbullet invaders)
  (ormap
   ;;;; Posn -> Boolean
   (lambda (invader) 
     (sbullet-hits-invader? sbullet invader))
   invaders))



;;;; Signature
;; invader-is-hit?: LoF<SBullet> Invader -> Boolean

;;;; Purpose
;; GIVEN: a list of spaceship bullets and an invader
;; RETURNS: true if the invader is hit by any of the bullets,
;;          false otherwise

(define (invader-is-hit? sbullets invader)
  (ormap 
   ;;;; Posn -> Boolean
   (lambda (sbullet)
     (sbullet-hits-invader? sbullet invader))
   sbullets))


;;;; Signature
;; mothership-is-hit?: LoF<SBullet> Spaceship -> Boolean

;;;; Purpose
;; GIVEN: a list of spaceship bullets and an mothership
;; RETURNS: true if the mothership is hit by any of the bullets,
;;          false otherwise

(define (mothership-is-hit? sbullets mothership)
  (ormap
   ;;;; SBullet -> Boolean
   (lambda (sb) (sbullet-hits-invader? sb (spaceship-position mothership)))
   sbullets))

;;;; Tests
(check-expect (mothership-is-hit?
               (list (make-posn 65 37) TOP-LEFT)
               (make-spaceship TOP-LEFT 'right 0)) #t)

(check-expect (mothership-is-hit?
               (list (make-posn 65 37) TOP-LEFT)
               (make-spaceship TOP-CENTER 'right 0)) #f)


;;;; Signature
;; mothership-step: World Boolean -> Spaceship

;;;; Purpose
;; GIVEN: the current world and a boolean
;;        representing if the mothership is hit by the spaceship
;; RETURNS: an initialized mothership if the boolean is true
;;          otherwise, return a new mothership in the next world step

(define (mothership-step world mothership-is-hit)
  (if mothership-is-hit
      MSHIP-INIT
      (mothership-stepper world)))




;;;; Data Definition
;; A BulletsOrInvaders is a LoF<Posn>
;; INTERP: represents a list containing bullets or (and) invaders

;;;; Signature
;; filter-sbullets-and-invaders-to-be-removed: World -> LoF<Posn>

;;;; Purpose
;; GIVEN: a list of spaceship bullets and a list of invaders
;; RETURNS: a single list containing spaceship bullets and invaders
;;          to be removed

(define (filter-sbullets-and-invaders-to-be-removed world)
  (local ((define sbullets (world-sbullets world))
          (define invaders (world-invaders world))
          (define mothership (world-mothership world))
          (define obstacleL (world-obstacleL world))
          (define obstacleM (world-obstacleM world))
          (define obstacleR (world-obstacleR world)))
    (append
     ;;;; Posn -> Boolean
     (filter 
      (lambda (sb) 
        (or
         (sbullet-hits-invaders? sb invaders)
         (sbullet-hits-invader? sb (spaceship-position mothership))
         (bullet-hits-obstacleL? obstacleL sb)
         (bullet-hits-obstacleM? obstacleM sb)
         (bullet-hits-obstacleR? obstacleR sb))) 
        sbullets)
     (filter (lambda (i) (invader-is-hit? sbullets i)) invaders))))




;;;; Signature
;; lop-contains-posn?: LoF<Posn> Posn -> Boolean

;;;; Purpose
;; GIVEN: a list of posns and a posn
;; RETURNS: true if the given posn is in the list, false otherwise

(define (lop-contains-posn? lop posn)
  ;;;; Posn -> Boolean
  (ormap (lambda (p) (posn=? p posn)) lop))




;;;; Signature
;; remove-sbullets-or-invaders-after-hit: 
;;    BulletsOrInvaders BulletsOrInvaders -> BulletsOrInvaders

;;;; Purpose
;; GIVEN: a list of posns (spaceship bullets or invaders) and 
;;        a list spaceship bullets and invaders to be removed
;;; RETURNS: a list of posns (bullets or invaders) after removals

(define (remove-sbullets-or-invaders-after-hit
         sbullets-or-invaders s-and-i-to-be-removed)
  (filter
   ;;;; Posn -> Boolean
   (lambda (s-or-i)
     (not (lop-contains-posn? s-and-i-to-be-removed s-or-i))) 
   sbullets-or-invaders))



;;;; Signature
;; bullet-out-of-bounds?: Bullet -> Boolean

;;;; Purpose
;; GIVEN: a bullet
;; RETURNS: true if the bullet is out of the canvas, false otherwise

(define BULLET-10-UP-IN (make-posn 10 -2))
(define BULLET-10-UP-OUT (make-posn 10 -3))
(define BULLET-10-LO-IN (make-posn 10 602))
(define BULLET-10-LO-OUT (make-posn 10 603))

(define (bullet-out-of-bounds? bullet)
  (or (<= (+ (posn-y bullet) BULLET-RADIUS) ZERO)
      (>= (- (posn-y bullet) BULLET-RADIUS) CANVAS-HEIGHT)))




;;;; Signature
;; mothership-out-of-bounds?: Spaceship -> Boolean

;;;; Purpose
;; GIVEN: a mothership
;; RETURNS: if the mothership has moved out of bounds

(define (mothership-out-of-bounds? mothership)
  (>= (+ (posn-x (spaceship-position mothership))
         (/ INVADER-LENGTH TWO)) CANVAS-WIDTH))

;;;; Tests
(define MSHIP-IN (make-spaceship 
                  (make-posn
                   (- CANVAS-WIDTH (/ INVADER-LENGTH 2) MSHIP-MOVE-LEN) 20) 
                   'right MAX-LIVES-MSHIP))
(define MSHIP-OUT (make-spaceship 
                   (make-posn
                    (- CANVAS-WIDTH (/ INVADER-LENGTH 2)) 20) 
                   'right MAX-LIVES-MSHIP))
(check-expect (mothership-out-of-bounds? MSHIP-IN) #f)
(check-expect (mothership-out-of-bounds? MSHIP-OUT) #t)

;;;; Signature
;; remove-bullets-out-of-bounds: Bullets -> Bullets

;;;; Purpose
;; GIVEN: a list of bullets
;; RETURNS: a new list of bullets with the ones out of bounds removed

(define BULLETS-BFR (list BULLET-10-UP-IN BULLET-10-UP-OUT 
                          BULLET-10-LO-IN BULLET-10-LO-OUT))
(define BULLETS-AFT (list BULLET-10-UP-IN BULLET-10-LO-IN))

(define (remove-bullets-out-of-bounds bullets)
  ;;;; Posn -> Boolean
  (filter (lambda (b) (not (bullet-out-of-bounds? b))) bullets))



;;;; Signature
;; remove-bullets-out-of-bounds-world: World -> World

;;;; Purpose
;; GIVEN: a world
;; RETURNS: a new world in which the spaceship and invader bullets that are
;;          out of bounds are removed



(define (remove-bullets-out-of-bounds-world world)
  (make-world
   (world-invaders world)
   (world-spaceship world)
   (remove-bullets-out-of-bounds (world-sbullets world))
   (remove-bullets-out-of-bounds (world-ibullets world))
   (world-score world)
   (world-ticks world)
   (world-obstacleL world)
   (world-obstacleM world)
   (world-obstacleR world)
   (world-mothership world)))



;;;; Signature
;; invader-at: Invaders NonNegInt -> Invader

;;;; Purpose
;; GIVEN: a list of invaders and an (zero-based) index of the invader 
;;        the user wants to pull out
;; RETURNS: the invader in the list with that index

(define (invader-at invaders index)
  (cond
    [(empty? invaders) empty]
    [(= ZERO index) (first invaders)]
    [else (invader-at (rest invaders) (- index ONE))]))



;;;; Signature
;; invaders-fire: Natural IBullets Invaders -> IBullets

;;;; Purpose
;; GIVEN: a natural number, a list of invader bullets and a list of invaders
;; RETURNS: a new list of invader bullets with newly-fired bullets added

(define (invaders-fire amount ibullets invaders)
  (cond
    [(or 
      (> (+ (length ibullets) amount) BULLET-MAX-INVADER)
      (< amount ONE)) ibullets]
    [else
     (cons
      (invader-at invaders (random (length invaders)))
      (invaders-fire
       (- amount ONE)
       ibullets
       invaders))]))



;;;; Signature
;; bullet-hits-spaceship?: Spaceship Bullet -> Boolean

;;;; Purpose
;; GIVEN: a spaceship and a bullet
;; RETURNS: true if that bullet on the canvas hits the spaceship, 
;;          false otherwise

(define (bullet-hits-spaceship? spaceship bullet)
  (and 
   (> (+ (posn-x bullet) BULLET-RADIUS) 
      (- (posn-x (spaceship-position spaceship)) (/ SPACESHIP-L TWO)))
   (< (- (posn-x bullet) BULLET-RADIUS) 
      (+ (posn-x (spaceship-position spaceship)) (/ SPACESHIP-L TWO)))
   (> (+ (posn-y bullet) BULLET-RADIUS) 
      (- (posn-y (spaceship-position spaceship)) (/ SPACESHIP-W TWO)))))

(define (bullet-hits-obstacleL? obstacleL bullet)
  (if (> (obstacleL-lives obstacleL) 0)
  (and 
   (> (+ (posn-x bullet) BULLET-RADIUS) 
      (- (posn-x (obstacleL-position obstacleL)) (/ OBSTACLE-LENGTH TWO)))
   (< (- (posn-x bullet) BULLET-RADIUS) 
      (+ (posn-x (obstacleL-position obstacleL)) (/ OBSTACLE-LENGTH TWO)))
   (> (+ (posn-y bullet) BULLET-RADIUS) 
      (- (posn-y (obstacleL-position obstacleL)) (/ OBSTACLE-LENGTH TWO))))
  #false))

(define (bullet-hits-obstacleR? obstacleR bullet)
   (if (> (obstacleR-lives obstacleR) 0)
  (and 
   (> (+ (posn-x bullet) BULLET-RADIUS) 
      (- (posn-x (obstacleR-position obstacleR)) (/ OBSTACLE-LENGTH TWO)))
   (< (- (posn-x bullet) BULLET-RADIUS) 
      (+ (posn-x (obstacleR-position obstacleR)) (/ OBSTACLE-LENGTH TWO)))
   (> (+ (posn-y bullet) BULLET-RADIUS) 
      (- (posn-y (obstacleR-position obstacleR)) (/ OBSTACLE-LENGTH TWO))))
   #false))

(define (bullet-hits-obstacleM? obstacleM bullet)
  (if (> (obstacleM-lives obstacleM) 0)
  (and 
   (> (+ (posn-x bullet) BULLET-RADIUS) 
      (- (posn-x (obstacleM-position obstacleM)) (/ OBSTACLE-LENGTH TWO)))
   (< (- (posn-x bullet) BULLET-RADIUS) 
      (+ (posn-x (obstacleM-position obstacleM)) (/ OBSTACLE-LENGTH TWO)))
   (> (+ (posn-y bullet) BULLET-RADIUS) 
      (- (posn-y (obstacleM-position obstacleM)) (/ OBSTACLE-LENGTH TWO))))
  #false))




;;;; Signature
;; remove-ibullet-after-hit: Spaceship LoF<IBullet> -> LoF<IBullet>

;;;; Purpose
;; GIVEN: a spaceship and a list of invader bullets
;; RETURNS: a new list of invader bullets 
;;          with the ones hitting the spaceship removed

(define (remove-ibullet-after-hit spaceship ibullets)
  (filter (lambda (i) (not (bullet-hits-spaceship? spaceship i))) ibullets))

(define (remove-ibullet-after-hit-obstacleL obstacleL ibullets)
  (if (> (obstacleL-lives obstacleL) 0)
      (filter (lambda (i) (not (bullet-hits-obstacleL? obstacleL i))) ibullets)
      ibullets))

(define (remove-ibullet-after-hit-obstacleM obstacleM ibullets)
  (if (> (obstacleM-lives obstacleM) 0)
  (filter (lambda (i) (not (bullet-hits-obstacleM? obstacleM i))) ibullets)
   ibullets))

(define (remove-ibullet-after-hit-obstacleR obstacleR ibullets)
  (if (> (obstacleR-lives obstacleR) 0)
  (filter (lambda (i) (not (bullet-hits-obstacleR? obstacleR i))) ibullets)
  ibullets))

;(or (bullet-hits-spaceship? spaceship i) (bullet-hits-obstacleL? obstacleL i)



;;;; Signature
;; spaceship-is-hit?: Spaceship Bullets -> Boolean

;;;; Purpose
;; GIVEN: a spaceship and a bullet
;; RETURNS: true if any bullet on the canvas hits the spaceship,
;;          false otherwise

(define (spaceship-is-hit? spaceship ibullets)
  (ormap (lambda (i)  ;;;; Posn -> Boolean
           (bullet-hits-spaceship? spaceship i))
         ibullets))

(define (obstacleL-is-hit? obstacleL ibullets)
  (ormap (lambda (i)  ;;;; Posn -> Boolean
           (bullet-hits-obstacleL? obstacleL i))
         ibullets))

(define (obstacleM-is-hit? obstacleM ibullets)
  (ormap (lambda (i)  ;;;; Posn -> Boolean
           (bullet-hits-obstacleM? obstacleM i))
         ibullets))

(define (obstacleR-is-hit? obstacleR ibullets)
  (ormap (lambda (i)  ;;;; Posn -> Boolean
           (bullet-hits-obstacleR? obstacleR i))
         ibullets))



;;;; invaders-reach-btm?: LoF<Invader> -> Boolean

(define (invaders-reach-btm? invaders)
  (ormap 
   ;;;; Invader -> Boolean
   (lambda (i)
     (>= (posn-y i) BTM-OF-FIELD)) 
   invaders))

;;;; Signature
;; end-game?: World -> Boolean

;;;; Purpose
;; GIVEN: the current world
;; RETURNS: true if the spaceship is hit by any bullets from invaders,
;;          false otherwise

(define BTM-OF-FIELD (+ (posn-y (spaceship-position SPACESHIP-INIT))
                        (/ SPACESHIP-W 2)))

(define (end-game? world)
  (or (= (spaceship-lives (world-spaceship world)) ZERO)
      (invaders-reach-btm? (world-invaders world))))




(define POSN-BOTTOM-MID (make-posn (/ CANVAS-WIDTH 2) (- CANVAS-HEIGHT 20)))
(define BULLETS-SPACESHIP (cons POSN-BOTTOM-MID empty))
(define WORLD-INIT 
  (make-world INVADERS-4-9 SPACESHIP-INIT 
    empty empty MIN-SCORE TICK-0 OBSTACLE-LEFT OBSTACLE-MID OBSTACLE-RIGHT MSHIP-INIT))
(define WORLD-START 
  (make-world INVADERS-4-9 SPACESHIP-INIT 
    empty empty MIN-SCORE TICK-0 OBSTACLE-LEFT OBSTACLE-MID OBSTACLE-RIGHT MSHIP-INIT))
(define WORLD-END 
  (make-world INVADERS-4-9 SPACESHIP-DEAD 
    empty empty MIN-SCORE TICK-0 OBSTACLE-LEFT OBSTACLE-MID OBSTACLE-RIGHT MSHIP-INIT))

(big-bang WORLD-START
          (to-draw draw-world)
          (on-tick world-step 0.09)
          (on-key key-handler)
          (stop-when end-game? draw-world))

