# Sentinel
Web dashboard for NATOBot (https://github.com/Bhargav-Rao/NATOBot).

### Setup
Pretty standard Rails setup, really. Built on these versions, may or may not work with
other versions.

- Rails 5.0.0.1
- Ruby 2.3.0

The following commands *should* get the project set up and running.

- `git clone https://github.com/ArtOfCode-/Sentinel`
- `rails db:create RAILS_ENV=production`
- `rails db:schema:load RAILS_ENV=production`
- `rails db:migrate RAILS_ENV=production`
- `rails db:seed RAILS_ENV=production`
- `rails s -e production`
