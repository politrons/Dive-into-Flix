def main(_args: Array[String]): Int32 & Impure =
    //Functions
    //-----------
    println(upperFunc("hello world"));
    println(higherOrderFirstClass(1981, n -> "${(n * 100)}"));
    println(higherOrder()("hello"));
    // Collections
    //-------------
    println(listType());
    println("${mapType(1)} ${mapType(2)} ${mapType(3)}");
    0 // exit code