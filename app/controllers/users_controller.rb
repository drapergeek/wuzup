class UsersController < Clearance::UsersController
  before_filter :authorize
  skip_before_filter :redirect_to_root
end
