module DiadocApi
  class Upd820
    property document_date : Time?
    property document_number : String?
    property seller_info : OrgInfo
    property buyer_info : OrgInfo
    property vat_total : Float64?
    property total_w_vat : Float64?
    property signer_inn : String?
    property signer_last_name : String?
    property signer_middle_name : String?
    property signer_first_name : String?
    property signer_power_base : String?
    property table_items = [] of TableItem
    property payment_documents = [] of NamedTuple(date: Time, number: String, total: Float64)
    # Используется для заполнения поля "Основания передачи" что под табличной частью с товарами в УПД.
    property transfer_bases = [] of TransferBase

    def initialize(@seller_info : OrgInfo, @buyer_info : OrgInfo)
    end

    def add_transfer_base(base : TransferBase)
      transfer_bases.push(base)
    end

    def to_xml : String
      {% for ivar in @type.instance_vars %}
        raise "Property '{{ ivar.id }}' not set" if @{{ ivar.id }}.nil?
      {% end %}

      String.build do |io|
        io << "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        io << "<UniversalTransferDocumentWithHyphens Function=\"СЧФДОП\" DocumentDate=\"#{document_date.not_nil!.to_s("%d.%m.%Y")}\" DocumentNumber=\"#{document_number.not_nil!}\" DocumentCreator=\"1\" DocumentCreatorBase=\"1\" Currency=\"643\">"
          io << "<Sellers>"
            io << "<Seller>"
              organization_details(io, seller_info)
            io << "</Seller>"
          io << "</Sellers>"
          io << "<Buyers>"
            io << "<Buyer>"
              organization_details(io, buyer_info)
              # io << "<OrganizationReference OrgType=\"1\" BoxId=\"#{buyer_box_id}\"/>"
            io << "</Buyer>"
          io << "</Buyers>"
          io << "<Shippers>"
            io << "<Shipper SameAsSeller=\"true\">"
            io << "</Shipper>"
          io << "</Shippers>"
          io << "<Consignees>"
            io << "<Consignee>"
              organization_details(io, buyer_info)
            io << "</Consignee>"
          io << "</Consignees>"
          if !payment_documents.empty?
            io << "<PaymentDocuments>"
              payment_documents.each do |document|
                io << "<Document"
                io << " Date=\"#{document[:date].to_s("%d.%m.%Y")}\""
                io << " Number=\"#{document[:number]}\""
                io << " Total=\"#{document[:total].round(2)}\""
                io << "/>"
              end
            io << "</PaymentDocuments>"
          end
          # Надо итого НДС и итого с НДС
          io << "<Table Vat=\"#{vat_total}\" Total=\"#{total_w_vat}\""
          if (l = total_w_vat) && (r = vat_total) && (l > r)
            io << " TotalWithVatExcluded=\"#{(l - r).round(2)}\""
          end
          io << ">"
            table_items.each do |item|
              io << item.to_xml
            end
          io << "</Table>"
          if transfer_bases.size > 0
            io << "<TransferInfo OperationInfo=\"Товары переданы\">"
              io << "<TransferBases>"
                transfer_bases.each do |item|
                  io << item.to_xml
                end
              io << "</TransferBases>"
            io << "</TransferInfo>"
          end
          io << "<Signers>"
            io << "<SignerDetails Inn=\"#{signer_inn}\""
            io << " LastName=\"#{signer_last_name}\""
            io << " FirstName=\"#{signer_first_name}\""
            io << " MiddleName=\"#{signer_middle_name}\""
            io << " SignerPowers=\"5\""
            io << " SignerType=\"1\""
            io << " SignerStatus=\"1\""
            io << " SignerPowersBase=\"Устав\"/>"
          io << "</Signers>"
        io << "</UniversalTransferDocumentWithHyphens>"
      end
    end

    def organization_details(io : String::Builder, org : OrgInfo)
      io << "<OrganizationDetails OrgType=\"1\" Inn=\"#{org.inn}\" Kpp=\"#{org.kpp}\" FnsParticipantId=\"#{org.fns_id}\" OrgName=\"#{org.name.not_nil!.gsub('"', "'")}\">"
        io << "<Address>"
          io << "<RussianAddress"
          io << " ZipCode=\"#{org.zip_code}\"" if !org.zip_code.try(&.empty?)
          io << " Region=\"#{org.region}\""
          io << " City=\"#{org.city}\"" if !org.city.try(&.empty?)
          io << " Street=\"#{org.street}\"" if !org.street.try(&.empty?)
          io << " Building=\"#{org.building}\"" if !org.building.try(&.empty?)
          io << " Block=\"#{org.block}\"" if !org.block.try(&.empty?)
          io << " Apartment=\"#{org.appartment}\"" if !org.appartment.try(&.empty?)
          io << "/>"
        io << "</Address>"
      io << "</OrganizationDetails>"
    end

    struct OrgInfo
      property box_id : String?
      property fns_id : String?
      property inn : String?
      property kpp : String?
      property name : String?
      property zip_code : String?
      property region : String?
      property city : String?
      property street : String?
      property building : String?
      property block : String?
      property appartment : String?
    end

    struct TransferBase
      property document_name : String? = nil
      property document_date : Time? = nil

      def initialize(@document_name : String, @document_date : Time)
      end

      def to_xml : String
        {% for ivar in @type.instance_vars %}
          raise "Property '{{ ivar.id }}' not set" if @{{ ivar.id }}.nil?
        {% end %}

        String.build do |io|
          io << "<TransferBase BaseDocumentName=\"#{@document_name.not_nil!}\" BaseDocumentDate=\"#{@document_date.not_nil!.to_s("%d.%m.%Y")}\">"
          io << "</TransferBase>"
        end
      end
    end

    struct TableItem
      property product : String? = nil
      property unit : Unit? = nil
      property quantity : Int32? = nil
      property price : Float64? = nil
      property tax_rate : TaxRate? = nil
      property total_wo_vat : Float64? = nil
      property vat : Float64? = nil
      property item_mark : ItemMark? = nil
      property item_vendor_code : String? = nil
      property subtotal : Float64? = nil
      property country_code : String? = nil
      property declaration_number : String? = nil

      def to_xml : String
        {% for ivar in @type.instance_vars %}
          raise "Property '{{ ivar.id }}' not set" if @{{ ivar.id }}.nil?
        {% end %}

        String.build do |io|
          io << "<Item Product=\"#{@product}\""
          io << " Unit=\"#{@unit.not_nil!.to_diadoc}\""
          io << " Quantity=\"#{@quantity}\""
          io << " Price=\"#{@price}\""
          io << " TaxRate=\"#{@tax_rate.not_nil!.to_diadoc}\""
          io << " SubtotalWithVatExcluded=\"#{@total_wo_vat}\""
          io << " Vat=\"#{@vat}\""
          io << " ItemMark=\"#{@item_mark.not_nil!.value}\""
          io << " ItemVendorCode=\"#{@item_vendor_code}\"" unless @item_vendor_code.try(&.empty?)
          io << " ItemArticle=\"#{@item_vendor_code}\"" unless @item_vendor_code.try(&.empty?)
          io << " Subtotal=\"#{@subtotal}\">"
            unless country_code.try(&.empty?) || declaration_number.try(&.empty?)
              io << "<CustomsDeclarations>"
                io << "<CustomsDeclaration Country=\"#{country_code}\" DeclarationNumber=\"#{declaration_number}\"/>"
              io << "</CustomsDeclarations>"
            end
          io << "</Item>"
        end
      end
    end

    enum ItemMark
    Good = 1
    Service = 3
    end

    enum Unit
      Pack
      Piece
      Meter
      Kg

      def to_diadoc : String
        case self
        in Pack then "798"
        in Piece then "796"
        in Meter then "006"
        in Kg then "166"
        end
      end
    end

    enum TaxRate
      None
      Incl20
      Perc20

      def to_diadoc : String
        case self
        in None   then "без НДС"
        in Incl20 then "20/120"
        in Perc20 then "20%"
        end
      end
    end
  end
end
