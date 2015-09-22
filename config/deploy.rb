require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :rails_env, 'staging'
set :deploy_to, "/home/deploy/apps/#{application}"

set :application, "sur.codescience.us"
set :domain, "sur.codescience.us"
set :repository, 'git@github.com:andrunix/schooluniformresale.git'
set :branch, 'staging'
set :user, 'deploy'
set :forward_agent, true
set :branch, 'staging'


# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log', 'config/puma.rb']


# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rbenv:load'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml' and 'secrets.yml'."]

  # queue %[
  #  repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
  #  repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
  #  if [ -z "${repo_port}" ]; then repo_port=22; fi &&
  #  ssh-keyscan -p $repo_port -H $repo_host >> ~/.ssh/known_hosts
  #]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  # to :before_hook do
  #   # Put things to run locally before ssh
  # end

  queue! 'export PATH=$PATH:/usr/local/rbenv/shims'

  deploy do

    # This shouldn't have to be here but for some reason, I have to set the rbenv path here
    # queue! 'export PATH=$PATH:/usr/local/rbenv/shims'

    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      # queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      invoke :'restart'
    end
  end

end

task restart: :environment do 
  queue "sudo service puma-manager restart"
end

task start: :environment do
  queue "sudo service puma-manager start"
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
