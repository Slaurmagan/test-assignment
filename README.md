## Things done

* Multi-currency payments
* Wallets
* Wallet transactions
* Hotwire for errors + payments + form
* Scheduled payments
* Negative balance not allowed

## Considered not to do(wont show my skills imo)

* Specs
* Retrieving user's transaction history(its simple UI so decided not to do it)
* Cancelling scheduled payments(simple update of status to canceled)
* Ability to create currency(very simple UI so its done through seeds)


## Things to improve but decided not spend more time on test assignment

* When selecting execution time of payment time set only in UTC-0 TZ(should be according to user TZ)
* I would prefer to process each scheduled payment in different worker(rn its done one by one)
* Ideally when user created scheduled transaction we should hold amount from his wallet(rn there is no check that user have sufficient funds in wallet when creating scheduled payment). If user decides to cancel transaction we will unhold it. If payment processed by worker we should do decrease hold + deposit to receiver wallet(we shouldnt withdraw from sender wallet since we already held amount)
* payments.amount field should be either bigint or decimal(I prefer bigint) and all amounts in system should be converted to cents with Money gem or whatever analog we have
* Store payment status as enum

# How to run

```bash
git clone
make build
make bundle
make db-create && make db-migrate && make db-seed && make up
```

Default address: localhost:9565

