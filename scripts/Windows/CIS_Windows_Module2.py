import subprocess
import os

def access_cred_manager():
    """
    This function ensures that 'Access Credential Manager as a trusted caller' is set to 'No One' 2.2.1 (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeTrustedCredManAccessPrivilege' in data[i]:
                data[i] = 'SeTrustedCredManAccessPrivilege = No One\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Access Credential Manager script executed successfully!")
    except Exception as e:
        print("Access Credential Manager script failed to execute. Error: ", e)

def access_computer_network():
    """
    This function ensures that 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users' 2.2.2 (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeNetworkLogonRight' in data[i]:
                data[i] = 'SeNetworkLogonRight = Administrators, Remote Desktop Users\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Access Computer Network script executed successfully!")
    except Exception as e:
        print("Access Computer Network script failed to execute. Error: ", e)

def act_as_part_of_os():
    """
    This function ensures that 'Act as part of the operating system' is set to 'No One' 2.2.3 (L1) Ensure 'Act as part of the operating system' is set to 'No One' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeTcbPrivilege' in data[i]:
                data[i] = 'SeTcbPrivilege = No One\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Act as part of the operating system script executed successfully!")
    except Exception as e:
        print("Act as part of the operating system script failed to execute. Error: ", e)

def adjust_memory_quotas():
    """
    This function ensures that 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE' 2.2.4 (L1) Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeIncreaseQuotaPrivilege' in data[i]:
                data[i] = 'SeIncreaseQuotaPrivilege = Administrators, LOCAL SERVICE, NETWORK SERVICE\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Adjust memory quotas for a process script executed successfully!")
    except Exception as e:
        print("Adjust memory quotas for a process script failed to execute. Error: ", e)

def allow_log_on_locally():
    """
    This function ensures that 'Allow log on locally' is set to 'Administrators, Users' 2.2.5 (L1) Ensure 'Allow log on locally' is set to 'Administrators, Users' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeInteractiveLogonRight' in data[i]:
                data[i] = 'SeInteractiveLogonRight = Administrators, Users\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Allow log on locally script executed successfully!")
    except Exception as e:
        print("Allow log on locally script failed to execute. Error: ", e)

def allow_log_on_through_remote_desktop_services():
    """
    This function ensures that 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' 2.2.6 (L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeRemoteInteractiveLogonRight' in data[i]:
                data[i] = 'SeRemoteInteractiveLogonRight = Administrators, Remote Desktop Users\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Allow log on through Remote Desktop Services script executed successfully!")
    except Exception as e:
        print("Allow log on through Remote Desktop Services script failed to execute. Error: ", e)

def set_backup_privilege():
    """
    This function ensures that 'Back up files and directories' is set to 'Administrators' 2.2.7 (L1) Ensure 'Back up files and directories' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeBackupPrivilege' in data[i]:
                data[i] = 'SeBackupPrivilege = Administrators\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Back up files and directories script executed successfully!")
    except Exception as e:
        print("Back up files and directories script failed to execute. Error: ", e)

def set_system_time_privilege():
    """
    This function ensures that 'Change the system time' is set to 'Administrators, LOCAL SERVICE' 2.2.8 (L1) Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeSystemtimePrivilege' in data[i]:
                data[i] = 'SeSystemtimePrivilege = Administrators, LOCAL SERVICE\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Change the system time script executed successfully!")
    except Exception as e:
        print("Change the system time script failed to execute. Error: ", e)

def set_time_zone_privilege():
    """
    This function ensures that 'Change the time zone' is set to 'Administrators, LOCAL SERVICE, Users' 2.2.9 (L1) Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE, Users' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeTimeZonePrivilege' in data[i]:
                data[i] = 'SeTimeZonePrivilege = Administrators, LOCAL SERVICE, Users\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Change the time zone script executed successfully!")
    except Exception as e:
        print("Change the time zone script failed to execute. Error: ", e)

def set_pagefile_privilege():
    """
    This function ensures that 'Create a pagefile' is set to 'Administrators' 2.2.10 (L1) Ensure 'Create a pagefile' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeCreatePagefilePrivilege' in data[i]:
                data[i] = 'SeCreatePagefilePrivilege = Administrators\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Create a pagefile script executed successfully!")
    except Exception as e:
        print("Create a pagefile script failed to execute. Error: ", e)

def set_create_token_object_privilege():
    """
    This function ensures that 'Create a token object' is set to 'No One' 2.2.11 (L1) Ensure 'Create a token object' is set to 'No One' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeCreateTokenPrivilege' in data[i]:
                data[i] = 'SeCreateTokenPrivilege = No One\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Create a token object script executed successfully!")
    except Exception as e:
        print("Create a token object script failed to execute. Error: ", e)

def set_create_global_objects_privilege():
    """
    This function ensures that 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' 2.2.12 (L1) Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeCreateGlobalPrivilege' in data[i]:
                data[i] = 'SeCreateGlobalPrivilege = Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Create global objects script executed successfully!")
    except Exception as e:
        print("Create global objects script failed to execute. Error: ", e)

def set_create_permanent_shared_objects_privilege():
    """
    This function ensures that 'Create permanent shared objects' is set to 'No One' 2.2.13 (L1) Ensure 'Create permanent shared objects' is set to 'No One' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeCreatePermanentPrivilege' in data[i]:
                data[i] = 'SeCreatePermanentPrivilege = No One\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Create permanent shared objects script executed successfully!")
    except Exception as e:
        print("Create permanent shared objects script failed to execute. Error: ", e)
def set_create_symbolic_links_privilege():
    """
    This function ensures that 'Create symbolic links' is set to 'Administrators' 2.2.14 (L1) Configure 'Create symbolic links' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeCreateSymbolicLinkPrivilege' in data[i]:
                data[i] = 'SeCreateSymbolicLinkPrivilege = Administrators\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Create symbolic links script executed successfully!")
    except Exception as e:
        print("Create symbolic links script failed to execute. Error: ", e)

def set_debug_programs_privilege():
    """
    This function ensures that 'Debug programs' is set to 'Administrators' 2.2.15 (L1) Ensure 'Debug programs' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeDebugPrivilege' in data[i]:
                data[i] = 'SeDebugPrivilege = Administrators\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Debug programs script executed successfully!")
    except Exception as e:
        print("Debug programs script failed to execute. Error: ", e)

def deny_access_to_computer_from_network():
    """
    This function ensures that 'Deny access to this computer from the network' is set to include 'Guests, Local account' 2.2.16 (L1) Ensure 'Deny access to this computer from the network' to include 'Guests, Local account' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeDenyNetworkLogonRight' in data[i]:
                data[i] = 'SeDenyNetworkLogonRight = *S-1-5-32-546,*S-1-5-113\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Deny access to computer from network script executed successfully!")
    except Exception as e:
        print("Deny access to computer from network script failed to execute. Error: ", e)
def deny_log_on_as_batch_job():
    """
    This function ensures that 'Deny log on as a batch job' is set to include 'Guests' 2.2.17 (L1) Ensure 'Deny log on as a batch job' to include 'Guests' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeDenyBatchLogonRight' in data[i]:
                data[i] = 'SeDenyBatchLogonRight = *S-1-5-32-546\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Deny log on as a batch job script executed successfully!")
    except Exception as e:
        print("Deny log on as a batch job script failed to execute. Error: ", e)

def deny_log_on_as_service():
    """
    This function ensures that 'Deny log on as a service' is set to include 'Guests' 2.2.18 (L1) Ensure 'Deny log on as a service' to include 'Guests' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeDenyServiceLogonRight' in data[i]:
                data[i] = 'SeDenyServiceLogonRight = *S-1-5-32-546\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Deny log on as a service script executed successfully!")
    except Exception as e:
        print("Deny log on as a service script failed to execute. Error: ", e)

def deny_log_on_locally():
    """
    This function ensures that 'Deny log on locally' is set to include 'Guests' 2.2.19 (L1) Ensure 'Deny log on locally' to include 'Guests' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeDenyInteractiveLogonRight' in data[i]:
                data[i] = 'SeDenyInteractiveLogonRight = *S-1-5-32-546\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Deny log on locally script executed successfully!")
    except Exception as e:
        print("Deny log on locally script failed to execute. Error: ", e)

def deny_log_on_through_remote_desktop_services():
    """
    This function ensures that 'Deny log on through Remote Desktop Services' is set to include 'Guests, Local account' 2.2.20 (L1) Ensure 'Deny log on through Remote Desktop Services' to include 'Guests, Local account' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeDenyRemoteInteractiveLogonRight' in data[i]:
                data[i] = 'SeDenyRemoteInteractiveLogonRight = *S-1-5-32-546,*S-1-5-113\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Deny log on through Remote Desktop Services script executed successfully!")
    except Exception as e:
        print("Deny log on through Remote Desktop Services script failed to execute. Error: ", e)

def disable_trusted_for_delegation():
    """
    This function ensures that 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' 2.2.21 (L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeTrustedCredManAccessPrivilege' in data[i]:
                data[i] = 'SeTrustedCredManAccessPrivilege = *S-1-0-0\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Disable trusted for delegation script executed successfully!")
    except Exception as e:
        print("Disable trusted for delegation script failed to execute. Error: ", e)

def set_force_shutdown_from_remote_system():
    """
    This function ensures that 'Force shutdown from a remote system' is set to 'Administrators' 2.2.22 (L1) Ensure 'Force shutdown from a remote system' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeRemoteShutdownPrivilege' in data[i]:
                data[i] = 'SeRemoteShutdownPrivilege = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Force shutdown from a remote system script executed successfully!")
    except Exception as e:
        print("Force shutdown from a remote system script failed to execute. Error: ", e)

def set_generate_security_audits():
    """
    This function ensures that 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE' 2.2.23 (L1) Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeAuditPrivilege' in data[i]:
                data[i] = 'SeAuditPrivilege = *S-1-5-19,*S-1-5-20\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Generate security audits script executed successfully!")
    except Exception as e:
        print("Generate security audits script failed to execute. Error: ", e)

def set_impersonate_client_privilege():
    """
    This function ensures that 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' 2.2.24 (L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeImpersonatePrivilege' in data[i]:
                data[i] = 'SeImpersonatePrivilege = *S-1-5-32-544,*S-1-5-19,*S-1-5-20,*S-1-5-6\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Impersonate a client after authentication script executed successfully!")
    except Exception as e:
        print("Impersonate a client after authentication script failed to execute. Error: ", e)

def set_increase_scheduling_priority_privilege():
    """
    This function ensures that 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group' 2.2.25 (L1) Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeIncreaseBasePriorityPrivilege' in data[i]:
                data[i] = 'SeIncreaseBasePriorityPrivilege = *S-1-5-32-544,*S-1-5-90-0\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Increase scheduling priority script executed successfully!")
    except Exception as e:
        print("Increase scheduling priority script failed to execute. Error: ", e)

def set_load_and_unload_device_drivers_privilege():
    """
    This function ensures that 'Load and unload device drivers' is set to 'Administrators' 2.2.26 (L1) Ensure 'Load and unload device drivers' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeLoadDriverPrivilege' in data[i]:
                data[i] = 'SeLoadDriverPrivilege = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Load and unload device drivers script executed successfully!")
    except Exception as e:
        print("Load and unload device drivers script failed to execute. Error: ", e)

def set_lock_pages_in_memory_privilege():
    """
    This function ensures that 'Lock pages in memory' is set to 'No One' 2.2.27 (L1) Ensure 'Lock pages in memory' is set to 'No One' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeLockMemoryPrivilege' in data[i]:
                data[i] = 'SeLockMemoryPrivilege = *S-1-0-0\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Lock pages in memory script executed successfully!")
    except Exception as e:
        print("Lock pages in memory script failed to execute. Error: ", e)

def set_log_on_as_batch_job_privilege():
    """
    This function ensures that 'Log on as a batch job' is set to 'Administrators' 2.2.28 (L2) Ensure 'Log on as a batch job' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeBatchLogonRight' in data[i]:
                data[i] = 'SeBatchLogonRight = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Log on as a batch job script executed successfully!")
    except Exception as e:
        print("Log on as a batch job script failed to execute. Error: ", e)

def set_log_on_as_service_privilege():
    """
    This function ensures that 'Log on as a service' is set to 'NT SERVICE\\ALL SERVICES' 2.2.29 (L2) Configure 'Log on as a service' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeServiceLogonRight' in data[i]:
                data[i] = 'SeServiceLogonRight = *S-1-5-80-0\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Log on as a service script executed successfully!")
    except Exception as e:
        print("Log on as a service script failed to execute. Error: ", e)

def set_manage_auditing_and_security_log_privilege():
    """
    This function ensures that 'Manage auditing and security log' is set to 'Administrators' 2.2.30 (L1) Ensure 'Manage auditing and security log' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeSecurityPrivilege' in data[i]:
                data[i] = 'SeSecurityPrivilege = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Manage auditing and security log script executed successfully!")
    except Exception as e:
        print("Manage auditing and security log script failed to execute. Error: ", e)

def set_modify_object_label_privilege():
    """
    This function ensures that 'Modify an object label' is set to 'No One' 2.2.31 (L1) Ensure 'Modify an object label' is set to 'No One' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeRelabelPrivilege' in data[i]:
                data[i] = 'SeRelabelPrivilege = *S-1-0-0\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Modify an object label script executed successfully!")
    except Exception as e:
        print("Modify an object label script failed to execute. Error: ", e)

def set_modify_firmware_environment_values_privilege():
    """
    This function ensures that 'Modify firmware environment values' is set to 'Administrators' 2.2.32 (L1) Ensure 'Modify firmware environment values' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeSystemEnvironmentPrivilege' in data[i]:
                data[i] = 'SeSystemEnvironmentPrivilege = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Modify firmware environment values script executed successfully!")
    except Exception as e:
        print("Modify firmware environment values script failed to execute. Error: ", e)

def set_perform_volume_maintenance_tasks_privilege():
    """
    This function ensures that 'Perform volume maintenance tasks' is set to 'Administrators' 2.2.33 (L1) Ensure 'Perform volume maintenance tasks' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeManageVolumePrivilege' in data[i]:
                data[i] = 'SeManageVolumePrivilege = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Perform volume maintenance tasks script executed successfully!")
    except Exception as e:
        print("Perform volume maintenance tasks script failed to execute. Error: ", e)

def set_profile_single_process_privilege():
    """
    This function ensures that 'Profile single process' is set to 'Administrators' 2.2.34 (L1) Ensure 'Profile single process' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeProfileSingleProcessPrivilege' in data[i]:
                data[i] = 'SeProfileSingleProcessPrivilege = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Profile single process script executed successfully!")
    except Exception as e:
        print("Profile single process script failed to execute. Error: ", e)

def set_profile_system_performance_privilege():
    """
    This function ensures that 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost' 2.2.35 (L1) Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeSystemProfilePrivilege' in data[i]:
                data[i] = 'SeSystemProfilePrivilege = *S-1-5-32-544,*S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Profile system performance script executed successfully!")
    except Exception as e:
        print("Profile system performance script failed to execute. Error: ", e)

def set_replace_process_level_token_privilege():
    """
    This function ensures that 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE' 2.2.36 (L1) Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeAssignPrimaryTokenPrivilege' in data[i]:
                data[i] = 'SeAssignPrimaryTokenPrivilege = *S-1-5-19,*S-1-5-20\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Replace a process level token script executed successfully!")
    except Exception as e:
        print("Replace a process level token script failed to execute. Error: ", e)

def set_restore_files_and_directories_privilege():
    """
    This function ensures that 'Restore files and directories' is set to 'Administrators' 2.2.37 (L1) Ensure 'Restore files and directories' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeRestorePrivilege' in data[i]:
                data[i] = 'SeRestorePrivilege = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Restore files and directories script executed successfully!")
    except Exception as e:
        print("Restore files and directories script failed to execute. Error: ", e)

def set_shut_down_the_system_privilege():
    """
    This function ensures that 'Shut down the system' is set to 'Administrators, Users' 2.2.38 (L1) Ensure 'Shut down the system' is set to 'Administrators, Users' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeShutdownPrivilege' in data[i]:
                data[i] = 'SeShutdownPrivilege = *S-1-5-32-544,*S-1-5-32-545\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Shut down the system script executed successfully!")
    except Exception as e:
        print("Shut down the system script failed to execute. Error: ", e)

def set_take_ownership_privilege():
    """
    This function ensures that 'Take ownership of files or other objects' is set to 'Administrators' 2.2.39 (L1) Ensure 'Take ownership of files or other objects' is set to 'Administrators' (Automated)
    """
    try:
        command = 'secedit /export /cfg C:\\secpol.cfg'
        subprocess.call(command, shell=True)
        with open('C:\\secpol.cfg', 'r') as file:
            data = file.readlines()
        for i in range(len(data)):
            if 'SeTakeOwnershipPrivilege' in data[i]:
                data[i] = 'SeTakeOwnershipPrivilege = *S-1-5-32-544\n'
        with open('C:\\secpol.cfg', 'w') as file:
            file.writelines(data)
        command = 'secedit /configure /db C:\\Windows\\security\\local.sdb /cfg C:\\secpol.cfg /areas SECURITYPOLICY'
        subprocess.call(command, shell=True)
        os.remove('C:\\secpol.cfg')
        print("Take ownership of files or other objects script executed successfully!")
    except Exception as e:
        print("Take ownership of files or other objects script failed to execute. Error: ", e)

def set_block_accounts():
    """
    This function prevents users from adding new Microsoft accounts on this computer.
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" /v "NoConnectedUser" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Block accounts script executed successfully!")
    except Exception as e:
        print("Block accounts script failed to execute. Error: ", e)

def disable_guest_accounts():
    """
    This function disables the Guest account.
    """
    try:
        command = 'net user Guest /active:no'
        subprocess.call(command, shell=True)
        print("Disable guest accounts script executed successfully!")
    except Exception as e:
        print("Disable guest accounts script failed to execute. Error: ", e)

def limit_blank_passwords():
    """
    This function determines whether local accounts that are not password protected
    can be used to log on from locations other than the physical computer console. If you
    enable this policy setting, local accounts that have blank passwords will not be able to
    log on to the network from remote client computers. Such accounts will only be able to
    log on at the keyboard of the computer. This function enables it.
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "LimitBlankPasswordUse" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Limit blank passwords script executed successfully!")
    except Exception as e:
        print("Limit blank passwords script failed to execute. Error: ", e)
def rename_admin_account():
    """
    The built-in local administrator account is a well-known account name that attackers will
    target. It is recommended to choose another name for this account, and to avoid names
    that denote administrative or elevated access accounts. Be sure to also change the
    default description for the local administrator (through the Computer Management
    console).
    """
    try:
        command = 'net user Administrator /random'
        subprocess.call(command, shell=True)
        print("Rename admin account script executed successfully!")
    except Exception as e:
        print("Rename admin account script failed to execute. Error: ", e)

def rename_guest_account():
    """
    The built-in local guest account is another well-known name to attackers. It is
    recommended to rename this account to something that does not indicate its purpose.
    Even if you disable this account, which is recommended, ensure that you rename it for
    added security
    """
    try:
        command = 'net user Guest /random'
        subprocess.call(command, shell=True)
        print("Rename guest account script executed successfully!")
    except Exception as e:
        print("Rename guest account script failed to execute. Error: ", e)

def allow_format_except():
    """
    This policy setting determines who is allowed to format and eject removable NTFS
    media. You can use this policy setting to prevent unauthorized users from removing
    data on one computer to access it on another computer on which they have local
    administrator privileges.
    The recommended state for this setting is: Administrators and Interactive Users.
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\cdrom" /v "AutoRun" /t REG_DWORD /d "0" /f'
        subprocess.call(command, shell=True)
        print("Allow format except script executed successfully!")
    except Exception as e:
        print("Allow format except script failed to execute. Error: ", e)

def prevent_users_install_printers():
    """
    For a computer to print to a shared printer, the driver for that shared printer must be
installed on the local computer. This security setting determines who is allowed to install
a printer driver as part of connecting to a shared printer.
The recommended state for this setting is: Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Printers" /v "PreventUserInstallPrinter" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Prevent users install printers script executed successfully!")
    except Exception as e:
        print("Prevent users install printers script failed to execute. Error: ", e)

def encrypt_channel_data():
    """
    This policy setting determines whether all secure channel traffic that is initiated by the
domain member must be signed or encrypted.
The recommended state for this setting is: Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters" /v "RequireSignOrSeal" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Encrypt channel data script executed successfully!")
    except Exception as e:
        print("Encrypt channel data script failed to execute. Error: ", e)

def _2_3_6_2():
    """
    This policy setting determines whether all secure channel traffic that is initiated by the
domain member must be signed or encrypted.
The recommended state for this setting is: Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters" /v "RequireStrongKey" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Encrypt channel data script executed successfully!")
    except Exception as e:
        print("Encrypt channel data script failed to execute. Error: ", e)

    def disable_machine_account_password_changes():
        """
        This policy setting determines whether a domain member can periodically change its
computer account password. Computers that cannot automatically change their account
passwords are potentially vulnerable, because an attacker might be able to determine
the password for the system's domain account.
The recommended state for this setting is: Disabled.
        :return:
        """
        try:
            command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters" /v "DisablePasswordChange" /t REG_DWORD /d "1" /f'
            subprocess.call(command, shell=True)
            print("Disable machine account password changes script executed successfully!")
        except Exception as e:
            print("Disable machine account password changes script failed to execute. Error: ", e)

def max_mach_acc_pass_age():
    """
    This policy setting determines the maximum allowable age for a computer account password. By default, domain members automatically change their domain passwords
every 30 days. If you increase this interval significantly so that the computers no longer
change their passwords, an attacker would have more time to undertake a brute force
attack against one of the computer accounts.
The recommended state for this setting is: 30 or fewer days, but not 0.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters" /v "MaximumPasswordAge" /t REG_DWORD /d "30" /f'
        subprocess.call(command, shell=True)
        print("Max machine account password age script executed successfully!")
    except Exception as e:
        print("Max machine account password age script failed to execute. Error: ", e)

def req_strong_sess_key():
    """
    When this policy setting is enabled, a secure channel can only be established with
Domain Controllers that are capable of encrypting secure channel data with a strong
(128-bit) session key.
To enable this policy setting, all Domain Controllers in the domain must be able to
encrypt secure channel data with a strong key, which means all Domain Controllers
must be running Microsoft Windows 2000 or newer.
The recommended state for this setting is: Enabled
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters" /v "RequireStrongKey" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Require strong session key script executed successfully!")
    except Exception as e:
        print("Require strong session key script failed to execute. Error: ", e)

    def dont_req_CTRLALTDEL_dis():
        """
        This policy setting determines whether users must press CTRL+ALT+DEL before they log on.
The recommended state for this setting is: Disabled.
        """
        try:
            command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" /v "DisableCAD" /t REG_DWORD /d "0" /f'
            subprocess.call(command, shell=True)
            print("Don't require CTRL+ALT+DEL to logon script executed successfully!")
        except Exception as e:
            print("Don't require CTRL+ALT+DEL to logon script failed to execute. Error: ", e)

def dont_display_last_signedin():
    """
    This policy setting determines whether the account name of the last user to log on to the client computers in your organization will be displayed in each computer's respective
Windows logon screen. Enable this policy setting to prevent intruders from collecting
account names visually from the screens of desktop or laptop computers in your
organization.
The recommended state for this setting is: Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" /v "DontDisplayLastUserName" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Don't display last signed in script executed successfully!")
    except Exception as e:
        print("Don't display last signed in script failed to execute. Error: ", e)

def machine_lockout_threshold():
    """
    This security setting determines the number of failed logon attempts that causes the
machine to be locked out.
Failed password attempts against workstations or member servers that have been
locked using either CTRL+ALT+DELETE or password protected screen savers counts
as failed logon attempts.
The machine lockout policy is enforced only on those machines that have BitLocker
enabled for protecting OS volumes. Please ensure that appropriate recovery password
backup policies are enabled.
The recommended state for this setting is: 10 or fewer invalid logon attempts, but
not 0.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\FVE" /v "LockoutBadRecoveryPasswordAttempts" /t REG_DWORD /d "10" /f'
        subprocess.call(command, shell=True)
        print("Machine lockout threshold script executed successfully!")
    except Exception as e:
        print("Machine lockout threshold script failed to execute. Error: ", e)
def mach_inac_limit():
    """
    TWindows notices inactivity of a logon session, and if the amount of inactive time
exceeds the inactivity limit, then the screen saver will run, locking the session.
The recommended state for this setting is: 900 or fewer second(s), but not 0.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Control Panel\\Desktop" /v "ScreenSaveTimeOut" /t REG_SZ /d "900" /f'
        subprocess.call(command, shell=True)
        print("Machine inactivity limit script executed successfully!")
    except Exception as e:
        print("Machine inactivity limit script failed to execute. Error: ", e)

def mess_text():
    """
    This policy setting specifies a text message that displays to users when they log on. Set
the following group policy to a value that is consistent with the security and operational
requirements of your organization.
The recommended state for this setting is: Not defined.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" /v "LegalNoticeText" /t REG_SZ /d "This computer system is the property of <Company Name>. It is for authorized use only. Unauthorized or improper use of this system may result in administrative disciplinary action and/or civil charges/criminal penalties." /f'
        subprocess.call(command, shell=True)
        print("Message text script executed successfully!")
    except Exception as e:
        print("Message text script failed to execute. Error: ", e)
def prev_logons_to_cache():
    """
    This policy setting determines whether a user can log on to a Windows domain using
cached account information. Logon information for domain accounts can be cached
locally to allow users to log on even if a Domain Controller cannot be contacted. This
policy setting determines the number of unique users for whom logon information is
cached locally. If this value is set to 0, the logon cache feature is disabled. An attacker
who is able to access the file system of the server could locate this cached information
and use a brute force attack to determine user passwords.
The recommended state for this setting is: 4 or fewer logon(s).
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" /v "CachedLogonsCount" /t REG_SZ /d "4" /f'
        subprocess.call(command, shell=True)
        print("Previous logons to cache script executed successfully!")
    except Exception as e:
        print("Previous logons to cache script failed to execute. Error: ", e)
def digital_sign_comm_always():
    """
    This policy setting determines whether packet signing is required by the SMB client
component. Recommended state is Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters" /v "RequireSecuritySignature" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Digital sign communications always script executed successfully!")
    except Exception as e:
        print("Digital sign communications always script failed to execute. Error: ", e)
def digital_sign_comm_if():
    """
    This policy setting determines whether the SMB client will attempt to negotiate SMB
packet signing.
Note: Enabling this policy setting on SMB clients on your network makes them fully
effective for packet signing with all clients and servers in your environment.
The recommended state for this setting is: Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters" /v "EnableSecuritySignature" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Digital sign communications if possible script executed successfully!")
    except Exception as e:
        print("Digital sign communications if possible script failed to execute. Error: ", e)
    def send_unencrypted_pass():
        """
        This policy setting determines whether the SMB redirector will send plaintext passwords
during authentication to third-party SMB servers that do not support password
encryption.
It is recommended that you disable this policy setting unless there is a strong business
case to enable it. If this policy setting is enabled, unencrypted passwords will be allowed
across the network.
The recommended state for this setting is: Disabled
        :return:
        """
        try:
            command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters" /v "EnablePlainTextPassword" /t REG_DWORD /d "0" /f'
            subprocess.call(command, shell=True)
            print("Send unencrypted password script executed successfully!")
        except Exception as e:
            print("Send unencrypted password script failed to execute. Error: ", e)
def idle_time_req():
            """
            This policy setting allows you to specify the amount of continuous idle time that must
pass in an SMB session before the session is suspended because of inactivity.
Administrators can use this policy setting to control when a computer suspends an
inactive SMB session. If client activity resumes, the session is automatically
reestablished.
The maximum value is 99999, which is over 69 days; in effect, this value disables the
setting.
The recommended state for this setting is: 15 or fewer minute(s).
            :return:
            """
            try:
                command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters" /v "KeepConn" /t REG_DWORD /d "15" /f'
                subprocess.call(command, shell=True)
                print("Idle time required script executed successfully!")
            except Exception as e:
                print("Idle time required script failed to execute. Error: ", e)
def disc_client_logon_expire():
                """
                This security setting determines whether to disconnect users who are connected to the
local computer outside their user account's valid logon hours. This setting affects the
Server Message Block (SMB) component. If you enable this policy setting you should
also enable Network security: Force logoff when logon hours expire (Rule 2.3.11.6).
If your organization configures logon hours for users, this policy setting is necessary to
ensure they are effective.
The recommended state for this setting is: Enabled
                :return:
                """
                try:
                    command = 'reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" /v "CachedLogonsCount" /t REG_SZ /d "4" /f'
                    subprocess.call(command, shell=True)
                    print("Disconnect client logon expire script executed successfully!")
                except Exception as e:
                    print("Disconnect client logon expire script failed to execute. Error: ", e)

def spn_validation_level():
        """
    This policy setting controls the level of validation a computer with shared folders or
printers (the server) performs on the service principal name (SPN) that is provided by
the client computer when it establishes a session using the server message block
(SMB) protocol.
The server message block (SMB) protocol provides the basis for file and print sharing
and other networking operations, such as remote Windows administration. The SMB
protocol supports validating the SMB server service principal name (SPN) within the
authentication blob provided by a SMB client to prevent a class of attacks against SMB
servers referred to as SMB relay attacks. This setting will affect both SMB1 and SMB2.
The recommended state for this setting is: Accept if provided by client. Configuring
this setting to Required from client also conforms to the benchmark
"""
        try:
            command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanServer\\Parameters" /v "SMBServerNameHardeningLevel" /t REG_DWORD /d "1" /f'
            subprocess.call(command, shell=True)
            print("SPN validation level script executed successfully!")
        except Exception as e:
            print("SPN validation level script failed to execute. Error: ", e)

def disable_SID_trans():
    """
    This policy setting determines whether an anonymous user can request security
identifier (SID) attributes for another user, or use a SID to obtain its corresponding user
name.
The recommended state for this setting is: Disabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Disable SID translation script executed successfully!")
    except Exception as e:
        print("Disable SID translation script failed to execute. Error: ", e)
def no_anon_enum_sam():
    """
    This policy setting controls the ability of anonymous users to enumerate the accounts in
the Security Accounts Manager (SAM). If you enable this policy setting, users with
anonymous connections will not be able to enumerate domain account user names on
the systems in your environment. This policy setting also allows additional restrictions
on anonymous connections.
The recommended state for this setting is: Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymous" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("No anonymous enumeration of SAM accounts script executed successfully!")
    except Exception as e:
        print("No anonymous enumeration of SAM accounts script failed to execute. Error: ", e)
def no_anon_enum_share():
    """
    This policy setting controls the ability of anonymous users to enumerate SAM accounts
as well as shares. If you enable this policy setting, anonymous users will not be able to
enumerate domain account user names and network share names on the systems in
your environment.
The recommended state for this setting is: Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymous" /t REG_DWORD /d "2" /f'
        subprocess.call(command, shell=True)
        print("No anonymous enumeration of SAM and shares script executed successfully!")
    except Exception as e:
        print("No anonymous enumeration of SAM and shares script failed to execute. Error: ", e)
def no_storage_pass_for_net_auth():
    """
    This policy setting determines whether Credential Manager (formerly called Stored User
Names and Passwords) saves passwords or credentials for later use when it gains
domain authentication.
The recommended state for this setting is: Enabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "disabledomaincreds" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("No storage of passwords and credentials for network authentication script executed successfully!")
    except Exception as e:
        print("No storage of passwords and credentials for network authentication script failed to execute. Error: ", e)
def let_perm_apply_anon():
    """
    This policy setting determines what additional permissions are assigned for anonymous
connections to the computer.
The recommended state for this setting is: Disabled.
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "EveryoneIncludesAnonymous" /t REG_DWORD /d "0" /f'
        subprocess.call(command, shell=True)
        print("Let permissions apply to anonymous users script executed successfully!")
    except Exception as e:
        print("Let permissions apply to anonymous users script failed to execute. Error: ", e)
def restrict_anon_pipe():
    """
    This policy setting determines which communication sessions, or pipes, will have
attributes and permissions that allow anonymous access.
The recommended state for this setting is: <blank> (i.e. None)
    :return:
    """
    try:
        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanManServer\\Parameters" /v "RestrictNullSessAccess" /t REG_DWORD /d "1" /f'
        subprocess.call(command, shell=True)
        print("Restrict anonymous pipes script executed successfully!")
    except Exception as e:
        print("Restrict anonymous pipes script failed to execute. Error: ", e)
def remote_accessible_reg_path():
        """
        This policy setting determines which registry paths will be accessible over the network,
regardless of the users or groups listed in the access control list (ACL) of the winreg
registry key.
The recommended state for this setting is: System\CurrentControlSet\Control\ProductOptions
System\CurrentControlSet\Control\Server Applications
Software\Microsoft\Windows NT\CurrentVersion
        """
        try:
            command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d "1" /f'
            subprocess.call(command, shell=True)
            print("Remote accessible registry path script executed successfully!")
        except Exception as e:
            print("Remote accessible registry path script failed to execute. Error: ", e)
def rem_acc_reg_path_conf():
            """
            This policy setting determines which registry paths and sub-paths will be accessible
over the network, regardless of the users or groups listed in the access control list
(ACL) of the winreg registry key.
Note: In Windows XP this setting is called "Network access: Remotely accessible
registry paths," the setting with that same name in Windows Vista, Windows Server
2008 (non-R2), and Windows Server 2003 does not exist in Windows XP.
Note #2: When you configure this setting you specify a list of one or more objects. The
delimiter used when entering the list is a line feed or carriage return, that is, type the
first object on the list, press the Enter button, type the next object, press Enter again,
etc. The setting value is stored as a comma-delimited list in group policy security
templates. It is also rendered as a comma-delimited list in Group Policy Editor's display
pane and the Resultant Set of Policy console. It is recorded in the registry as a line-feed
delimited list in a REG_MULTI_SZ value.
The recommended state for this setting is:
System\CurrentControlSet\Control\Print\Printers
System\CurrentControlSet\Services\Eventlog
Software\Microsoft\OLAP Server
Software\Microsoft\Windows NT\CurrentVersion\Print
Software\Microsoft\Windows NT\CurrentVersion\Windows
System\CurrentControlSet\Control\ContentIndex
System\CurrentControlSet\Control\Terminal Server
System\CurrentControlSet\Control\Terminal Server\UserConfig
System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration
Software\Microsoft\Windows NT\CurrentVersion\Perflib
System\CurrentControlSet\Services\SysmonLog
            """
            try:
                command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d "1" /f'
                subprocess.call(command, shell=True)
                print("Remote accessible registry path configuration script executed successfully!")
            except Exception as e:
                print("Remote accessible registry path configuration script failed to execute. Error: ", e)
def restrict_anon_pipe():
                """
                When enabled, this policy setting restricts anonymous access to only those shares and
pipes that are named in the Network access: Named pipes that can be accessed
anonymously and Network access: Shares that can be accessed anonymously
settings. This policy setting controls null session access to shares on your computers by
adding RestrictNullSessAccess with the value 1 in the
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters
registry key. This registry value toggles null session shares on or off to control whether
the server service restricts unauthenticated clients' access to named resources.
The recommended state for this setting is: Enabled.
                """
                try:
                    command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d "1" /f'
                    subprocess.call(command, shell=True)
                    print("Restrict anonymous pipes script executed successfully!")
                except Exception as e:
                    print("Restrict anonymous pipes script failed to execute. Error: ", e)
def restrict_clinet_allowed_call_sam():
                    """
                    This policy setting allows you to restrict remote RPC connections to SAM.
The recommended state for this setting is: Administrators: Remote Access: Allow.
                    """
                    try:
                        command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d "1" /f'
                        subprocess.call(command, shell=True)
                        print("Restrict client allowed to call SAM script executed successfully!")
                    except Exception as e:
                        print("Restrict client allowed to call SAM script failed to execute. Error: ", e)
def share_acc_anon():
                        """
                        This policy setting determines which network shares can be accessed by anonymous
users. The default configuration for this policy setting has little effect because all users
have to be authenticated before they can access shared resources on the server.
The recommended state for this setting is: <blank> (i.e. None).
                        """
                        try:
                            command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d "1" /f'
                            subprocess.call(command, shell=True)
                            print("Share access for anonymous users script executed successfully!")
                        except Exception as e:
                            print("Share access for anonymous users script failed to execute. Error: ", e)
                def share_secure_level():
                            """
                            This policy setting determines how network logons that use local accounts are
authenticated. The Classic option allows precise control over access to resources,
including the ability to assign different types of access to different users for the same
resource. The Guest only option allows you to treat all users equally. In this context, all
users authenticate as Guest only to receive the same access level to a given resource.
The recommended state for this setting is: Classic - local users authenticate as
themselves.
                            """
                            try:
                                command = 'reg add "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d "1" /f'
                                subprocess.call(command, shell=True)
                                print("Share secure level script executed successfully!")
                            except Exception as e:
                                print("Share secure level script failed to execute. Error: ", e)
