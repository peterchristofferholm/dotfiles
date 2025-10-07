# Dotfiles

```bash
git clone https://github.com/peterchristofferholm/dotfiles.git ~/dotfiles
bash ~/dotfiles/bootstrap.sh
```

## Misc

### Import Zscaler certificates

```
# Get Zscaler root CA
#
# Get certificate thumbprint
$cert = @(Get-ChildItem -path Cert:\* -Recurse | where {$_.Subject –like '*Zscaler Root CA*'})[0] | Select -ExpandProperty Thumbprint
#
# Export certificate in DER format
Get-ChildItem -Path Cert:\LocalMachine\Root\ | where{$_.Thumbprint -eq $cert} | Export-Certificate -Type cer -FilePath $env:USERPROFILE\zscaler.cer
##

# Import Zcaler Root CA
wsl --user root -e bash -c "cd /mnt/c/Users/$Env:UserName/; cp zscaler.cer /root/;cd;ls"
wsl --user root -e bash -c "cd; openssl x509 -inform der -in zscaler.cer -out zscaler.crt;ls"
wsl --user root -e bash -c "cd /etc/ssl/certs/;cp /root/zscaler.crt .;chmod 644 zscaler.cert;ls -l"
wsl --user root -e bash -c "update-ca-certificates -v -f;"
```

```
sudo cp /root/zscaler.crt /usr/local/share/ca-certificates/zscaler.crt
```
