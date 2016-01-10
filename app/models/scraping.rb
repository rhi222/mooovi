class Scraping
	def self.movie_urls
		puts 'get movies link URL'
		agent = Mechanize.new
		links = []
		next_url = "/now/"

		while true do
			main_page = agent.get("http://eiga.com" + next_url)
			url_htmls = main_page.search(".m_unit h3 a")
			url_htmls.each do |url_html|
				link = "http://eiga.com" + url_html.get_attribute("href")
				links << link
			end

			next_link = main_page.at('.pagination .next_page')
			puts next_link
			next_url = next_link[:href]
			puts next_url

			get_product(links)
			unless next_url != ""
				exit
			end

		end
	end
		
	def self.get_product(links)
		puts 'get movie information'
		agent = Mechanize.new
		links.each do |link|
			detail_page = agent.get(link)
			title = detail_page.at('.moveInfoBox h1').inner_text
			image_url = detail_page.at('.pictBox img')[:src] if detail_page.at('.pictBox img')
			director = detail_page.at('.f span').inner_text if detail_page.at('.f span')
			detail = detail_page.at('.outline p').inner_text
			open_date = detail_page.at('.opn_date strong').inner_text if detail_page.at('.opn_date strong')
			
			product = Product.where(title: title, image_url: image_url).first_or_initialize
			product.director = director
			product.detail = detail
			product.open_date = open_date
			product.save
		end
	end
end
