def main(_args: Array[String]): Int & Impure =
    runFunctions();
    runCollections();
    runMonads();
    runTypes();
    runAsyncChannel();
    runFuture();
    runRequest();
    0
