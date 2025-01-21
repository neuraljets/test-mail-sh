# test-mail-sh

A simple Bash script to send a test email using SWAKS.

It reads the body and recipients from files. The body file should contain the email body, and the recipients file should contain a list of email addresses, one per line.

It sends the email using the SMTP server, username, and password provided.

Emails are sent one by one to each recipient, with a random delay of 0 to 120 seconds between them.

## Requirements

Install SWAKS using the package manager of your choice.

```bash
brew install swaks # macOS
sudo apt-get install swaks # Debian/Ubuntu
sudo yum install swaks # CentOS/RHEL
sudo dnf install swaks # Fedora
sudo pacman -S swaks # Arch
sudo zypper install swaks # OpenSUSE
```

Make sure the script is executable.

```bash
chmod +x test_mail.sh
```

## Usage

```bash
./test_mail.sh <SMTP_SERVER> <USERNAME> <PASSWORD> <FROM_EMAIL> <SUBJECT> <BODY_FILE> <RECIPIENTS_FILE>
```

## Example

```bash
./test_mail.sh send.c.mxascen.com foo@bar.com 'password' foo@bar.com 'Test Email' body.txt recipients.txt
```
