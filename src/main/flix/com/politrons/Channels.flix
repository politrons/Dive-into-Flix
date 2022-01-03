
//Using [spawn] operator, we run the function in another 
// green thread.
def asyncProcess(str:String):Unit & Impure=
     spawn String.toUpperCase(str)

     