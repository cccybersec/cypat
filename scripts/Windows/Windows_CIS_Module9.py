import subprocess

def task_9_1_1():
    def check_firewall_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile" /v EnableFirewall'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x1" in result:
                print("The firewall is enabled.")
            else:
                print("The firewall is disabled. Applying the recommended setting...")
                set_firewall_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_firewall_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile" /v EnableFirewall /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The firewall setting has been updated to the recommended value.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_firewall_setting()


def task_9_1_2():
    def check_inbound_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile" /v DefaultInboundAction'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x1" in result:
                print("The inbound connections are blocked.")
            else:
                print("The inbound connections are not blocked. Applying the recommended setting...")
                set_inbound_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_inbound_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile" /v DefaultInboundAction /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The inbound setting has been updated to the recommended value.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_inbound_setting()

def task_9_1_3():
    def check_outbound_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile" /v DefaultOutboundAction'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x0" in result:  # 0x0 is hexadecimal for 0, which means allow.
                print("The outbound connections are allowed.")
            else:
                print("The outbound connections are not allowed. Applying the recommended setting...")
                set_outbound_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_outbound_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile" /v DefaultOutboundAction /t REG_DWORD /d 0 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The outbound setting has been updated to the recommended value.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_outbound_setting()

def task_9_1_4():
    def check_notification_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile" /v DisableNotifications'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x0" in result:  # 0x0 is hexadecimal for 0, which means No (notifications are enabled).
                print("Notifications are enabled.")
            else:
                print("Notifications are disabled. Applying the recommended setting...")
                set_notification_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_notification_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile" /v DisableNotifications /t REG_DWORD /d 0 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The notification setting has been updated to the recommended value.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_notification_setting()

def task_9_1_5():
    def check_log_file_path_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\Logging" /v LogFilePath'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "%SystemRoot%\\System32\\logfiles\\firewall\\domainfw.log" in result:
                print("The log file path is set to the recommended value.")
            else:
                print("The log file path is not set to the recommended value. Applying the recommended setting...")
                set_log_file_path_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_log_file_path_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\Logging" /v LogFilePath /t REG_EXPAND_SZ /d "%SystemRoot%\\System32\\logfiles\\firewall\\domainfw.log" /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The log file path has been updated to the recommended value.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_log_file_path_setting()

def task_9_1_6():
    def check_log_file_size_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\Logging" /v LogFileSize'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Extracting the file size from the result string.
            file_size = int(result.split()[-1])
            if file_size >= 16384:
                print("The log file size is set to the recommended value or greater.")
            else:
                print("The log file size is not set to the recommended value. Applying the recommended setting...")
                set_log_file_size_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_log_file_size_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\Logging" /v LogFileSize /t REG_DWORD /d 16384 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The log file size has been updated to the recommended value.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_log_file_size_setting()

def task_9_1_7():
    def check_log_dropped_packets_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\Logging" /v LogDroppedPackets'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x1" in result:  # 0x1 is hexadecimal for 1, which means Yes (logging is enabled).
                print("Logging of dropped packets is enabled.")
            else:
                print("Logging of dropped packets is not enabled. Applying the recommended setting...")
                set_log_dropped_packets_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_log_dropped_packets_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\Logging" /v LogDroppedPackets /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("Logging of dropped packets has been enabled.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_log_dropped_packets_setting()

def task_9_1_8():
    def check_log_successful_connections_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\Logging" /v LogSuccessfulConnections'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x1" in result:  # 0x1 is hexadecimal for 1, which means Yes (logging is enabled).
                print("Logging of successful connections is enabled.")
            else:
                print("Logging of successful connections is not enabled. Applying the recommended setting...")
                set_log_successful_connections_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_log_successful_connections_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\Logging" /v LogSuccessfulConnections /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("Logging of successful connections has been enabled.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_log_successful_connections_setting()

def task_9_2_1():
    def check_private_profile_firewall_setting():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile" /v EnableFirewall'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x1" in result:  # 0x1 is hexadecimal for 1, which means On (firewall is enabled).
                print("The firewall for Private Profile is enabled.")
            else:
                print("The firewall for Private Profile is not enabled. Applying the recommended setting...")
                set_private_profile_firewall_setting()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_private_profile_firewall_setting():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile" /v EnableFirewall /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The firewall for Private Profile has been enabled.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_private_profile_firewall_setting()

def task_9_2_2():
    def check_private_profile_default_inbound_action():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile" /v DefaultInboundAction'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x1" in result:  # 0x1 is hexadecimal for 1, which means Block (block all inbound connections).
                print("The default inbound action for Private Profile is set to Block.")
            else:
                print("The default inbound action for Private Profile is not set to Block. Applying the recommended setting...")
                set_private_profile_default_inbound_action()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_private_profile_default_inbound_action():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile" /v DefaultInboundAction /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The default inbound action for Private Profile has been set to Block.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_private_profile_default_inbound_action()

def task_9_2_3():
    def check_private_profile_default_outbound_action():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile" /v DefaultOutboundAction'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x0" in result:  # 0x0 is hexadecimal for 0, which means Allow (allow all outbound connections).
                print("The default outbound action for Private Profile is set to Allow.")
            else:
                print("The default outbound action for Private Profile is not set to Allow. Applying the recommended setting...")
                set_private_profile_default_outbound_action()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_private_profile_default_outbound_action():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile" /v DefaultOutboundAction /t REG_DWORD /d 0 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The default outbound action for Private Profile has been set to Allow.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_private_profile_default_outbound_action()

def task_9_2_4():
    def check_private_profile_disable_notifications():
        command = 'reg query "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile" /v DisableNotifications'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "0x0" in result:  # 0x0 is hexadecimal for 0, which corresponds to No (Notifications are enabled).
                print("The notification setting for Private Profile is set to No.")
            else:
                print("The notification setting for Private Profile is not set to No. Applying the recommended setting...")
                set_private_profile_disable_notifications()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_private_profile_disable_notifications():
        command = 'reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PrivateProfile" /v DisableNotifications /t REG_DWORD /d 0 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The notification setting for Private Profile has been set to No.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_private_profile_disable_notifications()

def task_9_2_5():
    def check_private_profile_log_file_path():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" /v LogFilePath'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if r"%SystemRoot%\System32\logfiles\firewall\privatefw.log" in result:
                print("The log file path for Private Profile is set correctly.")
            else:
                print("The log file path for Private Profile is not set correctly. Applying the recommended setting...")
                set_private_profile_log_file_path()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_private_profile_log_file_path():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" /v LogFilePath /t REG_EXPAND_SZ /d "%SystemRoot%\System32\logfiles\firewall\privatefw.log" /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The log file path for Private Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_private_profile_log_file_path()

def task_9_2_6():
    def check_private_profile_log_file_size():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" /v LogFileSize'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            file_size = int(result.split()[-1], 16)
            if file_size >= 16384:
                print("The log file size for Private Profile is set correctly.")
            else:
                print("The log file size for Private Profile is not set correctly. Applying the recommended setting...")
                set_private_profile_log_file_size()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_private_profile_log_file_size():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" /v LogFileSize /t REG_DWORD /d 16384 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The log file size for Private Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_private_profile_log_file_size()

def task_9_2_7():
    def check_private_profile_log_dropped_packets():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" /v LogDroppedPackets'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            log_dropped_packets_value = int(result.split()[-1], 16)
            if log_dropped_packets_value == 1:
                print("Logging of dropped packets for Private Profile is set correctly.")
            else:
                print("Logging of dropped packets for Private Profile is not set correctly. Applying the recommended setting...")
                set_private_profile_log_dropped_packets()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_private_profile_log_dropped_packets():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" /v LogDroppedPackets /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("Logging of dropped packets for Private Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_private_profile_log_dropped_packets()

def task_9_2_8():
    def check_private_profile_log_successful_connections():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" /v LogSuccessfulConnections'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            log_successful_connections_value = int(result.split()[-1], 16)
            if log_successful_connections_value == 1:
                print("Logging of successful connections for Private Profile is set correctly.")
            else:
                print("Logging of successful connections for Private Profile is not set correctly. Applying the recommended setting...")
                set_private_profile_log_successful_connections()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_private_profile_log_successful_connections():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" /v LogSuccessfulConnections /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("Logging of successful connections for Private Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_private_profile_log_successful_connections()

def task_9_3_1():
    def check_public_profile_firewall_state():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v EnableFirewall'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            enable_firewall_value = int(result.split()[-1], 16)
            if enable_firewall_value == 1:
                print("The firewall state for Public Profile is set correctly.")
            else:
                print("The firewall state for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_firewall_state()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_firewall_state():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v EnableFirewall /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The firewall state for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_firewall_state()

def task_9_3_2():
    def check_public_profile_inbound_connections():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v DefaultInboundAction'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            default_inbound_action_value = int(result.split()[-1], 16)
            if default_inbound_action_value == 1:
                print("The Inbound connections setting for Public Profile is set correctly.")
            else:
                print("The Inbound connections setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_inbound_connections()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_inbound_connections():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v DefaultInboundAction /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The Inbound connections setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_inbound_connections()

def task_9_3_3():
    def check_public_profile_outbound_connections():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v DefaultOutboundAction'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            default_outbound_action_value = int(result.split()[-1], 16)
            if default_outbound_action_value == 0:
                print("The Outbound connections setting for Public Profile is set correctly.")
            else:
                print("The Outbound connections setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_outbound_connections()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_outbound_connections():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v DefaultOutboundAction /t REG_DWORD /d 0 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The Outbound connections setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_outbound_connections()

def task_9_3_4():
    def check_public_profile_notifications():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v DisableNotifications'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            disable_notifications_value = int(result.split()[-1], 16)
            if disable_notifications_value == 1:
                print("The Display a notification setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_notifications()
            else:
                print("The Display a notification setting for Public Profile is set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_notifications():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v DisableNotifications /t REG_DWORD /d 0 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The Display a notification setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_notifications()

def task_9_3_5():
    def check_public_profile_local_policy_merge():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v AllowLocalPolicyMerge'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            allow_local_policy_merge_value = int(result.split()[-1], 16)
            if allow_local_policy_merge_value == 1:
                print("The Apply local firewall rules setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_local_policy_merge()
            else:
                print("The Apply local firewall rules setting for Public Profile is set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_local_policy_merge():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v AllowLocalPolicyMerge /t REG_DWORD /d 0 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The Apply local firewall rules setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_local_policy_merge()

def task_9_3_6():
    def check_public_profile_local_ipsec_policy_merge():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v AllowLocalIPsecPolicyMerge'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            # Convert the hexadecimal result to integer
            allow_local_ipsec_policy_merge_value = int(result.split()[-1], 16)
            if allow_local_ipsec_policy_merge_value == 1:
                print("The Apply local connection security rules setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_local_ipsec_policy_merge()
            else:
                print("The Apply local connection security rules setting for Public Profile is set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_local_ipsec_policy_merge():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v AllowLocalIPsecPolicyMerge /t REG_DWORD /d 0 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The Apply local connection security rules setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_local_ipsec_policy_merge()

def task_9_3_7():
    def check_public_profile_log_file_path():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" /v LogFilePath'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            log_file_path_value = result.split()[-1]
            if log_file_path_value != r"%SystemRoot%\System32\logfiles\firewall\publicfw.log":
                print("The log file path setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_log_file_path()
            else:
                print("The log file path setting for Public Profile is set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_log_file_path():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" /v LogFilePath /t REG_EXPAND_SZ /d %SystemRoot%\System32\logfiles\firewall\publicfw.log /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The log file path setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_log_file_path()

def task_9_3_8():
    def check_public_profile_log_file_size():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" /v LogFileSize'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            log_file_size_value = int(result.split()[-1])
            if log_file_size_value < 16384:
                print("The log file size setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_log_file_size()
            else:
                print("The log file size setting for Public Profile is set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_log_file_size():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" /v LogFileSize /t REG_DWORD /d 16384 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The log file size setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_log_file_size()

def task_9_3_9():
    def check_public_profile_log_dropped_packets():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" /v LogDroppedPackets'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            log_dropped_packets_value = int(result.split()[-1])
            if log_dropped_packets_value == 0:
                print("The Log Dropped Packets setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_log_dropped_packets()
            else:
                print("The Log Dropped Packets setting for Public Profile is set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_log_dropped_packets():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" /v LogDroppedPackets /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The Log Dropped Packets setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_public_profile_log_dropped_packets()

import subprocess

def task_9_3_10():
    def check_public_profile_log_successful_connections():
        command = r'reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" /v LogSuccessfulConnections'
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            log_successful_connections_value = int(result.split()[-1])
            if log_successful_connections_value == 0:
                print("The Log Successful Connections setting for Public Profile is not set correctly. Applying the recommended setting...")
                set_public_profile_log_successful_connections()
            else:
                print("The Log Successful Connections setting for Public Profile is set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_public_profile_log_successful_connections():
        command = r'reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" /v LogSuccessfulConnections /t REG_DWORD /d 1 /f'
        try:
            subprocess.run(command, shell=True, text=True, check=True)
            print("The Log Successful Connections setting for Public Profile has been set correctly.")
        except Exception as e:
            print(f"An error occurred: {e}")
    check_public_profile_log_successful_connections()
