
class ResponseSerializer < BaseSerializer
    def initialize(@response : Response)
    end
    def render
        {
            response: @response.response,
            guest: GuestSerializer.new(@response.guest)
        }
    end
end