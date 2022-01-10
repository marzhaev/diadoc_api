module DiadocApi::Exceptions
  class ConfigurationException < Exception
  end

  class MethodNotSet < Exception
  end

  class ServerException < Exception
  end

  class Unauthenticated < Exception
  end

  class WrongRequest < Exception
  end
end
