def upperFunc(x: String): String = String.toUpperCase(x)

def higherOrderFirstClass(number:Int, func:Int -> String):String = func(number)

def higherOrder():String -> String = s -> s + " world"
 
