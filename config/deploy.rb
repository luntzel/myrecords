require "bundler/capistrano"
set :use_sudo, false
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
# Put the app in this directory
set :deploy_to, "/srv/myrecords"
set :deploy_via, :remote_cache



set :application, "myrecords"
set :repository,  "git@github.com:luntzel/myrecords.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git

role :web, "173.203.208.88"                          # Your HTTP server, Apache/etc
role :app, "173.203.208.88"


after "deploy:cold" do
  admin.symlink_config
  admin.nginx_restart
end

namespace :deploy do
  task :cold do
    deploy.update
    deploy.start
  end
end


namespace :admin do
  desc "Link the server config to nginx."
  task :symlink_config, roles: :app do
    run "sudo ln -nfs #{deploy_to}/current/config/nginx.server /etc/nginx/sites-enabled/#{application}"
  end

  desc "Unlink the server config."
  task :unlink_config, roles: :app do
    run "sudo rm /etc/nginx/sites-enabled/#{application}"
  end

  desc "Restart nginx."
  task :nginx_restart, roles: :app do
    run "sudo service nginx restart"
  end
end


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
