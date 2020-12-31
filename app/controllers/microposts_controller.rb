class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :corrct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      # indexに送るから@micropostsが必要
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    # 前のアクションのページがない場合には root_path に戻る
    redirect_back(fallback_location: root_path)
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def corrct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      unless @micropost
        redirect_to root_url
      end
    end
end
