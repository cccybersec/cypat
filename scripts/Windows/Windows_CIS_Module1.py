import subprocess
import os

# Command I used to make this whole script in Copilot:
# "Write a function to do the following: (argument that gets commented). If the function couldn't execute, return an error but don't end the script."
# Make sure to keep reloading till it gives you return statements


def enforce_password_history():
    """
    This function ensures that 'Enforce password history' is set to '24 or more password(s)'. 1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "PasswordHistorySize" in line:
            if int(line.split("=")[1].strip()) >= 24:
                return "Success"
            else:
                return "Error: Password history size is less than 24"

    return "Error: Password history size not found in secpol.cfg"


enforce_password_history()


def enforce_maximum_password_age():
    """
    This function ensures that 'Maximum password age' is set to '365 or fewer days, but not 0'. 1.1.2 (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "MaximumPasswordAge" in line:
            if (
                int(line.split("=")[1].strip()) <= 365
                and int(line.split("=")[1].strip()) != 0
            ):
                return "Success"
            else:
                return "Error: Maximum password age is greater than 365 or equal to 0"

    return "Error: Maximum password age not found in secpol.cfg"


enforce_maximum_password_age()


def enforce_minimum_password_age():
    """
    This function ensures that 'Minimum password age' is set to '1 or more day(s)'. 1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "MinimumPasswordAge" in line:
            if int(line.split("=")[1].strip()) >= 1:
                return "Success"
            else:
                return "Error: Minimum password age is less than 1"

    return "Error: Minimum password age not found in secpol.cfg"


enforce_minimum_password_age()


def enforce_minimum_password_length():
    """
    This function ensures that 'Minimum password length' is set to '14 or more character(s)'. 1.1.4 (L1) Ensure 'Minimum password length' is set to '14 or more character(s)'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "MinimumPasswordLength" in line:
            if int(line.split("=")[1].strip()) >= 14:
                return "Success"
            else:
                return "Error: Minimum password length is less than 14"

    return "Error: Minimum password length not found in secpol.cfg"


enforce_minimum_password_length()


def enforce_password_must_meet_complexity_requirements():
    """
    This function ensures that 'Password must meet complexity requirements' is set to 'Enabled'. 1.1.5 (L1) Ensure 'Password must meet complexity requirements' is set to 'Enabled'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "PasswordComplexity" in line:
            if int(line.split("=")[1].strip()) == 1:
                return "Success"
            else:
                return "Error: Password complexity is not enabled"

    return "Error: Password complexity not found in secpol.cfg"


enforce_password_must_meet_complexity_requirements()


def enforce_relax_minimum_password_length_limits():
    """
    This function ensures that 'Relax minimum password length limits' is set to 'Enabled'. 1.1.6 (L1) Ensure 'Relax minimum password length limits' is set to 'Enabled'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "PasswordComplexity" in line:
            if int(line.split("=")[1].strip()) == 1:
                return "Success"
            else:
                return "Error: Password complexity is not enabled"

    return "Error: Password complexity not found in secpol.cfg"


enforce_relax_minimum_password_length_limits()


def enforce_password_encryption():
    """
    This function ensures that 'Store passwords using reversible encryption' is set to 'Disabled'. 1.1.7 (L1) Ensure 'Store passwords using reversible encryption' is set to 'Disabled'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "ClearTextPassword" in line:
            if int(line.split("=")[1].strip()) == 0:
                return "Success"
            else:
                return "Error: Password encryption is not disabled"

    return "Error: Password encryption not found in secpol.cfg"


enforce_password_encryption()


def enforce_account_lockout_duration():
    """
    This function ensures that 'Account lockout duration' is set to '15 or more minute(s)'. 1.2.1 (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "LockoutDuration" in line:
            if int(line.split("=")[1].strip()) >= 15:
                return "Success"
            else:
                return "Error: Account lockout duration is less than 15 minutes"

    return "Error: Account lockout duration not found in secpol.cfg"


enforce_account_lockout_duration()


def enforce_account_lockout_threshold():
    """
    This function ensures that 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'.
    1.2.2 (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "LockoutBadCount" in line:
            if (
                int(line.split("=")[1].strip()) <= 5
                and int(line.split("=")[1].strip()) != 0
            ):
                return "Success"
            else:
                return "Error: Account lockout threshold is not set to 5 or fewer invalid logon attempt(s), but not 0"

    return "Error: Account lockout threshold not found in secpol.cfg"


enforce_account_lockout_threshold()


def enforce_allow_administrator_account_lockout():
    """
    This function ensures that 'Allow Administrator account lockout' is set to 'Enabled'.
    1.2.3 (L1) Ensure 'Allow Administrator account lockout' is set to 'Enabled'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "LockoutAdminUsers" in line:
            if line.split("=")[1].strip() == "1":
                return "Success"
            else:
                return "Error: Allow Administrator account lockout is not enabled"

    return "Error: Allow Administrator account lockout not found in secpol.cfg"


enforce_allow_administrator_account_lockout()


def enforce_reset_account_lockout_counter():
    """
    This function ensures that 'Reset account lockout counter after' is set to '15 or more minute(s)'.
    1.2.4 (L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)'
    """
    command = "Secedit /export /areas SECURITYPOLICY /cfg C:\\secpol.cfg"
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        return f"Error: {e}"

    with open("C:\\secpol.cfg", "r") as f:
        lines = f.readlines()

    for line in lines:
        if "ResetLockoutCount" in line:
            if int(line.split("=")[1].strip()) >= 15:
                return "Success"
            else:
                return "Error: Reset account lockout counter is not set to 15 or more minute(s)"

    return "Error: Reset account lockout counter not found in secpol.cfg"


enforce_reset_account_lockout_counter()
