class Utility
    TOKEN_VALIDITY=APP_CONFIG['toke_duration']
    SECRETY_KEY=APP_CONFIG['secrety_key']

    def self.encode(data, exp = TOKEN_VALIDITY.hours.from_now)
        data[:exp] = exp.to_i
        JWT.encode(data, SECRETY_KEY,"HS256")
    end

    def self.decode(token)
        decoded = JWT.decode(token, SECRETY_KEY,"HS256")[0]
        HashWithIndifferentAccess.new decoded
    end

end 