
def listFind():String=
    let l: List[String] = "Hello" :: "World" :: Nil;
    let maybeValue = List.find(word  -> word == "Hello", l);
    match  maybeValue {
        case Some(value) => value
        case None    => bug!("The value of `key` must exist.")
    }  

def mapType(key:Int):String=
    let m = Map#{1 -> "Hello", 2 -> "Map", 3 -> "World"};
     match Map.get(key, m) {
        case Some(x) => x
        case None    => bug!("The value of `key` must exist.")
    }