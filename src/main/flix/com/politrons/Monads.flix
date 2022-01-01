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
    let newResult = resultValue |>
                    Result.map(v -> String.toLowerCase(v)) |>
                    Result.flatMap(v -> Ok(v + "!!!")) |>
                    Result.foldLeft((acc, next) -> String.toUpperCase(acc + next), "" );
    println("Try Moand Result:${newResult}")                
                    
