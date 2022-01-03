//Enum type provide the possibility to create a limit type of values
enum Sex with ToString {
    case Male
    case Female
}

//Namespace where we define functions, that can return all flex Types
//Like enum, Tuple, String, Int.....
namespace User {

    pub def username():String = "Politrons"

    pub def password():String = "Password"

    pub def sex():Sex = Male()

    pub def address():(String, Int32) = ("Camilo Jose Cela", 34)
}

def login():Unit & Impure =
    let username = User.username();
    let password = User.password();
    let sex = User.sex();
    let address = User.address();
    println("${username}-${password}-${sex}-${address}")