require 'oauth'

class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :validate_session, :only => [:test_should_be_logged_in] if defined?(:validate_session)
  before_filter :require_login_from_http_basic, :only => [:test_http_basic_auth]
  before_filter :require_login, :only => [:test_logout, :test_should_be_logged_in, :some_action]

  def index
  end
  
  def some_action
    render :nothing => true
  end

  def test_login
    @user = login(params[:username], params[:password])
    render :text => ""
  end
  
  def test_auto_login
    @user = User.find(:first)
    auto_login(@user)
    @result = current_user
    render :text => ""
  end

  def test_return_to
    @user = login(params[:username], params[:password])
    redirect_back_or_to(:index, :notice => 'haha!')
  end

  def test_logout
    logout
    render :text => ""
  end

  def test_logout_with_remember
    remember_me!
    logout
    render :text => ""
  end

  def test_login_with_remember
    @user = login(params[:username], params[:password])
    remember_me!

    render :text => ""
  end

  def test_login_with_remember_in_login
    @user = login(params[:username], params[:password], params[:remember])

    render :text => ""
  end

  def test_login_from_cookie
    @user = current_user
    render :text => ""
  end

  def test_not_authenticated_action
    render :text => "test_not_authenticated_action"
  end

  def test_should_be_logged_in
    render :text => ""
  end

  def test_http_basic_auth
    render :text => "HTTP Basic Auth"
  end

  def login_at_test
    login_at(:twitter)
  end

  def login_at_test2
    login_at(:facebook)
  end

  def login_at_test3
    login_at(:github)
  end

  def test_login_from
    if @user = login_from(:twitter)
      redirect_to "bla", :notice => "Success!"
    else
      redirect_to "blu", :alert => "Failed!"
    end
  end

  def test_login_from2
    if @user = login_from(:facebook)
      redirect_to "bla", :notice => "Success!"
    else
      redirect_to "blu", :alert => "Failed!"
    end
  end

  def test_login_from3
    if @user = login_from(:github)
      redirect_to "bla", :notice => "Success!"
    else
      redirect_to "blu", :alert => "Failed!"
    end
  end

  def test_create_from_provider
    provider = params[:provider]
    login_from(provider)
    if @user = create_from(provider)
      redirect_to "bla", :notice => "Success!"
    else
      redirect_to "blu", :alert => "Failed!"
    end
  end

  protected



end
