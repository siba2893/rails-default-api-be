# Create all features
Feature.create_all_features

# Creation of User Admin
admin = User.find_or_create_by(first_name: 'admin', email: 'admin@development.com') do |user|
  user.password = 'password'
end

admin_role = Role.find_or_create_by(title: 'Super Admin', slug: 'super_admin')
admin_role.features = Feature.all

admin.update(role: admin_role)
admin.features = Feature.all

# Create common user
common_user = User.find_or_create_by(first_name: 'common_user', email: 'common_user@development.com') do |user|
  user.password = 'password'
end

common_user_role = Role.find_or_create_by(title: 'Common User', slug: 'common_user')
common_user_role.features = []
common_user.update(role: common_user_role)
common_user.features = common_user_role.features
