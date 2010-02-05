ActionController::Routing::Routes.draw do |map|

	# for Authlogic
	# User、UserSessionは単一リソースとして扱う
  map.resource :user
  map.resource :user_session, :only => [:new, :create, :destroy]



end
