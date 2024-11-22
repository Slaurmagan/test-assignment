sender = User.create(username: 'sender')
receiver = User.create(username: 'receiver')
usd = Currency.create(name: 'USD')
eur = Currency.create(name: 'EUR')

Wallet.create(owner: sender, currency: usd, available: 100_000)
Wallet.create(owner: receiver, currency: usd, available: 100_000)

Wallet.create(owner: sender, currency: eur, available: 100_000)
Wallet.create(owner: receiver, currency: eur, available: 100_000)
