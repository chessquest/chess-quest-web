RSpec.describe 'CVE-2015-9284', type: :request do
  describe 'GET /auth/:provider' do
    it do
      get '/users/auth/google_oauth2'
      expect(response).not_to have_http_status(:redirect)
    end
  end

  describe 'POST /users/auth/:provider without CSRF token' do
    before do
      @allow_forgery_protection = ActionController::Base.allow_forgery_protection
      ActionController::Base.allow_forgery_protection = true
    end

    it do
      expect {
        post '/users/auth/google_oauth2'
      }.to raise_error(ActionController::InvalidAuthenticityToken)
    end

    after do
      ActionController::Base.allow_forgery_protection = @allow_forgery_protection
    end
  end
end