class DiariesController < ApplicationController
  before_action :authenticate_user!


    def index
        @diarys = Diary.where(user_id: current_user.id).page(params[:calendar]).per(31).order(id: "DESC")
        @vactine = Diary.where(user_id: current_user.id).page(params[:index]).per(3).order(id: "DESC")
      end
    
    def new
        @diary = Diary.new
    end

    def show
        @diary = Diary.find(params[:id])
    end
    
    def create
        # Diary.create(diary_parameter)
        diary = Diary.new(diary_parameter)
        diary.user_id = current_user.id

        if diary.save
          redirect_to diaries_path
        else
          redirect_to action: "new"
        end

    end

    def destroy
        diary = Diary.find(params[:id])
        diary.destroy
        redirect_to diaries_path, notice:"削除しました"
    end

    def edit
        @diary = Diary.find(params[:id])
    end
    
    def update
        @diary = Diary.find(params[:id])
        if @diary.update(diary_parameter)
          redirect_to diaries_path, notice: "編集しました"
        else
          render 'edit'
        end
    end

    private

  def diary_parameter
    params.require(:diary).permit(:title, :content, :start_time)
  end


end
