
module RequestContext
  module Rails
    module CurrentUserFilter
      def context_store_current_user
        if current_user
          RequestContext.user_email = current_user.email
        end
      end
    end
  end
end
