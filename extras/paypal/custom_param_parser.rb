module PayPal
  class CustomParamParser
    def initialize raw_param
      @raw  = raw_param
      @args = raw_param.split /,/
    end

    def wedding_id
      @args[0].to_i
    end

    def user_id
      @args[1].to_i
    end
  end
end
