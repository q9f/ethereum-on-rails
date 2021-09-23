# README

Ethereum on Rails MVP:
* User model with `:eth_address` and `:eth_nonce`
* Create account with `:eth_address` requested from Ethereum wallet (MetaMask)
* Sign in to existing account by signing `:eth_nonce` with `:eth_address` in an Ethereum wallet
* ...
* _Profit!_

### Required versions

* Ruby `^3.0.0`
* Rails `^6.1.0`
* Node `^16.8.0`

### System dependencies

* Ruby, Gems, Rails, SQLite3, Bundler, NodeJS, NPM, Yarn

```bash
pacman -S ruby rubygems sqlite nvm
nvm install stable
npm install --global npm yarn
gem install bundler rails
```

### Run dev server

```bash
nvm use stable
bundle install
bin/rails server
```
