#INCLUDE 'Protheus.ch'
#INCLUDE 'ApWebSRV.ch'
#INCLUDE 'TbiConn.ch'

WSSERVICE SEVERTIME Description "Veja o horário atual"

WSDATA Horário   as String 
WSDATA Parametro as String
WSMETHOD GetServerTime Description "Método de visualização de horario"
ENDWSSERVICE
WSMETHOD GetServerTime WSRECEIVE Parametro WSSEND Horário WSSERVICE SEVERTIME
::Horário := Time()
Return .T.
