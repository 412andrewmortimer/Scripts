# Commands
-----
- Debug in browser. Append to url. `root_url/?debug_assets=1` 
----
- Start the rails console. `be rails c`
- See all the assets load paths. `y Rails.application.config.assets.path`
----
- Migrate positions. RAILS_ENV=production bundle exec rake pages:migrate_positions
- Install migrations. bundle exec rake railties:install:migrations
