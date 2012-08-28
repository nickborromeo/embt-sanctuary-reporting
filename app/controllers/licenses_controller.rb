class LicensesController < ApplicationController
  
  layout "main", :except => [:get_licenses, :get_licenses_company]

  def index
  end

  def show
      
  end
  
  def get_licenses
    date1 = params[:start_date] || ""
    date2 = params[:end_date] || ""
    
    @licenses = ActiveRecord::Base.connection.select_rows("Select CONCAT(C.First_Name, CONCAT(' ', C.Last_Name)), C.Company_Name, con.COMPANY, C.E_Mail, C.Phone, C.Address_1, C.City, C.State, C.Zipcode, C.Country, C.Language, C.Wants_Email, slp.TITLE, slp.free, ssb.serial_number, sli.created from WEBMGR.TABLE_CONTACT c, WEBMGR.SANCT_SERIALNO_BANK ssb, WEBMGR.SANCT_LICENSE_ISSUANCE sli, WEBMGR.SANCT_LICENSE_PACKAGE slp, SANCTUARY.PART_INSTANCE_SERIAL pis, SANCTUARY.ORDER_ITEM oi, SANCTUARY.ORDER_CONTACT oc, SANCTUARY.CONTACT con where (c.USERID = sli.USER_ID) and (ssb.SERIAL_ID = sli.SERIAL_ID) and (ssb.SERIAL_ID = pis.SERIAL_ID) and (slp.PACKAGE_ID = ssb.PACKAGE_ID) and (pis.INSTANCE_ID = oi.INSTANCE_ID) and (oi.ORDER_ID = oc.ORDER_ID) And (Oc.Contact_Id = Con.Contact_Id) AND (c.upper_company_name IS NULL OR c.upper_company_name not like 'EMBARCADERO%') AND c.upper_e_mail not like '%@CODEGEAR.COM' And C.Upper_E_Mail Not Like '%@EMBARCADERO.COM' AND con.upper_company not like 'EMBARCADERO%' AND con.upper_email not like '%@CODEGEAR.COM' AND con.upper_email not like '%@EMBARCADERO.COM' and c.employee = 'F' and con.employee = 'F' and slp.company_id = 1 And Slp.Division_Id = 2 And Sli.Created Between To_Date ('"+date1+"', 'mm/dd/yyyy') And To_Date ('"+date2+"', 'mm/dd/yyyy') ORDER BY sli.created DESC")
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def get_licenses_company
    date1 = params[:start_date] || ""
    date2 = params[:end_date] || ""
    
    company = ""
    unless params[:account_name].nil? 
      company = "AND con.COMPANY LIKE '%"+params[:account_name]+"%'"
    end
    
    @licenses = ActiveRecord::Base.connection.select_rows("Select CONCAT(C.First_Name, CONCAT(' ', C.Last_Name)), C.Company_Name, con.COMPANY, C.E_Mail, C.Phone, C.Address_1, C.City, C.State, C.Zipcode, C.Country, C.Language, C.Wants_Email, slp.TITLE, slp.free, ssb.serial_number, sli.created from WEBMGR.TABLE_CONTACT c, WEBMGR.SANCT_SERIALNO_BANK ssb, WEBMGR.SANCT_LICENSE_ISSUANCE sli, WEBMGR.SANCT_LICENSE_PACKAGE slp, SANCTUARY.PART_INSTANCE_SERIAL pis, SANCTUARY.ORDER_ITEM oi, SANCTUARY.ORDER_CONTACT oc, SANCTUARY.CONTACT con where (c.USERID = sli.USER_ID) and (ssb.SERIAL_ID = sli.SERIAL_ID) and (ssb.SERIAL_ID = pis.SERIAL_ID) and (slp.PACKAGE_ID = ssb.PACKAGE_ID) and (pis.INSTANCE_ID = oi.INSTANCE_ID) and (oi.ORDER_ID = oc.ORDER_ID) And (Oc.Contact_Id = Con.Contact_Id) AND (c.upper_company_name IS NULL OR c.upper_company_name not like 'EMBARCADERO%') AND c.upper_e_mail not like '%@CODEGEAR.COM' And C.Upper_E_Mail Not Like '%@EMBARCADERO.COM' AND con.upper_company not like 'EMBARCADERO%' AND con.upper_email not like '%@CODEGEAR.COM' AND con.upper_email not like '%@EMBARCADERO.COM' and c.employee = 'F' and con.employee = 'F' and slp.company_id = 1 And Slp.Division_Id = 2 And Sli.Created Between To_Date ('"+date1+"', 'mm/dd/yyyy') And To_Date ('"+date2+"', 'mm/dd/yyyy') "+company+"  ORDER BY sli.created DESC")
    
    respond_with(@licenses)
  end
  
end
