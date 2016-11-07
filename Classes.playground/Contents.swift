import Foundation

/*: title
 
 # Classes
 
 In this lab, you will be exploring Swift classes in more detail. You'll continue to create classes with properties, as well as _methods_ that allow you to interact with the class in some way.
 
 Tests have been included in this playground in the form of `assert()` statements. When you first open the lab, you will see a number of errors. As you complete the tasks in the lab, the errors should disappear. When you've successfully finished the lab, you should see no errors, and the code in the playground should run properly.
 
 _Do not change any of the tests!_ Only add code where `// write your code here` is explicitly marked, or where the directions instruct you to change earlier code that you created.
 
 Let's get started!
 
 ## Question 1
 
 Create a new class called `Person`. This class should include properties for a person's first and last name. Name these properties `firstName` and `lastName`. You should also create an initializer that takes a first and last name as parameters and assigns them to the property.
 */
// write your code here

class Person {
    var firstName: String
    var lastName: String
    var fullName: String {
        return firstName + " " + lastName
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func greet(_ person: Person) -> String {
        return "Hello, \(person.firstName)!"
    }
    
}





// Test
let person = Person(firstName: "Alice", lastName: "Johnson")
person.greet(person)
assert(person.firstName == "Alice", person.firstName)
assert(person.lastName == "Johnson", person.lastName)

/*: section2
 
 ## Question 2
 
 Create a _computed property_ for your `Person` class called `fullName`. This property should return the `Person`'s first and last name separated by a space as a single string.
 
 You can add this property to the class definition you wrote in Question #1.
 */



// Test
assert(person.fullName == "Alice Johnson", person.fullName)
person.fullName


/*: section3
 
 ## Question 3
 
 Now we're going to work on methods for a bit. Create a new method for your `Person` class called `greet(_:)`. `greet(_:)` should take one parameter, another `Person` object, and return a string that says "Hello, <person's first name>!"
 
 You can add this method to the class definition you wrote in Question #1.
 */



// Test
let friend = Person(firstName: "Phil", lastName: "Davies")

var greeting = person.greet(friend)

assert(greeting == "Hello, Phil!", greeting)

greeting = friend.greet(person)

assert(greeting == "Hello, Alice!", greeting)

/*: section4
 
 ## Question 4
 
 It's time for the people you're creating to start earning some money! First, create a class called `Transaction`. This class should have two properties: `type` and `amount`. `amount` should be a `Double` and indicates how much money was involved in the transaction. `type` should be a `String` that can hold the values "in" or "out" and indicates whether the transaction is a credit ("in") or a debit ("out").
 
 Don't forget to create an initializer that takes both these properties as parameters!
 
 (Note that the code below also includes an extension for adding a method to `Double`. You'll learn more about extensions later, so for now, don't worry about it. You'll see how to use it in Question #6 below.)
 */
extension Double {
    var toMoney: String {
        return NSString(format: "%.2f", self) as String
    }
}

// write your code here
class Transaction {
    var type: String
    var amount: Double
    
    var description: String {
        switch type {
            case "in": return "Transaction: credit in the amount of $\(amount.toMoney)"
            case "out": return "Transaction: debit in the amount of $\(amount.toMoney)"
            default: return "error"
        }
    }
    
    init(type: String, amount: Double) {
        self.type = type
        self.amount = amount
    }
}









// Test
let transaction1 = Transaction(type: "in", amount: 10.0)
assert(transaction1.type == "in", transaction1.type)
assert(transaction1.amount == 10.0, "\(transaction1.amount)")
let transaction2 = Transaction(type: "out", amount: 1.2)
assert(transaction2.type == "out", transaction2.type)
assert(transaction2.amount == 1.2, "\(transaction2.amount)")

transaction2.description


// Test
assert(transaction1.description == "Transaction: credit in the amount of $10.00", transaction1.description)
assert(transaction2.description == "Transaction: debit in the amount of $1.20", transaction2.description)

/*: section6
 
 ## Question 6
 
 Now we're going to create a bank account so people can store their money and keep track of their transactions. Create a new class called `BankAccount`. This class should have a property called `owner`. This property is of type `Person` and stores the owner of the account.
 
 It should also have a property called `transactions`. This is an `Array` of `Transaction` objects (`[Transaction]`) which tracks the credits and debits to the account.
 
 Create an initializer for this class. It should only take one parameter: the owner of the account. When the class is first created (instantiated), the list of transactions should be empty.
 */
// write your code here

class BankAccount {
    var owner: Person
    var transactions: [Transaction]
    
    init(owner: Person) {
        self.owner = owner
        self.transactions = [ ]
    }
    
    func deposit(_ deposit: Double) {
        let transaction = Transaction(type: "in", amount: deposit)
        transactions.append(transaction)
    }
    
    func withdraw(_ withdraw: Double) {
        let transaction = Transaction(type: "out", amount: withdraw)
        transactions.append(transaction)
    }
    
    func balance() -> Double {
        var inAmount: Double = 0
        var outAmount: Double = 0
        for transaction in transactions {
            if transaction.type == "in" {
                inAmount += transaction.amount
            }
            else if transaction.type == "out" {
                    outAmount += transaction.amount
            } else {
                return 0
            }
        }
        return (inAmount - outAmount)
    }
}








// Test
let personBankAccount = BankAccount(owner: person)
assert(personBankAccount.owner.fullName == "Alice Johnson", personBankAccount.owner.fullName)
assert(personBankAccount.transactions.isEmpty)

/*: section7
 
 ## Question 7
 
 You need a way to for people to add money to their bank account. In the `BankAccount` class you created in Question #6, add a method called `deposit(_:)`. This method should take a `Double` representing the amount to be deposited into the account as a parameter. It should create a new `Transaction` object representing the deposit and add it to the `BankAccount`'s `transactions` array. This method does not need to return anything.
 */


// Test
personBankAccount.deposit(100.0)
assert(personBankAccount.transactions.count == 1, "\(personBankAccount.transactions.count)")
personBankAccount.deposit(10.0)
assert(personBankAccount.transactions.count == 2, "\(personBankAccount.transactions.count)")
let txn = personBankAccount.transactions

/*: section8
 
 ## Question 8
 
 The owner of the account also needs a way to take money out of their bank account. In the `BankAccount` class you created in Question #6, add a method called `withdraw(_:)`. This method should take a `Double` representing the amount to be withdrawn from the account as a parameter. It should create a new `Transaction` object representing the withdrawal and add it to the `BankAccount`'s `transactions` array. This method does not need to return anything.
 */



// Test
personBankAccount.withdraw(25.0)
assert(personBankAccount.transactions.count == 3, "\(personBankAccount.transactions.count)")
personBankAccount.withdraw(10.5)
assert(personBankAccount.transactions.count == 4, "\(personBankAccount.transactions.count)")
personBankAccount.transactions
personBankAccount.balance()
/*: section9
 
 ## Question 9
 
 The owner of an account needs a way to find out how much money they have. Add a _computed property_ to the `BankAccount` class you created in Question #6 called `balance`. It should tally up all the transactions and return how much money is in the account. The balance should be returned as a `Double`.
 
 Remember that "in" transactions count as money coming in, and "out" transactions count as money going out.
 */









// Test
assert(personBankAccount.balance == 74.5, personBankAccount.balance)

/*: finale
 
 Excellent! If you completed this lab, you should see no more errors in this playground file. Hopefully this has given you a look at how objects can interact with each other, and how you can implement methods to interact with the classes you create.
 */
