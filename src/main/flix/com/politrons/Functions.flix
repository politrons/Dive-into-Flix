//A regular function receive an argument A and return a value B after apply some logic 
def upperFunc(x: String): String = String.toUpperCase(x) + "!!!"

//Flix accept functions params as First Citizen
def higherOrderFirstClass(number:Int, func:Int -> String):String = func(number)

//Flix accept return functions as First Citizen
def higherOrder():String -> String = s -> s + " world"
 
//In Flix we have [List] Monad just like in other function language
//Which means we can use [map] for transformatio, [flatMap] for composition.
//Or [Filter] to create a new List with filter elements
def listMonad():List[String]=
    let l: List[String] = "Hello" :: "World" :: Nil;
    l |>
    List.map(word -> String.toUpperCase(word)) |>
    List.flatMap(word -> word :: "!" :: Nil) |>
    List.filter(word -> String.length(word) > 3) 

// Just like in Haskell, we can have do-notation pipline, and have sugar syntax 
// with [flatMap] which extract each value to make composition, to avoid
// flatMap -> flatMap -> flatMap
def doNotation():Option[String]=
    use Option.flatMap;
    let* value1 = Some("hello");
    let* value2 = Some("world");
    let* value3 = Some("!!!");
    Some(value1 + value2 + value3)
    /// flatMap(x -> flatMap(y -> Some(x + " " + y), maybe2), maybe1) 

def foldLeftFeature():String=
    List.foldLeft((acc, next) -> "${acc}-${next}", //Function with next element of collection and accumulator
     "#",//Init value
    1 :: 2 :: 3 :: Nil) //Collection to iterate

def foldRightFeature():String=
    List.foldRight((next, acc) -> "${next}-${acc}", //Function with next element of collection and accumulator
     "#",//Init value
    "hello" :: "functional" :: "world" :: Nil) //Collection to iterate