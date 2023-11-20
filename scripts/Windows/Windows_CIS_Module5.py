import subprocess

def disable_btag_service():
    """
    Disables the 'Bluetooth Audio Gateway Service (btagservice)' service. 5.1 (L2) Ensure 'Bluetooth Audio Gateway Service (btagservice)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'btag', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Bluetooth Audio Gateway Service (btagservice)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Bluetooth Audio Gateway Service (btagservice)' service.")

    try:
        subprocess.run(['sc', 'config', 'btagservice', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Bluetooth Audio Gateway Service (btagservice)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Bluetooth Audio Gateway Service (btagservice)' service.")

def disable_bthserv_service():
    """
    Disables the 'Bluetooth Support Service (bthserv)' service. 5.2 (L2) Ensure 'Bluetooth Support Service (bthserv)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'bthserv', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Bluetooth Support Service (bthserv)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Bluetooth Support Service (bthserv)' service.")

def disable_browser_service():
    """
    Disables the 'Computer Browser (Browser)' service. 5.3 (L1) Ensure 'Computer Browser (Browser)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'browser', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Computer Browser (Browser)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Computer Browser (Browser)' service.")

def disable_mapsbroker_service():
    """
    Disables the 'Downloaded Maps Manager (MapsBroker)' service. 5.4 (L2) Ensure 'Downloaded Maps Manager (MapsBroker)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'mapsbroker', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Downloaded Maps Manager (MapsBroker)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Downloaded Maps Manager (MapsBroker)' service.")

def disable_lfsvc_service():
    """
    Disables the 'Geolocation Service (lfsvc)' service. 5.5 (L2) Ensure 'Geolocation Service (lfsvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'lfsvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Geolocation Service (lfsvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Geolocation Service (lfsvc)' service.")

def disable_iisadmin_service():
    """
    Disables the 'IIS Admin Service (IISADMIN)' service. 5.6 (L1) Ensure 'IIS Admin Service (IISADMIN)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'iisadmin', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'IIS Admin Service (IISADMIN)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'IIS Admin Service (IISADMIN)' service.")

def disable_irmon_service():
    """
    Disables the 'Infrared monitor service (irmon)' service. 5.7 (L1) Ensure 'Infrared monitor service (irmon)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'irmon', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Infrared monitor service (irmon)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Infrared monitor service (irmon)' service.")

def disable_sharedaccess_service():
    """
    Disables the 'Internet Connection Sharing (ICS) (SharedAccess)' service. 5.8 (L1) Ensure 'Internet Connection Sharing (ICS) (SharedAccess)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'SharedAccess', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Internet Connection Sharing (ICS) (SharedAccess)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Internet Connection Sharing (ICS) (SharedAccess)' service.")

def disable_lxssmanager_service():
    """
    Disables the 'LxssManager (LxssManager)' service. 5.10 (L1) Ensure 'LxssManager (LxssManager)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'LxssManager', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'LxssManager (LxssManager)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'LxssManager (LxssManager)' service.")

def disable_ftpsvc_service():
    """
    Disables the 'Microsoft FTP Service (FTPSVC)' service. 5.11 (L1) Ensure 'Microsoft FTP Service (FTPSVC)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'ftpsvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Microsoft FTP Service (FTPSVC)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Microsoft FTP Service (FTPSVC)' service.")

def disable_msiscsi_service():
    """
    Disables the 'Microsoft iSCSI Initiator Service (MSiSCSI)' service. 5.12 (L2) Ensure 'Microsoft iSCSI Initiator Service (MSiSCSI)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'MSiSCSI', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Microsoft iSCSI Initiator Service (MSiSCSI)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Microsoft iSCSI Initiator Service (MSiSCSI)' service.")

def disable_sshd_service():
    """
    Disables the 'OpenSSH SSH Server (sshd)' service. 5.13 (L1) Ensure 'OpenSSH SSH Server (sshd)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'sshd', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'OpenSSH SSH Server (sshd)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'OpenSSH SSH Server (sshd)' service.")

def disable_pnrpsvc_service():
    """
    Disables the 'Peer Name Resolution Protocol (PNRPsvc)' service. 5.14 (L2) Ensure 'Peer Name Resolution Protocol (PNRPsvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'PNRPsvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Peer Name Resolution Protocol (PNRPsvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Peer Name Resolution Protocol (PNRPsvc)' service.")

def disable_p2psvc_service():
    """
    Disables the 'Peer Networking Grouping (p2psvc)' service. 5.15 (L2) Ensure 'Peer Networking Grouping (p2psvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'p2psvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Peer Networking Grouping (p2psvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Peer Networking Grouping (p2psvc)' service.")

def disable_p2pimsvc_service():
    """
    Disables the 'Peer Networking Identity Manager (p2pimsvc)' service. 5.16 (L2) Ensure 'Peer Networking Identity Manager (p2pimsvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'p2pimsvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Peer Networking Identity Manager (p2pimsvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Peer Networking Identity Manager (p2pimsvc)' service.")

def disable_pnrpautoreg_service():
    """
    Disables the 'PNRP Machine Name Publication Service (PNRPAutoReg)' service. 5.17 (L2) Ensure 'PNRP Machine Name Publication Service (PNRPAutoReg)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'PNRPAutoReg', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'PNRP Machine Name Publication Service (PNRPAutoReg)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'PNRP Machine Name Publication Service (PNRPAutoReg)' service.")

def disable_spooler_service():
    """
    Disables the 'Print Spooler (Spooler)' service. 5.18 (L2) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'Spooler', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Print Spooler (Spooler)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Print Spooler (Spooler)' service.")

def disable_wercplsupport_service():
    """
    Disables the 'Problem Reports and Solutions Control Panel Support (wercplsupport)' service. 5.19 (L2) Ensure 'Problem Reports and Solutions Control Panel Support (wercplsupport)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'wercplsupport', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Problem Reports and Solutions Control Panel Support (wercplsupport)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Problem Reports and Solutions Control Panel Support (wercplsupport)' service.")

def disable_rasauto_service():
    """
    Disables the 'Remote Access Auto Connection Manager (RasAuto)' service. 5.20 (L2) Ensure 'Remote Access Auto Connection Manager (RasAuto)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'RasAuto', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Remote Access Auto Connection Manager (RasAuto)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Remote Access Auto Connection Manager (RasAuto)' service.")

def disable_sessionenv_service():
    """
    Disables the 'Remote Desktop Configuration (SessionEnv)' service. 5.21 (L2) Ensure 'Remote Desktop Configuration (SessionEnv)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'SessionEnv', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Remote Desktop Configuration (SessionEnv)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Remote Desktop Configuration (SessionEnv)' service.")

def disable_termservice_service():
    """
    Disables the 'Remote Desktop Services (TermService)' service. 5.22 (L2) Ensure 'Remote Desktop Services (TermService)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'TermService', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Remote Desktop Services (TermService)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Remote Desktop Services (TermService)' service.")

def disable_umrdpservice_service():
    """
    Disables the 'Remote Desktop Services UserMode Port Redirector (UmRdpService)' service. 5.23 (L2) Ensure 'Remote Desktop Services UserMode Port Redirector (UmRdpService)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'UmRdpService', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Remote Desktop Services UserMode Port Redirector (UmRdpService)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Remote Desktop Services UserMode Port Redirector (UmRdpService)' service.")

def disable_rpclocator_service():
    """
    Disables the 'Remote Procedure Call (RPC) Locator (RpcLocator)' service. 5.24 (L1) Ensure 'Remote Procedure Call (RPC) Locator (RpcLocator)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'RpcLocator', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Remote Procedure Call (RPC) Locator (RpcLocator)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Remote Procedure Call (RPC) Locator (RpcLocator)' service.")

def disable_remoteregistry_service():
    """
    Disables the 'Remote Registry (RemoteRegistry)' service. 5.25 (L2) Ensure 'Remote Registry (RemoteRegistry)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'RemoteRegistry', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Remote Registry (RemoteRegistry)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Remote Registry (RemoteRegistry)' service.")

def disable_remoteaccess_service():
    """
    Disables the 'Routing and Remote Access (RemoteAccess)' service. 5.26 (L1) Ensure 'Routing and Remote Access (RemoteAccess)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'RemoteAccess', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Routing and Remote Access (RemoteAccess)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Routing and Remote Access (RemoteAccess)' service.")

def disable_lanmanserver_service():
    """
    Disables the 'Server (LanmanServer)' service. 5.27 (L2) Ensure 'Server (LanmanServer)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'LanmanServer', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Server (LanmanServer)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Server (LanmanServer)' service.")

def disable_simptcp_service():
    """
    Disables the 'Simple TCP/IP Services (simptcp)' service. 5.28 (L1) Ensure 'Simple TCP/IP Services (simptcp)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'simptcp', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Simple TCP/IP Services (simptcp)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Simple TCP/IP Services (simptcp)' service.")

def disable_snmp_service():
    """
    Disables the 'SNMP Service (SNMP)' service. 5.29 (L2) Ensure 'SNMP Service (SNMP)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'SNMP', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'SNMP Service (SNMP)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'SNMP Service (SNMP)' service.")

def disable_sacsvr_service():
    """
    Disables the 'Special Administration Console Helper (sacsvr)' service. 5.30 (L1) Ensure 'Special Administration Console Helper (sacsvr)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'sacsvr', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Special Administration Console Helper (sacsvr)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Special Administration Console Helper (sacsvr)' service.")

def disable_ssdpsrv_service():
    """
    Disables the 'SSDP Discovery (SSDPSRV)' service. 5.31 (L1) Ensure 'SSDP Discovery (SSDPSRV)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'SSDPSRV', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'SSDP Discovery (SSDPSRV)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'SSDP Discovery (SSDPSRV)' service.")

def disable_upnphost_service():
    """
    Disables the 'UPnP Device Host (upnphost)' service. 5.32 (L1) Ensure 'UPnP Device Host (upnphost)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'upnphost', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'UPnP Device Host (upnphost)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'UPnP Device Host (upnphost)' service.")

def disable_wmsvc_service():
    """
    Disables the 'Web Management Service (WMSvc)' service. 5.33 (L1) Ensure 'Web Management Service (WMSvc)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'WMSvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Web Management Service (WMSvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Web Management Service (WMSvc)' service.")

def disable_wersvc_service():
    """
    Disables the 'Windows Error Reporting Service (WerSvc)' service. 5.34 (L2) Ensure 'Windows Error Reporting Service (WerSvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'WerSvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Windows Error Reporting Service (WerSvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Windows Error Reporting Service (WerSvc)' service.")

def disable_wecsvc_service():
    """
    Disables the 'Windows Event Collector (Wecsvc)' service. 5.35 (L2) Ensure 'Windows Event Collector (Wecsvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'Wecsvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Windows Event Collector (Wecsvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Windows Event Collector (Wecsvc)' service.")

def disable_wmpnetworksvc_service():
    """
    Disables the 'Windows Media Player Network Sharing Service (WMPNetworkSvc)' service. 5.36 (L1) Ensure 'Windows Media Player Network Sharing Service (WMPNetworkSvc)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'WMPNetworkSvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Windows Media Player Network Sharing Service (WMPNetworkSvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Windows Media Player Network Sharing Service (WMPNetworkSvc)' service.")

def disable_icssvc_service():
    """
    Disables the 'Windows Mobile Hotspot Service (icssvc)' service. 5.37 (L1) Ensure 'Windows Mobile Hotspot Service (icssvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'icssvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Windows Mobile Hotspot Service (icssvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Windows Mobile Hotspot Service (icssvc)' service.")

def disable_wpn_service():
    """
    Disables the 'Windows Push Notifications System Service (WpnService)' service. 5.38 (L2) Ensure 'Windows Push Notifications System Service (WpnService)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'WpnService', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Windows Push Notifications System Service (WpnService)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Windows Push Notifications System Service (WpnService)' service.")

def disable_push_to_install_service():
    """
    Disables the 'Windows PushToInstall Service (PushToInstall)' service. 5.39 (L2) Ensure 'Windows PushToInstall Service (PushToInstall)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'PushToInstall', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Windows PushToInstall Service (PushToInstall)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Windows PushToInstall Service (PushToInstall)' service.")

def disable_winrm_service():
    """
    Disables the 'Windows Remote Management (WS-Management) (WinRM)' service. 5.40 (L2) Ensure 'Windows Remote Management (WS-Management) (WinRM)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'WinRM', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Windows Remote Management (WS-Management) (WinRM)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Windows Remote Management (WS-Management) (WinRM)' service.")

def disable_w3svc_service():
    """
    Disables the 'World Wide Web Publishing Service (W3SVC)' service. 5.41 (L1) Ensure 'World Wide Web Publishing Service (W3SVC)' is set to 'Disabled' or 'Not Installed' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'W3SVC', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'World Wide Web Publishing Service (W3SVC)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'World Wide Web Publishing Service (W3SVC)' service.")

def disable_xboxgipsvc_service():
    """
    Disables the 'Xbox Accessory Management Service (XboxGipSvc)' service. 5.42 (L1) Ensure 'Xbox Accessory Management Service (XboxGipSvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'XboxGipSvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Xbox Accessory Management Service (XboxGipSvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Xbox Accessory Management Service (XboxGipSvc)' service.")

def disable_xblauthmanager_service():
    """
    Disables the 'Xbox Live Auth Manager (XblAuthManager)' service. 5.43 (L1) Ensure 'Xbox Live Auth Manager (XblAuthManager)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'XblAuthManager', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Xbox Live Auth Manager (XblAuthManager)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Xbox Live Auth Manager (XblAuthManager)' service.")

def disable_xblgamesave_service():
    """
    Disables the 'Xbox Live Game Save (XblGameSave)' service. 5.44 (L1) Ensure 'Xbox Live Game Save (XblGameSave)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'XblGameSave', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Xbox Live Game Save (XblGameSave)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Xbox Live Game Save (XblGameSave)' service.")

def disable_xboxnetapisvc_service():
    """
    Disables the 'Xbox Live Networking Service (XboxNetApiSvc)' service. 5.45 (L1) Ensure 'Xbox Live Networking Service (XboxNetApiSvc)' is set to 'Disabled' (Automated)
    """
    try:
        subprocess.run(['sc', 'config', 'XboxNetApiSvc', 'start=', 'disabled'], check=True)
        print("Successfully disabled 'Xbox Live Networking Service (XboxNetApiSvc)' service.")
    except subprocess.CalledProcessError:
        print("Error: Failed to disable 'Xbox Live Networking Service (XboxNetApiSvc)' service.")

disable_btag_service()
disable_bthserv_service()
disable_browser_service()
disable_mapsbroker_service()
disable_lfsvc_service()
disable_iisadmin_service()
disable_irmon_service()
disable_sharedaccess_service()
disable_lxssmanager_service()
disable_ftpsvc_service()
disable_msiscsi_service()
disable_sshd_service()
disable_pnrpsvc_service()
disable_p2psvc_service()
disable_p2pimsvc_service()
disable_pnrpautoreg_service()
disable_spooler_service()
disable_wercplsupport_service()
disable_rasauto_service()
disable_sessionenv_service()
disable_termservice_service()
disable_umrdpservice_service()
disable_rpclocator_service()
disable_remoteregistry_service()
disable_remoteaccess_service()
disable_lanmanserver_service()
disable_simptcp_service()
disable_snmp_service()
disable_sacsvr_service()
disable_ssdpsrv_service()
disable_upnphost_service()
disable_wmsvc_service()
disable_wersvc_service()
disable_wecsvc_service()
disable_wmpnetworksvc_service()
disable_icssvc_service()
disable_wpn_service()
disable_push_to_install_service()
disable_winrm_service()
disable_w3svc_service()
disable_xboxgipsvc_service()
disable_xblauthmanager_service()
disable_xblgamesave_service()
disable_xboxnetapisvc_service()