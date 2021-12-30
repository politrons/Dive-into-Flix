def main(_args: Array[String]): Int32 & Impure =
    //Functions
    //-----------
    println(upperFunc("hello world"));
    println(higherOrderFirstClass(1981, n -> "${(n * 100)}"));
    println(higherOrder()("hello"));
    println("ListMonad:${listMonad()}");
    // Collections
    //-------------
    println("List:${listFeatures()}");
    println("Map:${mapFeatures(1)} ${mapFeatures(2)} ${mapFeatures(3)}");
    println("DoNotation:${doNotation()}");
    0 // exit code