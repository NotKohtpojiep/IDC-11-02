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
using System.Windows.Shapes;
using SqlAdminUtility.classes;

namespace SqlAdminUtility.pages
{
    /// <summary>
    /// Логика взаимодействия для CreateProfileAccount.xaml
    /// </summary>
    public partial class CreateProfileAccountPage : Page
    {
        SqlServerActions actions = new SqlServerActions();
        public CreateProfileAccountPage()
        {
            InitializeComponent();
            AccountNames_CB.ItemsSource = actions.GetMailAccounts();
        }

        private void AddProfileAccount(MailProfile mailProfile, string accountName)
        {
            string addProfileSp =
                "EXECUTE msdb.dbo.sysmail_add_profile_sp "
                + $"@profile_name = '{mailProfile.Name}'";
            actions.exec_Querey(addProfileSp);

            string addProfileAccountSp =
                "EXECUTE msdb.dbo.sysmail_add_profileaccount_sp "
                + $"@profile_name = '{mailProfile.Name}', "
                + $"@account_name = '{accountName}', "
                + "@sequence_number = 1;";
            actions.exec_Querey(addProfileAccountSp);

            string addPrincipalProfileSp =
                "EXECUTE msdb.dbo.sysmail_add_principalprofile_sp "
                + $"@profile_name = '{mailProfile.Name}', "
                + "@principal_id = 0, "
                + "@is_default = 1";
            actions.exec_Querey(addPrincipalProfileSp);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string profileName = ProfileName_TB.Text;
            string accountName = ((MailAccount)AccountNames_CB.SelectedItem).Name;

            if (string.IsNullOrWhiteSpace(profileName) || string.IsNullOrWhiteSpace(accountName))
            {
                MessageBox.Show("Не, ну ты там внатуре контуженный что ли?");
                return;
            }

            AddProfileAccount(new MailProfile(0, profileName, null), accountName);
            MessageBox.Show("Профиль создан успешно!");
        }
    }
}
