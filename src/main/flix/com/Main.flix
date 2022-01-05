def main(_args: Array[String]): Int & Impure =
    runFunctions();
    runCollections();
    runMonads();
    runTypes();
    runAsyncChannel();
    runFuture();
    0
