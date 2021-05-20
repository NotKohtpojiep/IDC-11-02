using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Forms;
using MigrationFromWinForms.Common;
using MigrationFromWinForms.Standart.DatabaseMail;
using MessageBox = System.Windows.MessageBox;

namespace MigrationFromWinForms.Standart
{
    /// <summary>
    /// Логика взаимодействия для SetAddressWindow.xaml
    /// </summary>
    public partial class SetAddressWindow : Window
    {
          private UserData ud;
        public SetAddressWindow()
        {
            InitializeComponent();

            ud = UserData.Load(ClassConstHelper.fileConfigsStandart);
            if (ud != null)
            {
                tbOwner.Text = ud.DbName;
                tbPass.Text = ud.Pass;
                tbServer.Text = ud.Server;
                tbUser.Text = ud.User;
            }
        }

        private ErrorProvider error { get; set; }
        public bool ConnectReady { get; set; }
        public string UserLogin { get; set; }
        public string UserPass { get; set; }

        private bool validServer;
        private bool validOwner;
        private bool validUser;
        private bool validPass;

        private void btClose_Click(object sender, RoutedEventArgs e)
        {
            ConnectReady = false;
            Close();
        }

        private void btConnect_Click(object sender, RoutedEventArgs e)
        {
            ValidatorDatabaseMail.ValidatingTextBox(tbServer, out validServer, error );
            ValidatorDatabaseMail.ValidatingTextBox(tbOwner, out validOwner, error);
            ValidatorDatabaseMail.ValidatingTextBox(tbUser, out validUser, error);
            ValidatorDatabaseMail.ValidatingTextBox(tbPass, out validPass, error);

            if (validOwner && validPass && validServer && validUser)
            {
                UserLogin = tbUser.Text;
                UserPass = tbPass.Text;

                ClassConstHelper.DB = tbOwner.Text;
                ClassConstHelper.serverSQL = tbServer.Text;

                ud.SetDatabase(tbOwner.Text, tbPass.Text, tbServer.Text, tbUser.Text);
                ud.Save(ClassConstHelper.fileConfigsStandart);

                ConnectReady = true;
                Close();
            }
            else
            {
                MessageBox.Show("WTFFFFFFFFFFFF");
            }
        }
    }
}
