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


/// namespace MyMonad {

/// }

/// pub lawless class MyMonad[m : Type -> Type] with Applicative[m] {

///     ///  pub def map(value:a, f:a ->a):a

///     pub def flatMap(f: a -> m[b], x: m[a]) : m[b] 

///     ///  pub def flatMap(value:a, f:a -> MyMonad): MyMonad[a]

/// }


/// instance MyMonad[Option] {

///     pub def flatMap(f:String ->Option[String], input:Option[String]):Option[String]=
///         f("")

/// }
   