# Pokedex app - test

## descrizione sommaria

Un' app test per la visualizzazione di un pokedex contenente i pokemon della prima generazione.
Vi è la possibilità di visualizzare il tipo, il numero del pokedex, le stats, le abilità e l'immagine del pokemon.
E' possibile inoltre salvare in memoria locale i tuoi pokemon preferiti, visualizzare i pokemon in griglia o in lista e cercare i pokemon per nome,numero pokedex o tipo.

## dependencies

-http: per richieste get per l'estrazione di dati dalla pokeapi;
-google_fonts: per l'uso del fontFamily "Comfortaa";
-flutter_riverpod: per l'uso in più schermi dei dati dei preferiti;
-firebase_core, cloud_firebase, firebase_storage: per l'uso del cloud database e il cloud storage;
-shared_prefences: per la conservazione in memoria dei dati sui preferiti;
-path_provider: per la creazione dei file delle immagini.

## logica

### dati dal web

Nel PokedexScreen avviene la logica per l'estrazione dei dati dal database o dalla pokeapi.
Dalla pokeapi i dati vengono estratti attraverso http.GET mentre dal database attraverso i metodi di FirebaseFirestore.
E' stato integrato firebase tramite firebase_cli e l'ho scelto perchè consente facilmente la persistenza dei dati.
Se il numero di pokemon da caricare supera la lunghezza dei pokemon caricati sul database esegue il processo di estrazione dati dalla api e successivamente carica i dati sul database e le immagini sul cloud storage.
Se invece tutti i pokemon da caricare sono presenti nel database carica le foto dal cloud_storage solo la prima volta e li archivia in memoria.
Dal secondo caricamento le foto verranno direttamente dai file conservati in memoria.

### dati dell'app

Attraverso la classe Pokemon ho definito i vari parametri di ogni pokemon.
E' stato creato un enum per il tipo in modo di automatizzare il colore dell'interfaccia che riguarda quel pokemon.
Creazione della classe abilità con parametri titolo ed effetto.
I dati caricati dal web vengono ordinati e da ognuno di essi viene estratta una classe Pokemon all'interno di una List<Pokemon>.

## screens

Vi sono due screens: il PokedexScreen (la home) e il DetailPokemonScreen (dove visualizzare i dettagli del pokemon).

- PokedexScreen: all'interno viene eseguita la logica per l'estrazione dei dati dal web o dalla memoria.
Attraverso tre bool (search, favoritesOnly, gridMode) vengono scelti i dati da mostrare (se solo i preferiti, o se filtrarli attraverso una ricerca) e se visualizzarli in lista o in griglia.
- DetailPokemonScreen: all'interno vengono visualizzati i dati del pokemon e i dettagli quali stats e abilità.



