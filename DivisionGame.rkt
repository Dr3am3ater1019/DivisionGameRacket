#lang racket

(define (division-game)
  (define total-questions 5) ; Number of questions in the game
  (define correct-answers 0) ; Counter for correct answers

  ;; Function to generate and ask division questions
  (define (ask-question)
    (define dividend (+ 10 (random 90))) ; Generate a random dividend between 10 and 99
    (define divisor (+ 1 (random 9)))    ; Generate a random divisor between 1 and 9
    (define answer (/ dividend divisor)) ; Compute the correct answer
    (define attempts 3)                  ; Number of attempts the player gets

    (define (attempt-loop remaining-attempts)
      (if (zero? remaining-attempts)
          (displayln (format "Out of attempts! The correct answer was ~a." answer))
          (let ([player-answer (prompt-guess dividend divisor)])
            (cond
              [(= player-answer answer)
               (displayln "Correct! Well done!")
               (set! correct-answers (+ correct-answers 1))]
              [else
               (displayln "Incorrect. Try again!")
               (attempt-loop (- remaining-attempts 1))]))))
    (attempt-loop attempts))

  ;; Function to prompt the player's guess
  (define (prompt-guess dividend divisor)
    (display (format "What is ~a ÷ ~a? " dividend divisor))
    (flush-output)
    (string->number (read-line)))

  ;; Main game loop
  (define (game-loop remaining-questions)
    (if (zero? remaining-questions)
        (displayln (format "Game over! You answered ~a out of ~a questions correctly."
                          correct-answers total-questions))
        (begin
          (ask-question)
          (game-loop (- remaining-questions 1)))))

  (displayln "Welcome to the Division Game!")
  (game-loop total-questions))

(division-game)