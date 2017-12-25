class ProductResource < JSONAPI::Resource
  attributes :name, :category, :sold_out, :under_sale, :price, :sale_price, :sale_text
  filters :category, :price

  # def self.find_records(filters, options = {})
  #   byebug
  #   rel = _model_class
  #   filters.each do |attr, filter|
  #     if attr.to_s == "price"
  #     	filter_query = case filter[0].keys[0]
  #     		when "gte"
  #     			"price >= #{filter[0]['gte']}"
  #     		when "lte"
  #     			"price >= #{filter[0]['lte']}"
  #     		when "gt"
  #     			"price >= #{filter[0]['gt']}"
  #     		when "lt"
  #     			"price >= #{filter[0]['lt']}"
  #     		when "eq"
  #     			"price >= #{filter[0]['eq']}"
  #     		else
  #     			"price = filter[0]"
  #     		end 
  #     	rel = rel.where(filter_query)
  #     else
  #       rel = rel.where(category: filter)
  #     end
  #   end
  #   rel
  # end

  def self.apply_filter(records, filter, value, options)
	  case filter
	    when :price
	      if value.is_a?(Array) && !value[0].is_a?(String)
	        filter_query = case value[0].keys[0]
      		when "gte"
      			"price >= #{value[0]['gte']}"
      		when "lte"
      			"price >= #{value[0]['lte']}"
      		when "gt"
      			"price >= #{value[0]['gt']}"
      		when "lt"
      			"price >= #{value[0]['lt']}"
      		when "eq"
      			"price >= #{value[0]['eq']}"
      		when "between"
      			ranges_filter = value[0]['between'].split(',')
      			range_query = []
      			ranges_filter.each do |i|
      				min_max_range = i.split('-')
      				range_query  << "(price >= #{min_max_range[0]} and price <= #{min_max_range[1]})"
      			end
      			range_query.join(' or ')
      		else
      			"price = #{value}"
      		end
	        records = records.where(filter_query)
	      else
	        super(records, filter, value)
	      end
	    else
	      super(records, filter, value)
	  end
	end

end
