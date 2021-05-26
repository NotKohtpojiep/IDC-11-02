using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using SqlAdminUtility.classes;

namespace SqlAdminUtility.pages
{
    /// <summary>
    /// Логика взаимодействия для smtpAccountPage.xaml
    /// </summary>
    public partial class smtpAccountPage : Page
    {
        SqlServerActions actions = new SqlServerActions();
        public smtpAccountPage()
        {
            InitializeComponent();
        }

        private void AddMailAccountSp(MailAccount mailAccount, MailServer mailServer, string password)
        {
            string smtpacctask =
                "EXECUTE msdb.dbo.sysmail_add_account_sp "
                + $"@account_name = '{mailAccount.Name}', "
                + $"@description = '{mailAccount.Description}', "
                + $"@email_address = '{mailAccount.EmailAddress}', "
                + $"@display_name = '{mailAccount.DisplayName}', "
                + $"@replyto_address = '{mailAccount.ReplyToAddress}', "
                + $"@mailserver_name = '{mailServer.ServerName}', "
                + $"@port = {mailServer.Port}, "
                + $"@username = '{mailServer.Username}', "
                + $"@password = '{password}', "
                + $"@enable_ssl = {mailServer.EnableSsl}";
            actions.exec_Querey(smtpacctask);
        }
        private void smtp_create_Click(object sender, RoutedEventArgs e)
        {
            MailAccount findAccount = actions.GetMailAccounts().FirstOrDefault(x => x.Name == account_name.Text);
            if (findAccount != null)
            {
                MessageBox.Show("Данное имя аккаунта уже есть в системе");
                return;
            }

            MailAccount mailAccount = new MailAccount(0,
                account_name.Text,
                description.Text,
                email_address.Text,
                display_name.Text,
                replyto_address.Text);
            MailServer mailServer = new MailServer(0,
                "SMTP",
                mailserver_name.Text,
                int.Parse(port.Text),
                username.Text,
                0,
                enable_ssl.IsChecked.Value);
            AddMailAccountSp(mailAccount, mailServer, password.Text);
            MessageBox.Show("Аккаунт создан успешно!");
        }
    }
}
