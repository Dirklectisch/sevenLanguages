## Find: ##

- For the sizer program, what would happen if you did not create a new actor for each link you wanted to follow? What would happen to the performance of the application?

  I tried this out by adding a function that only creates a single actor.

    def getPageSizeConcurrently() = {
     val caller = self

     for(url <- urls) {
       actor { caller ! (url, PageLoader.getPageSize(url)) }
     }

     for(i <- 1 to urls.size) {
       receive {
         case (url, size) =>
           println("Size for " + url + ": " + size)
       }
     }
    }

  The results of the single actor run are comparable to the sequential run.

    Sequential run:
    Size for http://www.amazon.com/: 108967
    Size for http://www.twitter.com/: 51373
    Size for http://www.google.com/: 9943
    Size for http://www.cnn.com/: 85704
    Method took 3.997937 seconds.
    Concurrent run
    Size for http://www.google.com/: 9961
    Size for http://www.amazon.com/: 102307
    Size for http://www.cnn.com/: 85704
    Size for http://www.twitter.com/: 51211
    Method took 1.669252 seconds.
    Concurrent single actor run
    Size for http://www.amazon.com/: 103560
    Size for http://www.twitter.com/: 51372
    Size for http://www.google.com/: 9943
    Size for http://www.cnn.com/: 85704
    Method took 3.679041 seconds.

  Several runs reveal that the order in which the pages are retrieved is always the same. I conclude that an actors individual actions are sequential. So creating one actor makes will retrieve the pages in pretty much the same way as the sequential run.

## Do: ##

- Take the sizer application and add a message to count the number of links on the page.

  See below.

- Bonus problem: Make the sizer follow the links on a given page, and load them as well. For example, a sizer for "google.com" would compute the size for Google and all op the pages it links to.

```scala

import scala.io._
import scala.actors._
import Actor._

object PageLoader {
    
    // Pattern taken from: http://daringfireball.net/2010/07/improved_regex_for_matching_urls
    val urlPattern = """(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))""".r
    
    def getPage(url : String) = Source.fromURL(url).mkString
    def pageSize(page : String) = page.length
    def findLinks(page : String) = urlPattern.findAllIn(page).toList.map { url => 
        if("""https?://""".r.findFirstIn(url) != None) url else "http://" + url }
    def countLinks(links : List[String]) = links.length
    
}

def timeMethod(method: () => Unit) = {
 val start = System.nanoTime
 method()
 val end = System.nanoTime
 println("Method took " + (end - start)/1000000000.0 + " seconds.")
}

def getPageInfoConcurrently(urls: List[String], followLinks: Boolean): Any = {
    val caller = self

    for(url <- urls) {
      actor { 
          val page = PageLoader.getPage(url)
          val links = PageLoader.findLinks(page)
          caller ! (url, PageLoader.pageSize(page), PageLoader.countLinks(links))
          if(followLinks == true){ 
                getPageInfoConcurrently(links, false)
                caller ! (url, true) 
          }
      }
    }
    
    val x = (if(followLinks) 2 else 1)
    
    for(i <- 1 to (urls.size * x)) {
      receive {
        case (url, size, linkCount) =>
          println("Size for " + url + ": " + size + ", " + linkCount + " links found.")
        case (url, true) =>
          println("Done crawling " + url)  
      }
    }
}

def crawlPages() = {
      
    val urls = List("http://pragprog.com/book/btlang/seven-languages-in-seven-weeks",
                    "http://www.ibm.com/developerworks/java/library/j-scala02049/index.html")
                   
    getPageInfoConcurrently(urls, true)
    
}


println("Concurrent run")
timeMethod { crawlPages }
```