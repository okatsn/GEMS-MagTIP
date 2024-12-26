using SFTPClient
using Suppressor
using OkFiles
using JSON
using Tar

# Access SFTP
start_dir = "home" # Change to "TWGEFN_文件上傳區"

ftp = @suppress SFTP(joinpath(ARGS[1], # ftp_url
        start_dir), ARGS[3], # username
    ARGS[4] # password
)
sftp = @suppress SFTP(joinpath(ARGS[2], start_dir), ARGS[3], ARGS[4]; create_known_hosts_entry=false, disable_verify_peer=true, disable_verify_host=true)
# KEYNOTE:
# - Test if the connection problem persist outside julia:: `curl -v sftp://xxx.xxx.xx.xx -u username:password`
# - `SFTP` can assign options: `; create_known_hosts_entry=true, disable_verify_peer=true, disable_verify_host=true`

statStructs = sftpstat(ftp)


Tar.create("GEMS-MagTIP-insider", "GEMS-MagTIP-insider.tar")


SFTPClient.upload(ftp, "GEMS-MagTIP-insider.tar")
