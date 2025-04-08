using SFTPClient
using Suppressor
using OkFiles
using JSON
using Tar
using Dates

# Access SFTP
start_dir = "Workspace_GEMSMagTIP" # SETME: This should be identical to your root folder for push in NAS.

ftp = @suppress SFTP(joinpath(ARGS[1], # ftp_url
        start_dir), ARGS[3], # username
    ARGS[4] # password
)
sftp = @suppress SFTP(joinpath(ARGS[2], start_dir), ARGS[3], ARGS[4]; create_known_hosts_entry=false, disable_verify_peer=true, disable_verify_host=true)
# KEYNOTE:
# - Test if the connection problem persist outside julia:: `curl -v sftp://xxx.xxx.xx.xx -u username:password`
# - `SFTP` can assign options: `; create_known_hosts_entry=true, disable_verify_peer=true, disable_verify_host=true`

statStructs = sftpstat(ftp)


target_file = "GEMS-MagTIP-insider_$(today()).tar"

Tar.create("GEMS-MagTIP-insider", target_file)


SFTPClient.upload(ftp, target_file)
