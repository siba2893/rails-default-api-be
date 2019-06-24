# This will create each feature type when rails server is boot up
if defined?(Rails::Server)
  begin
    ActiveRecord::Base.connection
  rescue ActiveRecord::NoDatabaseError
    puts '**************************'
    puts 'There is no database yet.'
    puts '**************************'
  else
    if ActiveRecord::Base.connection.migration_context.needs_migration?
      puts '**************************'
      puts 'There are missing migrations.'
      puts '**************************'
    else
      Feature.create_all_features
    end
  end
end
