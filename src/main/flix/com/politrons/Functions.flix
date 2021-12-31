//A regular function receive an argument A and return a value B after apply some logic 
def upperFunc(x: String): String = String.toUpperCase(x) + "!!!"

//Flix accept functions params as First Citizen
def higherOrderFirstClass(number:Int, func:Int -> String):String = func(number)

//Flix accept return functions as First Citizen
def higherOrder():String -> String = s -> s + " world"

//In order to compose functions we use operator [>>] which allow
//us compose the two functions passing the output of the first one
// as the input of the second one.
def functionalComposition():String=
    let func1 = x -> x + 100;
    let func2 = y -> "[${y}]";
    let composeFunction = func1 >> func2;
    composeFunction(1981)

//In Flix we have [List] Monad just like in other function language
//Which means we can use [map] for transformatio, [flatMap] for composition.
//Or [Filter] to create a new List with filter elements
def pipelineFunctions():List[String]=
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

//Another functional programing technique, just like in Haskell is Currying, where
//Having a function with multiple arguments, if we only pass some of the arguments of
//The function, we receive back the function.
 def curryingFunction():String=
    let bifunc:String -> String -> String = a -> b -> a + b;
    let curryFunc = bifunc("hello curry");
    curryFunc("world")    

//Fold function it works just like in Scala, an init value, a bifunction, and the collection to iterate
def foldLeftFeature():String=
    List.foldLeft((acc, next) -> "${acc}-${next}", //Function with next element of collection and accumulator
     "#",//Init value
    1 :: 2 :: 3 :: Nil) //Collection to iterate

def foldRightFeature():String=
    List.foldRight((next, acc) -> "${next}-${acc}", //Function with next element of collection and accumulator
     "#",//Init value
    "hello" :: "functional" :: "world" :: Nil) //Collection to iterate