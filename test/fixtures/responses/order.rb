module Responses
  
  module Order
    
    All = %|HTTP/1.1 200 OK
Date: Thu, 03 Sep 2009 15:56:44 GMT
Server: Mongrel 1.1.3
Status: 200 OK
Cache-Control: no-cache
Content-Type: application/xml; charset=utf-8
Content-Length: 2137
Vary: Accept-Encoding
Connection: close

<?xml version="1.0" encoding="UTF-8"?>
<orders end_at="2009-09-03T11:56:44-04:00" start_at="2009-08-04T11:56:44-04:00">
  <order>
<id type="integer">422815</id>
<domain>srv02.wavepath.com</domain>
<geotrust-order-id>93520</geotrust-order-id>
<status-major>Complete</status-major>
<status-minor>Order Complete</status-minor>
<years type="integer">1</years>
<licenses type="integer">1</licenses>
<created-at type="datetime">2009-08-12T16:43:02-04:00</created-at>
<completed-at type="datetime">2009-08-12T16:45:06-04:00</completed-at>
<trial type="boolean">false</trial>
<renewal type="boolean">false</renewal>
<sans></sans>
<state>COMPLETED</state>
<total-price type="float">69</total-price>
<pending-audit type="boolean">false</pending-audit>
<product>
  <sku>Q</sku>
</product>
  </order>
  <order>
<id type="integer">422816</id>
<domain>srv02.wavepath.com</domain>
<geotrust-order-id>93693</geotrust-order-id>
<status-major>Cancelled</status-major>
<status-minor>Order Complete</status-minor>
<years type="integer">1</years>
<licenses type="integer">1</licenses>
<created-at type="datetime">2009-08-14T09:52:31-04:00</created-at>
<completed-at type="datetime">2009-08-14T09:54:04-04:00</completed-at>
<trial type="boolean">false</trial>
<renewal type="boolean">true</renewal>
<sans></sans>
<state>COMPLETED</state>
<total-price type="float">69</total-price>
<pending-audit type="boolean">false</pending-audit>
<product>
  <sku>Q</sku>
</product>
  </order>
  <order>
<id type="integer">422817</id>
<domain>srv02.wavepath.com</domain>
<geotrust-order-id>93698</geotrust-order-id>
<status-major>Cancelled</status-major>
<status-minor>Order Cancelled</status-minor>
<years type="integer">1</years>
<licenses type="integer">1</licenses>
<created-at type="datetime">2009-08-14T11:12:26-04:00</created-at>
<completed-at type="datetime">2009-08-14T11:13:19-04:00</completed-at>
<trial type="boolean">false</trial>
<renewal type="boolean">true</renewal>
<sans></sans>
<state>REJECTED</state>
<total-price type="float">69</total-price>
<pending-audit type="boolean">false</pending-audit>
<product>
  <sku>Q</sku>
</product>
  </order>
</orders>
|
    
    Order = %|HTTP/1.1 200 OK
Date: Thu, 03 Sep 2009 16:23:03 GMT
Server: Mongrel 1.1.3
Status: 200 OK
Cache-Control: no-cache
Content-Type: application/xml; charset=utf-8
Content-Length: 704
Vary: Accept-Encoding
Connection: close

<?xml version="1.0" encoding="UTF-8"?>
<order>
<id type="integer">422815</id>
<domain>srv02.wavepath.com</domain>
<geotrust-order-id>93520</geotrust-order-id>
<status-major>Complete</status-major>
<status-minor>Order Complete</status-minor>
<years type="integer">1</years>
<licenses type="integer">1</licenses>
<created-at type="datetime">2009-08-12T16:43:02-04:00</created-at>
<completed-at type="datetime">2009-08-12T16:45:06-04:00</completed-at>
<trial type="boolean">false</trial>
<renewal type="boolean">false</renewal>
<sans></sans>
<state>COMPLETED</state>
<total-price type="float">69</total-price>
<pending-audit type="boolean">false</pending-audit>
<product>
  <sku>Q</sku>
</product>
</order>
|
    
    DomainMissing = %|HTTP/1.1 422 Unprocessable Entity
Date: Thu, 03 Sep 2009 16:58:44 GMT
Server: Mongrel 1.1.3
Status: 422 Unprocessable Entity
Cache-Control: no-cache
Content-Type: application/xml; charset=utf-8
Content-Length: 156
Vary: Accept-Encoding
Connection: close

<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error>
    <code>-90001</code>
    <message>You must supply a domain name</message>
  </error>
</errors>
|

    Approvers = %|HTTP/1.1 200 OK
Date: Thu, 03 Sep 2009 16:59:37 GMT
Server: Mongrel 1.1.3
Status: 200 OK
Cache-Control: no-cache
Content-Type: application/xml; charset=utf-8
Content-Length: 634
Vary: Accept-Encoding
Connection: close

<?xml version="1.0" encoding="UTF-8"?>
<emails>
  <email>blank@geocerts.com</email>
  <email>admin@geocerts.com</email>
  <email>administrator@geocerts.com</email>
  <email>hostmaster@geocerts.com</email>
  <email>root@geocerts.com</email>
  <email>ssladmin@geocerts.com</email>
  <email>sysadmin@geocerts.com</email>
  <email>webmaster@geocerts.com</email>
  <email>info@geocerts.com</email>
  <email>is@geocerts.com</email>
  <email>it@geocerts.com</email>
  <email>mis@geocerts.com</email>
  <email>ssladministrator@geocerts.com</email>
  <email>sslwebmaster@geocerts.com</email>
  <email>postmaster@geocerts.com</email>
</emails>
|
    
    BadModifyResponse = %|HTTP/1.1 422 Unprocessable Entity 
Date: Thu, 03 Sep 2009 17:17:35 GMT 
Server: Mongrel 1.1.3 
Status: 422 Unprocessable Entity 
Cache-Control: no-cache 
Content-Type: application/xml; charset=utf-8 
Content-Length: 181 
Vary: Accept-Encoding 
Connection: close 

<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error>
    <code>-90003</code>
    <message>Desired order state must be provided (CANCEL, APPROVE)</message>
  </error>
</errors>
|
    
    WrongState = %|HTTP/1.1 422 Unprocessable Entity 
Date: Thu, 03 Sep 2009 17:33:08 GMT 
Server: Mongrel 1.1.3 
Status: 422 Unprocessable Entity 
Cache-Control: no-cache 
Content-Type: application/xml; charset=utf-8 
Content-Length: 179 
Vary: Accept-Encoding 
Connection: close 

<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error>
    <code>-90002</code>
    <message>Order #422815 is in the wrong state for cancellation</message>
  </error>
</errors>
|
    
    Validation = %|HTTP/1.1 200 OK
Date: Thu, 03 Sep 2009 16:23:03 GMT
Server: Mongrel 1.1.3
Status: 200 OK
Cache-Control: no-cache
Content-Type: application/xml; charset=utf-8
Content-Length: 534
Vary: Accept-Encoding
Connection: close

<?xml version="1.0" encoding="UTF-8"?>
<order>
<total-price type="float">69</total-price>
<csr>
<common-name>www.example.com</common-name>
<city>Atlanta</city>
<state>GA</state>
<country>US</country>
<organization>GeoCerts Inc</organization>
<org-unit>Internet</org-unit>
</csr>
<renewal-info>
<indicator type="boolean">true</indicator>
<months type="integer">1</months>
<serial-number>abC12De</serial-number>
<order-id>1234ab</order-id>
<expiration-date type="datetime">2009-01-01T00:00:00Z</expiration-date>
</renewal-info>
</order>
|
  end
  
end
