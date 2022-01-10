module DiadocApi
  class FilterCategory
    def initialize(@document_type : DocumentType, @document_class : DocumentClass, @document_status : DocumentStatus)
    end

    def to_request : String
      String.build do |io|
        io << @document_type.to_s
        io << "."
        io << @document_class.to_s
        io << @document_status.to_s unless @document_status.any?
      end
    end

    def self.default : FilterCategory
      self.new(DocumentType::AnyBilateralDocumentType, DocumentClass::Outbound, DocumentStatus::Any)
    end

    enum DocumentType
    AnyInvoiceDocumentType
    AnyBilateralDocumentType
    AnyUnilateralDocumentType
    Nonformalized
    Invoice
    Torg12
    XmlTorg12
    end

    enum DocumentClass
    Inbound
    Outbound
    Internal
    Proxy
    end

    enum DocumentStatus
    Any
    NotRead
    NoRecipientSignatureRequest
    WaitingForRecipientSignature
    WithRecipientSignature
    WithRecipientPartiallySignature
    WithSenderSignature
    RecipientSignatureRequestRejected
    WaitingForSenderSignature
    InvalidSenderSignature
    InvalidRecipientSignature
    Approved
    Disapproved
    WaitingForResolution
    SignatureRequestRejected
    Finished
    HaveToCreateReceipt
    NotFinished
    InvoiceAmendmentRequested
    RevocationIsRequestedByMe
    RequestsMyRevocation
    RevocationAccepted
    RevocationRejected
    RevocationApproved
    RevocationDisapproved
    WaitingForRevocationApprovement
    NotRevoked
    WaitingForProxySignature
    WithProxySignature
    InvalidProxySignature
    ProxySignatureRejected
    WaitingForInvoiceReceipt
    WaitingForReceipt
    RequestsMySignature
    RoamingNotificationError
    end
  end
end
