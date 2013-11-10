## GitHub mirror to local system, step by step

mkdir -p /opt && cd /opt

git clone --depth 1 git://github.com/rails/rails.git
git clone --depth 1 git://github.com/rails/arel.git
git clone --depth 1 git://github.com/rails/journey.git
git clone --depth 1 git://github.com/rails/sprockets-rails.git
git clone --depth 1 git://github.com/rails/sass-rails.git
git clone --depth 1 git://github.com/rails/coffee-rails.git
git clone --depth 1 git://github.com/rails/activerecord-deprecated_finders.git

git clone --depth 1 git://github.com/sstephenson/ruby-build.git
git clone --depth 1 git://github.com/sstephenson/rbenv.git


