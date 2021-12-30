def main(_args: Array[String]): Int32 & Impure =
    //Functions
    //-----------
    println(upperFunc("hello world"));
    println(higherOrderFirstClass(1981, n -> "${(n * 100)}"));
    println(higherOrder()("hello"));
    println("ListMonad:${listMonad()}");
    // Collections
    //-------------
    println("List:${listFind()}");
    println("Map:${mapType(1)} ${mapType(2)} ${mapType(3)}");
    0 // exit code