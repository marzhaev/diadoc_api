module DiadocApi
  module Entity
    enum RecipientResponseStatus
    RecipientResponseStatusUnknown
    RecipientResponseStatusNotAcceptable
    WaitingForRecipientSignature
    WithRecipientSignature
    RecipientSignatureRequestRejected
    InvalidRecipientSignature
    WithRecipientPartiallySignature
    end
  end
end
