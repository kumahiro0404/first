class PostsController < ApplicationController
    
    def home

    end

    before_action :authenticate_user!, except: [:home]

    def index

        if params[:search] == nil
            @posts= Post.all.page(params[:page]).per(3).order(id: "DESC")
        elsif params[:search] == ''
            @posts= Post.all.page(params[:page]).per(3)
        else
            @posts = Post.where("body LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(3).order(id: "DESC")
        end
        
        if params[:tag_ids]
            @posts = []
            params[:tag_ids].each do |key, value|
            　if value == "1"
                tag_posts = Tag.find_by(name: key).posts
                @posts = @posts.empty? ? tag_posts : @posts & tag_posts
            　end
            end
        end

    end

    

    def new
        @post = Post.new
    end

    def create
        post = Post.new(post_params)
        post.user_id = current_user.id
        if post.save
            redirect_to :action =>"index"
        else
            flash[:notice] = "優しい投稿を心がけましょう"
            redirect_to :action => "new"
        end
    end

    def show
        @post = Post.find(params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post = Post.find(params[:id])
        if post.update(post_params)
          redirect_to :action => "show", :id => post.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
      end

      

    private
    def post_params
        params.require(:post).permit(:title,:body,:image, tag_ids: [])
    end
    
    

end
