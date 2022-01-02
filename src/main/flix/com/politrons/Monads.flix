// Monads
//---------
def optionMonad():Unit & Impure =
    let maybeValue = Some("hello");
    let newMaybeValue = maybeValue |>
                        Option.filter(v -> String.length(v) > 3) |>
                        Option.map(v -> String.toUpperCase(v)) |>
                        Option.flatMap(v -> Some(v + " world"));
     match newMaybeValue {
        case Some(value) => println("Some monad:${value}")
        case None() => println("None monad")
    }                    

def resultMonad():Unit & Impure=
    let resultValue = Ok("Hello try monad");
    let value = resultValue |>
                    Result.map(v -> String.toLowerCase(v)) |>
                    Result.flatMap(v -> Ok(v + "!!!")) |>
                    Result.foldLeft((acc, next) -> String.toUpperCase(acc + next), "" );
    println("Try Moand Result:${value}")                
                    
def resultErrMonad():Unit & Impure=
    let resultValue = Err("Error Channel");
    match resultValue {
        case Ok(value) => println(value)
        case Err(cause) => println(cause)
    }


def listMonad():Unit & Impure=
    let listMonad = "Hello" :: "List" :: "monad" :: Nil;
    let value = listMonad |>
                    List.map(v -> String.toLowerCase(v)) |>
                    List.flatMap(v -> v :: "!!!":: Nil) |>
                    List.foldLeft((acc, next) -> String.toUpperCase(acc + next), "" );
    println("List Moand Result:${value}")    


// Type classes
//--------------

//Type class contract that all [instance] must implement.
// m deifne a function type [Type -> Type] which is impure since it might have
// side effect [ef]
pub lawless class MyMonad[m : Type -> Type] with Applicative[m] {

    pub def map(f: a -> b & ef, x: m[a]): m[b] & ef

     pub def flatMap(f: a -> m[b] & ef, x: m[a]) : m[b] & ef

}

//[Option] implementation for [MyMonad] 
instance MyMonad[Option] {

    pub def map(f: a -> b & ef, x: Option[a]): Option[b] & ef = Option.map(f,x)

    pub def flatMap(f: a -> Option[b] & ef, x : Option[a]) : Option[b] & ef = Option.flatMap(f, x)
    
}

//[List] implementation for [MyMonad] 
instance MyMonad[List] {

    pub def map(f: a -> b & ef, x: List[a]): List[b] & ef = List.map(f,x)

    pub def flatMap(f: a -> List[b] & ef, x : List[a]) : List[b] & ef = List.flatMap(f, x)
    
}

//We use the namespace to define the DSL which it will be expose to the  user.
//Since we use the generic 
namespace MyMonad {

    pub def transform(f: a -> b & ef, x: m[a]): m[b] & ef with MyMonad[m] = map(f, x)

    pub def compose(f: a -> m[b] & ef, x: m[a]): m[b] & ef with MyMonad[m] = flatMap(f, x)

}



   