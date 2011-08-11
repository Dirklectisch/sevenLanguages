## Find: ##

- The Scala API

  http://www.scala-lang.org/api/current/index.html

- A comparison of Java and Scala

  http://www.ibm.com/developerworks/java/library/j-scala01228/index.html

- A discussion of val vs var

 http://stackoverflow.com/questions/1791408/what-is-the-difference-between-a-var-and-val-definition-in-scala

## Do: ##

- Write a game that will take a tic-tac-toe board with X, O, and blank characters and detect th e winner or wether there is a tie or no winner yet. Use classes where appropriate.

  See below.

- Bonus problem: Let two players play tic-tac-toe.

  See below.

---

```scala

class Board(var grid: List[List[String]]){
    
    var finished = false
    var won = false
    var winner = "no one"
    
    def this() {
        this(
            List[List[String]](
                List(null, null, null),
                List(null, null, null),
                List(null, null, null)
            )
        )
    }
    
    def mark_position(player: String, xPos: Int, yPos: Int){
        check_progress
        
        grid = grid.updated(yPos-1,
            grid(yPos-1).updated(xPos-1,
                player
            )
        )
        
        println("Marked position: x" + xPos + " y" + yPos + " for player " + player)
        
        display_positions
        
    }
    
    def display_positions(){
        println("\nCurrent board positions:")
        grid.foreach{ row => 
            row.foreach { cell =>
                print(cell + "  ")
            }
            print("\n")
        }
    }
    
    def check_line(line: List[String]){
        if(line(0) != null && line(0) == line(1) && line(1) == line(2)){
            won = true
            finished = true
            winner = line(0)
        }
    }

    def check_rows(board: List[List[String]]){
        board.foreach{ row =>
            check_line(row)
        }
    }

    def check_diag(board: List[List[String]]){
        check_line(List(board(0)(0), board(1)(1), board(2)(2)))
    }
    
    def check_progress {

        // Count empty spaces on the board
        var nullSpaces = 0
        grid.foreach{ row =>
            row.foreach{ cell =>
                if(cell == null){ nullSpaces += 1 }
            }
        }
        
        // Check rows for winning conditions
        check_rows(grid)
        
        // Check columns for winnig conditions
        check_rows(grid.transpose)
        
        // Check top-left to bottom-right diagonal for winning condition
        check_diag(grid)
        
        // Check bottom-left to top right diagonal for winning condition
        check_diag(grid.reverse)

        // Game isn't over when there are empty spaces and no winners
        if(nullSpaces > 0 && won == false){
            finished = false
        }

        // Game is over when there are no empty spaces and no winners
        if(nullSpaces == 0 && won == false){
            finished = true
        }
    }
    
    def display_status {
        
        check_progress
        
        if(finished == false){ println("The game is still in progress") }
        if(finished == true && won == false){ println("The game ended in a tie") }
        if(won == true){ println("The game has been won by " + winner) }
        
    }
    
}

// Test cases

val board_a = new Board (
    List(
        List("O", null, null),
        List("X", "X", "X"),
        List("O", "O", null)
    )
)

val board_b = new Board (
    List(
        List("O", null, "O"),
        List("X", "X",  "O"),
        List("X", null, "O")
    )
)

val board_c = new Board (
    List(
        List("X", null, "O"),
        List("O", "X",  "O"),
        List("X", null, "X")
    )
)

val board_d = new Board (
    List(
        List("X", null, "O"),
        List("X", "O",  "X"),
        List("O", null, "X")
    )
)

val board_e = new Board (
    List(
        List("X", null, "O"),
        List("X", null, "X"),
        List("O", null, "X")
    )
)

val board_f = new Board (
    List(
        List("X", "X", "O"),
        List("O", "X", "X"),
        List("X", "O", "O")
    )
)

val board_g = new Board

val test_cases = List(board_a, board_b, board_c, board_d, board_e, board_f, board_g)

test_cases.foreach{ board =>
    board.display_status
}

// Example Game

val gameBoard = new Board

val players = List("X", "O")
var turnsTaken = 0

while(gameBoard.finished == false){
    
    var player = players(turnsTaken % players.length)
    println("Player " + player + " take your turn")
    
    var pos = readf("{0,number,integer} {1,number,integer}")
    var (x, y) = (pos(0).toString.toInt, pos(1).toString.toInt) 
    gameBoard.mark_position(player, x, y)
    
    turnsTaken += 1
    gameBoard.check_progress
}

gameBoard.display_status

```


