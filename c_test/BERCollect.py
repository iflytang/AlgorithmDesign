from ncclient import manager
import xml.etree.ElementTree as ET
import xml.dom.minidom
from bs4 import BeautifulSoup
from io import StringIO
import time


host = '192.168.108.164'  # optical receiver IP
interface1 = 'och:1/1/2/1/2.1'


with manager.connect(host=host, port=2022, username="admin", password="admin", hostkey_verify=False) as m:
		# build a xml to describe the parameter that needs to collect
    doc = xml.dom.minidom.Document()
    root = doc.createElement('statistics')
    root.setAttribute('xmlns', "http://btisystems.com/ns/atlas")
    doc.appendChild(root)
    historical = doc.createElement('current')
    root.appendChild(historical)
    entity = doc.createElement('entity')
    historical.appendChild(entity)
    entityName = doc.createElement('entityName')
    entity.appendChild(entityName)
    entityName.appendChild(doc.createTextNode(str(interface1)))
    binLength = doc.createElement('binLength')
    entity.appendChild(binLength)
    length = doc.createElement('length')
    length.appendChild(doc.createTextNode('1Day'))
    binLength.appendChild(length)
    statisticList = doc.createElement('statisticList')
    statisticPoint = doc.createElement('statisticPoint')
    statisticList.appendChild(statisticPoint)
    statisticPoint.appendChild(doc.createTextNode('fec-ber'))
    binLength.appendChild(statisticList)
    out = StringIO()
    doc.writexml(out)
    s = out.getvalue()
    soup = BeautifulSoup(s, 'xml')

    f = open('BER.dat', 'w+')
    count = 0
    while count < 1000:
        count = count + 1
        # send parameter request to optical receiver and get the result
        result = m.get(filter=('subtree', soup)).data_xml
        # get the root of xml tree and parse the parameter.
        root = ET.fromstring(result)
        try:
            value = float(root[0][0][0][1][1][2].text)
            print(value)
            f.write(str(value)+'\n')
        except Exception as e:
            print(e)
            print('Wrong')
            f.write('Wrong\n')
        time.sleep(1)
