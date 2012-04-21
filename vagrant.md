# Vagrant

## Demo

First chef recipe:
http://reiddraper.com/first-chef-recipe/

Demo for redis:

    export k=redis
    cd chef-repo 
    rake new_cookbook COOKBOOK=$k
    cd cookbooks/$k
    rm -rf definitions/ files/ libraries/ providers/ resources/
    touch {attributes,recipes}/default.rb
    touch templates/default/$k.{conf,upstart.conf}.erb

Create <code>Vagrantfile</code>:

    Vagrant::Config.run do |config|
      config.vm.box = "lucid32"
      config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "cookbooks"
     	chef.add_recipe "redis"
      	chef.log_level = :debug
      end 
    end  
 