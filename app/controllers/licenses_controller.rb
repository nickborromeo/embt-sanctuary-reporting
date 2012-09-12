class LicensesController < ApplicationController
  
  layout "main", :except => [:get_licenses]
  
  $sDate = ""
  $eDate = ""
  $company = ""
  $prod_family = ""

  def index
  end

  def show
    render 'export_excel'
  end
  
  def get_prod_family(division)
    
    prod_family = if division == "1"
                    "And Slp.Division_Id = 1"
                  elsif division == "2"
                    "And Slp.Division_Id = 2"
                  else
                    "And (Slp.Division_Id = 1 OR Slp.Division_Id = 2)"
                  end
  end
  
  def get_licenses
    $sDate = params[:start_date] || ""
    $eDate = params[:end_date] || ""
    $company = params[:account_name].upcase || ""
    $prod_family = get_prod_family(params[:prod_family])
    
    @licenses ||= Kaminari.paginate_array(ActiveRecord::Base.connection.select_rows("Select DISTINCT CONCAT(C.First_Name, CONCAT(' ', C.Last_Name)),  ssb.serial_number, C.E_Mail, con.COMPANY, slp.TITLE, sp.DESCRIPTION, spv.PRODUCT_VERSION, oi.PID, C.Country, sli.created from WEBMGR.TABLE_CONTACT c, WEBMGR.SANCT_SERIALNO_BANK ssb, WEBMGR.SANCT_LICENSE_ISSUANCE sli, WEBMGR.SANCT_LICENSE_PACKAGE slp,  SANCTUARY.PART_INSTANCE_SERIAL pis, SANCTUARY.ORDER_ITEM oi, SANCTUARY.ORDER_CONTACT oc, SANCTUARY.CONTACT con, WEBMGR.SANCT_PRODUCT sp, WEBMGR.SANCT_PRODUCT_VERSION spv, WEBMGR.SANCT_PRODUCT_SKU spsku, WEBMGR.SANCT_LICENSE_CONFIG slc where (c.USERID = sli.USER_ID) and (ssb.SERIAL_ID = sli.SERIAL_ID) and (ssb.SERIAL_ID = pis.SERIAL_ID) and (slp.PACKAGE_ID = ssb.PACKAGE_ID) and (pis.INSTANCE_ID = oi.INSTANCE_ID) and (oi.ORDER_ID = oc.ORDER_ID) And (Oc.Contact_Id = Con.Contact_Id) AND (sp.PRODUCT_ID = spv.PRODUCT_ID) AND (spv.VERSION_ID = spsku.VERSION_ID) AND (spsku.VERSION_ID  = slc.VERSION_ID) AND (slc.CONFIG_ID = slp.HOST_LICENSE_CFG) AND (c.upper_company_name IS NULL OR c.upper_company_name not like 'EMBARCADERO%') AND c.upper_e_mail not like '%@CODEGEAR.COM'And C.Upper_E_Mail Not Like '%@EMBARCADERO.COM'AND con.upper_company not like 'EMBARCADERO%' AND con.upper_email not like '%@CODEGEAR.COM'AND con.upper_email not like '%@EMBARCADERO.COM'and c.employee = 'F' and con.employee = 'F' and slp.company_id = 1 "+$prod_family+" AND upper(con.COMPANY) LIKE '%"+$company+"%' And Sli.Created Between To_Date ('"+$sDate+"', 'mm/dd/yyyy') And To_Date ('"+$eDate+"', 'mm/dd/yyyy') ORDER BY  con.COMPANY, sli.created")).page(params[:page]).per(100)
    
  end
  
  def export_excel
    
    @export = ActiveRecord::Base.connection.select_rows("Select DISTINCT CONCAT(C.First_Name, CONCAT(' ', C.Last_Name)),  ssb.serial_number, C.E_Mail, con.COMPANY, slp.TITLE, sp.DESCRIPTION, spv.PRODUCT_VERSION, oi.PID, C.Country, sli.created from WEBMGR.TABLE_CONTACT c, WEBMGR.SANCT_SERIALNO_BANK ssb, WEBMGR.SANCT_LICENSE_ISSUANCE sli, WEBMGR.SANCT_LICENSE_PACKAGE slp,  SANCTUARY.PART_INSTANCE_SERIAL pis, SANCTUARY.ORDER_ITEM oi, SANCTUARY.ORDER_CONTACT oc, SANCTUARY.CONTACT con, WEBMGR.SANCT_PRODUCT sp, WEBMGR.SANCT_PRODUCT_VERSION spv, WEBMGR.SANCT_PRODUCT_SKU spsku, WEBMGR.SANCT_LICENSE_CONFIG slc where (c.USERID = sli.USER_ID) and (ssb.SERIAL_ID = sli.SERIAL_ID) and (ssb.SERIAL_ID = pis.SERIAL_ID) and (slp.PACKAGE_ID = ssb.PACKAGE_ID) and (pis.INSTANCE_ID = oi.INSTANCE_ID) and (oi.ORDER_ID = oc.ORDER_ID) And (Oc.Contact_Id = Con.Contact_Id) AND (sp.PRODUCT_ID = spv.PRODUCT_ID) AND (spv.VERSION_ID = spsku.VERSION_ID) AND (spsku.VERSION_ID  = slc.VERSION_ID) AND (slc.CONFIG_ID = slp.HOST_LICENSE_CFG) AND (c.upper_company_name IS NULL OR c.upper_company_name not like 'EMBARCADERO%') AND c.upper_e_mail not like '%@CODEGEAR.COM'And C.Upper_E_Mail Not Like '%@EMBARCADERO.COM'AND con.upper_company not like 'EMBARCADERO%' AND con.upper_email not like '%@CODEGEAR.COM'AND con.upper_email not like '%@EMBARCADERO.COM'and c.employee = 'F' and con.employee = 'F' and slp.company_id = 1 "+$prod_family+" AND con.COMPANY LIKE '%"+$company+"%' And Sli.Created Between To_Date ('"+$sDate+"', 'mm/dd/yyyy') And To_Date ('"+$eDate+"', 'mm/dd/yyyy')")
    
      respond_to do |format|
        format.xls
      end
  end
  
end