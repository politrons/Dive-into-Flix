def main(_args: Array[String]): Int32 & Impure =
    //Functions
    //-----------
    println(upperFunc("hello world"));
    println(higherOrderFirstClass(1981, n -> "${(n * 100)}"));
    println(higherOrder()("hello"));
    // Collections
    //-------------
    println(listType());
    0 // exit code