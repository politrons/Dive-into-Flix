
//List are just created usig sugar syntax [element :: Nil] 
def listFeatures():String=
    let l:List[String] = "Hello" :: "World" :: Nil;
    let newList = List.append(l, "!!!" :: Nil);
    let upperList = List.map(word -> String.toUpperCase(word), newList);
    let maybeValue = List.find(word  -> word == "HELLO", upperList);
    match  maybeValue {
        case Some(value) => value
        case None    => bug!("The value of `key` must exist.")
    }  

//To create a Map we just need to use [Map#] passing a key -> value entry, just like in Scala.
// To add a new element we need to use Map.insert passing the key, value and the other map, 
// To create a new one.
// To delete an element of the map we just need to use Map.remove
def mapFeatures(key:Int):String=
    let m = Map#{1 -> "Hello", 2 -> "Map", 3 -> "World"};
    let newMap = Map.insert(4, "!!!", m);
    let deleteMap = Map.remove(4, newMap);
     match Map.get(key, deleteMap) {
        case Some(x) => x
        case None    => bug!("The value of `key` must exist.")
    }