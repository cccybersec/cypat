import subprocess
import os

def task_17_1_1():
    def check_credential_validation():
        command = "auditpol /get /subcategory:\"Credential Validation\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The Credential Validation setting is set correctly.")
            else:
                print("The Credential Validation setting is not set correctly. Applying the recommended setting...")
                set_credential_validation()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_credential_validation():
        command = "auditpol /set /subcategory:\"Credential Validation\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The Credential Validation setting has been set to Success and Failure.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_credential_validation()

def task_17_2_1():
    def check_application_group_management():
        command = "auditpol /get /subcategory:\"Application Group Management\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The Application Group Management setting is set correctly.")
            else:
                print("The Application Group Management setting is not set correctly. Applying the recommended setting...")
                set_application_group_management()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_application_group_management():
        command = "auditpol /set /subcategory:\"Application Group Management\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The Application Group Management setting has been set to Success and Failure.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_application_group_management()

def task_17_2_2():
    def check_security_group_management():
        command = "auditpol /get /subcategory:\"Security Group Management\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The Security Group Management setting is set correctly.")
            else:
                print("The Security Group Management setting is not set correctly. Applying the recommended setting...")
                set_security_group_management()
        except Exception as e:
            print(f"An error occurred: {e}")

    def set_security_group_management():
        command = "auditpol /set /subcategory:\"Security Group Management\" /success:enable"
        try:
            os.system(command)
            print("The Security Group Management setting has been set to include Success.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_security_group_management()

def task_17_2_3():
    def check_user_account_management():
        command = "auditpol /get /subcategory:\"User Account Management\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result and "Failure" in result:
                print("The User Account Management setting is set correctly.")
            else:
                print("The User Account Management setting is not set correctly. Applying the recommended setting...")
                remediate_user_account_management()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_user_account_management():
        command = "auditpol /set /subcategory:\"User Account Management\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The User Account Management setting has been set to include Success and Failure.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_user_account_management()


def task_17_3_1():
    def check_pnp_activity():
        command = "auditpol /get /subcategory:\"PNP Activity\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The PNP Activity setting is set correctly.")
            else:
                print("The PNP Activity setting is not set correctly. Applying the recommended setting...")
                remediate_pnp_activity()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_pnp_activity():
        command = "auditpol /set /subcategory:\"PNP Activity\" /success:enable"
        try:
            os.system(command)
            print("The PNP Activity setting has been set to include Success.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_pnp_activity()

def task_17_3_2():
    def check_process_creation():
        command = "auditpol /get /subcategory:\"Process Creation\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The Process Creation setting is set correctly.")
            else:
                print("The Process Creation setting is not set correctly. Applying the recommended setting...")
                remediate_process_creation()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_process_creation():
        command = "auditpol /set /subcategory:\"Process Creation\" /success:enable"
        try:
            os.system(command)
            print("The Process Creation setting has been set to include Success.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_process_creation()

def task_17_5_1():
    def check_account_lockout():
        command = "auditpol /get /subcategory:\"Account Lockout\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Failure" in result:
                print("The Account Lockout setting is set correctly.")
            else:
                print("The Account Lockout setting is not set correctly. Applying the recommended setting...")
                remediate_account_lockout()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_account_lockout():
        command = "auditpol /set /subcategory:\"Account Lockout\" /failure:enable"
        try:
            os.system(command)
            print("The Account Lockout setting has been set to include Failure.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_account_lockout()

def task_17_5_2():
    def check_group_membership():
        command = "auditpol /get /subcategory:\"Group Membership\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The Group Membership setting is set correctly.")
            else:
                print("The Group Membership setting is not set correctly. Applying the recommended setting...")
                remediate_group_membership()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_group_membership():
        command = "auditpol /set /subcategory:\"Group Membership\" /success:enable"
        try:
            os.system(command)
            print("The Group Membership setting has been set to include Success.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_group_membership()

def task_17_5_3():
    def check_logoff():
        command = "auditpol /get /subcategory:\"Logoff\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The Logoff setting is set correctly.")
            else:
                print("The Logoff setting is not set correctly. Applying the recommended setting...")
                remediate_logoff()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_logoff():
        command = "auditpol /set /subcategory:\"Logoff\" /success:enable"
        try:
            os.system(command)
            print("The Logoff setting has been set to include Success.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_logoff()

def task_17_5_5():
    def check_other_logon_logoff_events():
        command = "auditpol /get /subcategory:\"Other Logon/Logoff Events\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result and "Failure" in result:
                print("The 'Other Logon/Logoff Events' setting is set correctly.")
            else:
                print("The 'Other Logon/Logoff Events' setting is not set correctly. Applying the recommended setting...")
                remediate_other_logon_logoff_events()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_other_logon_logoff_events():
        command = "auditpol /set /subcategory:\"Other Logon/Logoff Events\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'Other Logon/Logoff Events' setting has been set to include Success and Failure.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_other_logon_logoff_events()

def task_17_5_6():
    def check_special_logon():
        command = "auditpol /get /subcategory:\"Special Logon\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The 'Special Logon' setting is set correctly.")
            else:
                print("The 'Special Logon' setting is not set correctly. Applying the recommended setting...")
                remediate_special_logon()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_special_logon():
        command = "auditpol /set /subcategory:\"Special Logon\" /success:enable"
        try:
            os.system(command)
            print("The 'Special Logon' setting has been set to include Success.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_special_logon()

def task_17_6_1():
    def check_detailed_file_share():
        command = "auditpol /get /subcategory:\"Detailed File Share\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Failure" in result:
                print("The 'Detailed File Share' setting is set correctly.")
            else:
                print("The 'Detailed File Share' setting is not set correctly. Applying the recommended setting...")
                remediate_detailed_file_share()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_detailed_file_share():
        command = "auditpol /set /subcategory:\"Detailed File Share\" /failure:enable"
        try:
            os.system(command)
            print("The 'Detailed File Share' setting has been set to include Failure.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_detailed_file_share()

def task_17_6_2():
    def check_file_share():
        command = "auditpol /get /subcategory:\"File Share\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The 'File Share' setting is set correctly.")
            else:
                print("The 'File Share' setting is not set correctly. Applying the recommended setting...")
                remediate_file_share()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_file_share():
        command = "auditpol /set /subcategory:\"File Share\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'File Share' setting has been set to 'Success and Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_file_share()

def task_17_6_3():
    def check_other_object_access_events():
        command = "auditpol /get /subcategory:\"Other Object Access Events\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The 'Other Object Access Events' setting is set correctly.")
            else:
                print("The 'Other Object Access Events' setting is not set correctly. Applying the recommended setting...")
                remediate_other_object_access_events()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_other_object_access_events():
        command = "auditpol /set /subcategory:\"Other Object Access Events\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'Other Object Access Events' setting has been set to 'Success and Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_other_object_access_events()

def task_17_6_4():
    def check_removable_storage():
        command = "auditpol /get /subcategory:\"Removable Storage\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The 'Removable Storage' setting is set correctly.")
            else:
                print("The 'Removable Storage' setting is not set correctly. Applying the recommended setting...")
                remediate_removable_storage()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_removable_storage():
        command = "auditpol /set /subcategory:\"Removable Storage\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'Removable Storage' setting has been set to 'Success and Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_removable_storage()

def task_17_7_1():
    def check_audit_policy_change():
        command = "auditpol /get /subcategory:\"Audit Policy Change\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The 'Audit Policy Change' setting is set correctly to include 'Success'.")
            else:
                print("The 'Audit Policy Change' setting is not set correctly. Applying the recommended setting...")
                remediate_audit_policy_change()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_audit_policy_change():
        command = "auditpol /set /subcategory:\"Audit Policy Change\" /success:enable"
        try:
            os.system(command)
            print("The 'Audit Policy Change' setting has been set to include 'Success'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_audit_policy_change()

def task_17_7_2():
    def check_authentication_policy_change():
        command = "auditpol /get /subcategory:\"Authentication Policy Change\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The 'Authentication Policy Change' setting is set correctly to include 'Success'.")
            else:
                print("The 'Authentication Policy Change' setting is not set correctly. Applying the recommended setting...")
                remediate_authentication_policy_change()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_authentication_policy_change():
        command = "auditpol /set /subcategory:\"Authentication Policy Change\" /success:enable"
        try:
            os.system(command)
            print("The 'Authentication Policy Change' setting has been set to include 'Success'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_authentication_policy_change()

def task_17_7_3():
    def check_authorization_policy_change():
        command = "auditpol /get /subcategory:\"Authorization Policy Change\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The 'Authorization Policy Change' setting is set correctly to include 'Success'.")
            else:
                print("The 'Authorization Policy Change' setting is not set correctly. Applying the recommended setting...")
                remediate_authorization_policy_change()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_authorization_policy_change():
        command = "auditpol /set /subcategory:\"Authorization Policy Change\" /success:enable"
        try:
            os.system(command)
            print("The 'Authorization Policy Change' setting has been set to include 'Success'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_authorization_policy_change()

def task_17_7_4():
    def check_mpssvc_rule_level_policy_change():
        command = "auditpol /get /subcategory:\"MPSSvc Rule-Level Policy Change\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The 'MPSSvc Rule-Level Policy Change' setting is set correctly to 'Success and Failure'.")
            else:
                print("The 'MPSSvc Rule-Level Policy Change' setting is not set correctly. Applying the recommended setting...")
                remediate_mpssvc_rule_level_policy_change()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_mpssvc_rule_level_policy_change():
        command = "auditpol /set /subcategory:\"MPSSvc Rule-Level Policy Change\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'MPSSvc Rule-Level Policy Change' setting has been set to 'Success and Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_mpssvc_rule_level_policy_change()

def task_17_7_5():
    def check_other_policy_change_events():
        command = "auditpol /get /subcategory:\"Other Policy Change Events\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Failure" in result:
                print("The 'Other Policy Change Events' setting is set correctly to include 'Failure'.")
            else:
                print("The 'Other Policy Change Events' setting is not set correctly. Applying the recommended setting...")
                remediate_other_policy_change_events()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_other_policy_change_events():
        command = "auditpol /set /subcategory:\"Other Policy Change Events\" /failure:enable"
        try:
            os.system(command)
            print("The 'Other Policy Change Events' setting has been set to include 'Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_other_policy_change_events()

def task_17_8_1():
    def check_sensitive_privilege_use():
        command = "auditpol /get /subcategory:\"Sensitive Privilege Use\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The 'Sensitive Privilege Use' setting is set correctly to 'Success and Failure'.")
            else:
                print("The 'Sensitive Privilege Use' setting is not set correctly. Applying the recommended setting...")
                remediate_sensitive_privilege_use()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_sensitive_privilege_use():
        command = "auditpol /set /subcategory:\"Sensitive Privilege Use\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'Sensitive Privilege Use' setting has been set to 'Success and Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_sensitive_privilege_use()

def task_17_9_1():
    def check_ipsec_driver_audit():
        command = "auditpol /get /subcategory:\"IPsec Driver\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The 'Audit IPsec Driver' setting is set correctly to 'Success and Failure'.")
            else:
                print("The 'Audit IPsec Driver' setting is not set correctly. Applying the recommended setting...")
                remediate_ipsec_driver_audit()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_ipsec_driver_audit():
        command = "auditpol /set /subcategory:\"IPsec Driver\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'Audit IPsec Driver' setting has been set to 'Success and Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_ipsec_driver_audit()

def task_17_9_2():
    def check_other_system_events_audit():
        command = "auditpol /get /subcategory:\"Other System Events\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The 'Audit Other System Events' setting is set correctly to 'Success and Failure'.")
            else:
                print("The 'Audit Other System Events' setting is not set correctly. Applying the recommended setting...")
                remediate_other_system_events_audit()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_other_system_events_audit():
        command = "auditpol /set /subcategory:\"Other System Events\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'Audit Other System Events' setting has been set to 'Success and Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_other_system_events_audit()

def task_17_9_3():
    def check_security_state_change_audit():
        command = "auditpol /get /subcategory:\"Security State Change\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The 'Audit Security State Change' setting is set correctly to include 'Success'.")
            else:
                print("The 'Audit Security State Change' setting is not set correctly. Applying the recommended setting...")
                remediate_security_state_change_audit()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_security_state_change_audit():
        command = "auditpol /set /subcategory:\"Security State Change\" /success:enable"
        try:
            os.system(command)
            print("The 'Audit Security State Change' setting has been set to include 'Success'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_security_state_change_audit()

def task_17_9_4():
    def check_security_system_extension_audit():
        command = "auditpol /get /subcategory:\"Security System Extension\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success" in result:
                print("The 'Audit Security System Extension' setting is set correctly to include 'Success'.")
            else:
                print("The 'Audit Security System Extension' setting is not set correctly. Applying the recommended setting...")
                remediate_security_system_extension_audit()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_security_system_extension_audit():
        command = "auditpol /set /subcategory:\"Security System Extension\" /success:enable"
        try:
            os.system(command)
            print("The 'Audit Security System Extension' setting has been set to include 'Success'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_security_system_extension_audit()

def task_17_9_5():
    def check_system_integrity_audit():
        command = "auditpol /get /subcategory:\"System Integrity\""
        try:
            result = subprocess.check_output(command, shell=True, text=True)
            if "Success and Failure" in result:
                print("The 'Audit System Integrity' setting is set correctly to 'Success and Failure'.")
            else:
                print("The 'Audit System Integrity' setting is not set correctly. Applying the recommended setting...")
                remediate_system_integrity_audit()
        except Exception as e:
            print(f"An error occurred: {e}")

    def remediate_system_integrity_audit():
        command = "auditpol /set /subcategory:\"System Integrity\" /success:enable /failure:enable"
        try:
            os.system(command)
            print("The 'Audit System Integrity' setting has been set to 'Success and Failure'.")
        except Exception as e:
            print(f"An error occurred: {e}")

    check_system_integrity_audit()
task_17_1_1()
task_17_2_1()
task_17_2_2()
task_17_2_3()
task_17_3_1()
task_17_3_2()
task_17_5_1()
task_17_5_2()
task_17_5_3()
task_17_5_5()
task_17_5_6()
task_17_6_1()
task_17_6_2()
task_17_6_3()
task_17_6_4()
task_17_7_1()
task_17_7_2()
task_17_7_3()
task_17_7_4()
task_17_7_5()
task_17_8_1()
task_17_9_1()
task_17_9_2()
task_17_9_3()
task_17_9_4()
task_17_9_5()