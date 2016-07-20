class Transaction
  attr_reader :date
  attr_reader :description
  attr_reader :credit
  attr_reader :charge
  attr_reader :link
  
  def initialize(args)
    @date = args[:date]
    @description = args[:description]
    @credit = args[:credit]
    @charge = args[:charge]
    @link = args[:link]
  end

  def modify_balance(balance)
    if @credit
      balance - @credit
    elsif @charge
      balance + @charge
    else
      balance
    end
  end
end
