## ETF Basket

[![CircleCI](https://circleci.com/gh/madis/etf-basket.svg?style=svg)](https://circleci.com/gh/madis/etf-basket)

Web application to compose stock buying basket based on ETF constituent stocks

### Deploy setup

#### DB

1. Copy DB config & env:
```
scp config/database.yml $DEPLOY_HOST:~$DEPLOY_USER/apps/etf-basket/shared/config
```

2. Create DB & credentials:
```sql
CREATE DATABASE etf_basket_production;
CREATE USER etf_basket WITH ENCRYPTED PASSWORD 'yu-so-secret';
GRANT ALL PRIVILEGES ON DATABASE etf_basket_production TO etf_basket;
```
