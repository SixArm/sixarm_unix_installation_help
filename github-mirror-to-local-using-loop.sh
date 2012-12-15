#!/bin/bash

for x in \
  rails/arel \
  rails/coffee-rails \
  rails/journey \
  rails/rails \
  rails/sass-rails \
  rails/sprockets-rails \
  rails/activerecord-deprecated_finders
do
  dir=`expr match "$x" '\(.\+\)/'`
  mkdir -p $dir
  git clone git://github.com/$x.git $x
done