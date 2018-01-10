class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # Facebook에 사람 정보를 요청하여 받은 뒤,
  # 1. DB 레코드가 있는지 없는지 검색하고 (from_omniauth)
  # 2. 없으면 만들고 있으면 그대로 나둔 뒤
  # 3. 유저 정보가 있으면 -> 로그인
  # 4. 유저 정보가 없으면 회원가입으로 리디렉션 시킨다.


  def failure
    redirect_to root_path
  end
end
