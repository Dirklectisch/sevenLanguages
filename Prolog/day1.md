## Find: ##

- Some free Prolog tutorials

    Prolog Tutorial by J.R.Fisher
    http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html

    On-line guide to Prolog Programming by Roman Bartak
    http://kti.ms.mff.cuni.cz/~bartak/prolog/index.html

    Prolog and Logic Programming by Dr Peter Hancox
    http://www.cs.bham.ac.uk/~pjh/prolog_course/se207.html

- A support forum (there are several)

    The GNU Prolog Mailing list
    http://www.gprolog.org/#maillist

- One online reference for the Prolog version you're using

    GNU Prolog Manual
    http://www.gprolog.org/manual/html_node/index.html

## Do: ##

- Make a simple knowledge base. Represent some of your favorite books and authors.

        author(douglas_hofstadter).
        author(daniel_dennett).

        book_author(godel_escher_bach, douglas_hofstadter).
        book_author(darwins_dangerous_idea, daniel_dennett).
        book_author(the_minds_i, douglas_hofstadter).
        book_author(the_minds_i, daniel_dennett).

- Find all books in your knowledge base written by one author.

        | ?- book_author(X, daniel_dennett).

        X = darwins_dangerous_idea ? a

        X = the_minds_i

        yes

- Make a knowledge base representing musicians and instruments. Also represent musicians and their genre of music.

        plays_instrument(james_blackshaw, guitar).
        plays_instrument(nils_frahm, piano).
        plays_instrument(jimi_hendrix, guitar).

        plays_genre(james_blackshaw, folk).
        plays_genre(nils_frahm, classical).
        plays_genre(jimi_hendrix, rock).

- Find all musicians who play the guitar.

        | ?- plays_instrument(X, guitar).

        X = james_blackshaw ? a

        X = jimi_hendrix

        (1 ms) yes
