using SFTPClient
using Suppressor
using OkFiles
using JSON
using Tar

# Access SFTP
gems_nas = JSON.parsefile(".devcontainer/gems-nas-sftp-ftp.json")

start_dir = "home/GEMS-MagTIP-insider" # Change to "TWGEFN_文件上傳區"

ftp = @suppress SFTP(joinpath(gems_nas["ftp_url"], start_dir), gems_nas["username"], gems_nas["password"])
sftp = @suppress SFTP(joinpath(gems_nas["sftp_url"], start_dir), gems_nas["username"], gems_nas["password"]; create_known_hosts_entry=false, disable_verify_peer=true, disable_verify_host=true)
# KEYNOTE:
# - Test if the connection problem persist outside julia:: `curl -v sftp://xxx.xxx.xx.xx -u username:password`
# - `SFTP` can assign options: `; create_known_hosts_entry=true, disable_verify_peer=true, disable_verify_host=true`

statStructs = sftpstat(ftp)


Tar.create("../workspace", "GEMS-MagTIP-insider.tar")


SFTPClient.upload(ftp, "GEMS-MagTIP-insider.tar")
