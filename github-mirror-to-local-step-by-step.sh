## GitHub mirror to local system, step by step

mkdir -p /opt/github && cd /opt/github

mkdir rails
git clone git://github.com/rails/rails.git rails/rails
git clone git://github.com/rails/arel.git rails/arel
git clone git://github.com/rails/journey.git rails/journey
git clone git://github.com/rails/sprockets-rails.git rails/sprockets-rails
git clone git://github.com/rails/sass-rails.git rails/sass-rails
git clone git://github.com/rails/coffee-rails.git rails/coffee-rails
git clone git://github.com/rails/activerecord-deprecated_finders.git rails/activerecord-deprecated_finders

mkdir sstephenson
git clone git://github.com/sstephenson/ruby-build.git sstephenson/ruby-build
git clone git://github.com/sstephenson/rbenv.git sstephenson/rbenv



