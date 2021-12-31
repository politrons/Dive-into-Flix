def main(_args: Array[String]): Int32 & Impure =
    //Functions
    //-----------
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
    0 // exit code