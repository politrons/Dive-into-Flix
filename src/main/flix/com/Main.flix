def main(_args: Array[String]): Int32 & Impure =
    //Functions
    //-----------
    supplierFunc();
    consumerFunc();
    predicateFunc();
    println(upperFunc("hello world"));
    println(higherOrderFirstClass(1981, n -> "${(n * 100)}"));
    println(higherOrder()("hello"));
    println("Compose functions:${functionalComposition()}");
    println("Pipeline:${pipelineFunctions()}");
    println("DoNotation:${doNotation()}");
    println("FoldLeft:${foldLeftFeature()}");
    println("FoldRight:${foldRightFeature()}");
    println("Currying:${curryingFunction()}");

    // Collections
    //-------------
    println("List:${listFeatures()}");
    println("Map:${mapFeatures(1)} ${mapFeatures(2)} ${mapFeatures(3)}");

    // Monads
    //-------------
    optionMonad();
    resultMonad();
    resultErrMonad();
    listMonad();
    println(MyMonad.compose( str -> Some(String.toUpperCase(str)), Some("hello custom Option monad world!!!")));
    println(MyMonad.transform( str -> String.toUpperCase(str), Some("hello custom Option monad world!!!")));
    println(MyMonad.compose( str -> String.toUpperCase(str) :: Nil, "hello" :: "custom" :: "List monad world!!!"::Nil));
    println(MyMonad.transform( str -> String.toUpperCase(str), "hello" :: "Custom List monad world!!!"::Nil));
    println(MyMonad.compose( str -> A(String.toUpperCase(str)) , A("hello composition custom Politrons monad world!!!")));
    println(MyMonad.transform( str -> String.toUpperCase(str), A("hello transform custom Politrons monad world!!!")));

    // Namespace
    //-------------
    login();

    //Async -Channels
    //---------------
    println(asyncProcess("Hello async world"));
    channelFeature();   
    parallelCompurting(); 
    compositionAsync();

    //Future
    //-------
    runFuture();
    0 // exit code