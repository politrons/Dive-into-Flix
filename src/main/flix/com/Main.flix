def main(_args: Array[String]): Int32 & Impure =
    runFunctions();
    runCollections();
    runMonads();
    runTypes();
    runAsyncChannel();
    runFuture();
    0 // exit code