namespace :setup do

  desc "Upload database.yml file."
  task :upload_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      execute "touch #{shared_path}/config/database.yml"
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
    end
  end

  desc "Upload .env.production file."
  task :upload_env do
    on roles(:app) do
      execute "touch #{shared_path}/.env"
      upload! StringIO.new(File.read(".env.production")), "#{shared_path}/.env"
    end
  end

  desc "Seed the database."
  task :seed_db do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

    desc 'Create Directories for Puma Pids and Socket'
    task :make_dirs do
      on roles(:app) do
        execute "mkdir #{shared_path}/tmp/sockets -p"
        execute "mkdir #{shared_path}/tmp/pids -p"
        execute "mkdir #{release_path}/shared/log -p"
        execute "touch #{release_path}/shared/log/puma.stdout.log"
        execute "touch #{release_path}/shared/log/puma.stderr.log"
      end
    end

  desc "Symlinks config files for Nginx."
  task :symlink_config do
    on roles(:app) do
      execute "rm -f /etc/nginx/sites-enabled/default"

      execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
    end
  end

end
