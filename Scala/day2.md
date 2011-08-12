## Find: ##

- A discussion on how to use Scala files.

  http://www.scala-lang.org/faq/2

- What makes a closure different from a code block?

  Both are anonymous functions but a closure is created by another function. Because of this it can have the privilege of having access to variables that are no longer within it's scope. 

## Do: ##

- Use foldLeft to compute the total size of a list of strings.

  ```scala

  val l = List("A", "list", "of", "Strings")
  val s = (0 /: l) {(size, i) => size + 1}

  ```

- Write a Censor trait with a method that will replace the curse words Shoot and Darn with Pucky and Beans alternatives. Use a map to store the curse words and their alternatives.

  ```scala

  trait Censor {
    
      val words = Map(
          "shoot" -> "pucky", 
          "darn" -> "beans"
      )
    
      override def toString():String = {
          return (super.toString() /: words) {(result, word) => 
              result.replaceAllLiterally(word._1, word._2)
              .replaceAllLiterally(word._1.capitalize, word._2.capitalize)
          }
      }
  }

  ```

- Load the curse words and alternatives from a file.

  ```scala

  val words = loadWords()

  def loadWords():Map[String, String] = {
      return JSON.parseFull(scala.io.Source.fromFile("bad_words.json").mkString)
          .get.asInstanceOf[Map[String, String]]
  }

  ```