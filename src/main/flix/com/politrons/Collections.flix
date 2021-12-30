
def listType():List[String]=
    let l: List[String] = "Hello" :: "World" :: Nil;
    l

def mapType(key:Int):String=
    let m = Map#{1 -> "Hello", 2 -> "Map", 3 -> "World"};
    let value = match Map.get(key, m) {
        case Some(x) => x
        case None    => bug!("The value of `key` must exist.")
    };
    value