require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter:'sqlite3', database:'leprosorium.db'}

class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  #elongs_to :comment
end
class Comment < ActiveRecord::Base
  belongs_to :post, foreign_key: 'post_id', class_name: 'Post'
  #has_many :posts, :dependent => :destroy
end

# before вызывается каждый раз при перезагрузке
# любой страницы

before do

end

# configure вызывается каждый раз при конфигурации приложения:
# когда изменился код программы И перезагрузилась страница

configure do

end

get '/' do
	# выбираем список постов из БД

	@posts= Post.order('id DESC') #'select * from Posts order by id desc'
	erb :index			
end

# обработчик get-запроса /new
# (браузер получает страницу с сервера)

get '/new' do
	erb :new
end

# обработчик post-запроса /new
# (браузер отправляет данные на сервер)

post '/new' do
  @posts= Post.new params[:post]
  @posts.save
  if @posts.save
    erb "Done"
  else
    @error = @posts.errors.full_messages.first
    erb :new
  end
end

get '/details/:post_id' do
 results = Post.find(params[:post_id])
 @row = results[0]
 @comments =  post.comment
 #comment#post
 #@comments = Comment.find_by(params[:post_id])
 #@post = @comment.posts.find(params[:post_id])
end

# обработчик post-запроса /details/...
# (браузер отправляет данные на сервер, мы их принимаем) 

post '/details/:post_id' do
  @comments = Comment.new params[:comment]
  @comments.save
  if @comments.save
    erb "Comments posted"
  else
    @error = @comments.errors.full_messages.first

  end
  #@post = Post.joins(:comments).where(post_id: params[:post_id])
end