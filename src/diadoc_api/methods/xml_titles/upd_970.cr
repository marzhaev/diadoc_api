module DiadocApi
  class Upd970
    property document_date : Time?
    property document_number : String?
    property seller_info : OrgInfo
    property buyer_info : OrgInfo
    property consignee : OrgInfo?
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
        io << "<UniversalTransferDocument Function=\"СЧФДОП\" DocumentDate=\"#{document_date.not_nil!.to_s("%d.%m.%Y")}\" DocumentNumber=\"#{document_number.not_nil!}\" DocumentCreator=\"1\" Currency=\"643\">"
          io << "<Sellers>"
            io << "<Seller>"
              organization_details(io, seller_info)
            io << "</Seller>"
          io << "</Sellers>"
          io << "<Buyers>"
            io << "<Buyer>"
              organization_details(io, buyer_info)
            io << "</Buyer>"
          io << "</Buyers>"
          io << "<Shippers>"
            io << "<Shipper SameAsSeller=\"true\">"
            io << "</Shipper>"
          io << "</Shippers>"
          io << "<Consignees>"
            io << "<Consignee>"
              organization_details(io, consignee || buyer_info)
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
            io << "<TransferInfo OperationInfo=\"Товары переданы\" TransferDate=\"#{document_date.not_nil!.to_s("%d.%m.%Y")}\">"
              io << "<TransferBases>"
                transfer_bases.each do |item|
                  io << item.to_xml
                end
              io << "</TransferBases>"
            io << "</TransferInfo>"
          end
          io << "<Signers BoxId=\"#{seller_info.box_id}\">"
            io << "<Signer"
            # Inn=\"#{signer_inn}\""
            io << " SignerStatus=\"1\""
            io << " SigningDate=\"#{document_date.not_nil!.to_s("%d.%m.%Y")}\""
            io << " SignerPowersConfirmationMethod=\"1\">"
              io << "<Fio"
                io << " LastName=\"#{signer_last_name}\""
                io << " FirstName=\"#{signer_first_name}\""
                io << " MiddleName=\"#{signer_middle_name}\""
              io << "/>"
              # io << "<Position PositionSource=\"Certificate\"/>"
              # io << "<SignerAdditionalInfo SignerAdditionalInfoSource=\"StorageByTitleTypeId\"/>"
            io << "</Signer>"
          io << "</Signers>"
          io << "<DocumentShipments>"
            io << "<DocumentShipment DocumentName=\"Счет-фактура и документ об отгрузке товаров (выполнении работ), передаче имущественных прав (документ об оказании услуг)\" DocumentNumber=\"#{document_number.not_nil!}\" DocumentDate=\"#{document_date.not_nil!.to_s("%d.%m.%Y")}\">"
            io << "</DocumentShipment>"
          io << "</DocumentShipments>"
        io << "</UniversalTransferDocument>"
      end
    end

    # As per ExtendedOrganizationInfoUtd970 from UserContractXsd
    def organization_details(io : String::Builder, org : OrgInfo)
      # 1 - для ООО
      # 2 - для ИП
      org_type = org.inn.try(&.size) == 12 ? 1 : 2
      io << "<OrganizationDetails OrgType=\"#{org_type}\" Inn=\"#{org.inn}\" Kpp=\"#{org.kpp}\" FnsParticipantId=\"#{org.fns_id}\" OrgName=\"#{org.name.not_nil!.gsub('"', "'")}\">"
        io << "<Address>"
          io << "<RussianAddress"
          io << " ZipCode=\"#{org.zip_code}\"" if !org.zip_code.try(&.empty?) #индекс
          io << " Region=\"#{org.region}\"" # регион(код)
          io << " City=\"#{org.city}\"" if !org.city.try(&.empty?) # город
          io << " Street=\"#{org.street}\"" if !org.street.try(&.empty?) # улица
          io << " Building=\"#{org.building}\"" if !org.building.try(&.empty?) # дом
          io << " Block=\"#{org.block}\"" if !org.block.try(&.empty?) # корпус
          io << " Apartment=\"#{org.appartment}\"" if !org.appartment.try(&.empty?) # квартира
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
          io << "<TransferBase DocumentName=\"УПД\" DocumentNumber=\"#{@document_name.not_nil!}\" DocumentDate=\"#{@document_date.not_nil!.to_s("%d.%m.%Y")}\">"
          io << "</TransferBase>"
        end
      end
    end

    struct TableItem
      property product : String? = nil
      property unit : Unit? = nil
      property quantity : Int32? = nil
      property price : Float64? = nil
      # TODO convert to Enum as per <xs:simpleType name="TaxRateUtd970">
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
          io << " TaxRate=\"TwentyPercent\""
          # io << " TaxRate=\"#{@tax_rate.not_nil!.to_diadoc}\""
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
        in Pack then "778"
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
