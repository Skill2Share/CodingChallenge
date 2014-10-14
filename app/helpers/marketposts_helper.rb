module MarketpostsHelper
	def count_to_menu(tags)
		max = tags.sort_by(&:count).last
		newmax = tags.sort_by(&:count).reverse
		newmax.first(10).each do |tag|
    		yield(tag )
  		end
  	end
end
