abstract class Account {
  late int accountNumber;
  late double balance;

  void deposit(double amount) {
    balance += amount;
  }

  void withdraw(double amount);
}

class SavingsAccount extends Account {
  late double interestRate;

  SavingsAccount(int accountNumber, double balance, this.interestRate) {
    this.accountNumber = accountNumber;
    this.balance = balance;
  }

  @override
  void withdraw(double amount) {
    balance -= amount;
    balance += balance * interestRate;
  }
}

class CurrentAccount extends Account {
  late double overdraftLimit;

  CurrentAccount(int accountNumber, double balance, this.overdraftLimit) {
    this.accountNumber = accountNumber;
    this.balance = balance;
  }

  @override
  void withdraw(double amount) {
    if (amount <= overdraftLimit + balance) {
      balance -= amount;
    } else {
      print('Insufficient funds');
    }
  }
}

void main() {
  SavingsAccount savingsAccount = SavingsAccount(123456, 1000.0, 0.05);
  savingsAccount.deposit(500.0);
  savingsAccount.withdraw(200.0);
  print(savingsAccount.balance);

  CurrentAccount currentAccount = CurrentAccount(789012, 500.0, 100.0);
  currentAccount.deposit(200.0);
  currentAccount.withdraw(300.0);
  print(currentAccount.balance);
}
