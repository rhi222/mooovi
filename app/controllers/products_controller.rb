class ProductsController < RankingController
	before_action :authenticate_user!, only: :search	
	def index
		# productsテーブルから最新順に作品を２０件取得する
		@products = Product.order('id ASC').limit(20)
	end
	
	def show
		@product = Product.find(params[:id])
	end
	
	def search
		@products = Product.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
	end
end
