Test assignment for WhalesHeaven

Quick start
-----------
<pre>
bundle install 
</pre>

<pre>
rails db:migrate 
</pre>

<pre>
rails db:seed 
</pre>

<pre>
redis-server
</pre>

<pre>
REDIS_URL="redis://127.0.0.1:6379/0" bundle exec sidekiq -e development -C config/sidekiq.yml
</pre>

<pre>
rails s
</pre>

