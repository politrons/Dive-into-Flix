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