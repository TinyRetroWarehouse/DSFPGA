namespace Debugsw
{
    partial class Form1
    {
        /// <summary>
        /// Erforderliche Designervariable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Verwendete Ressourcen bereinigen.
        /// </summary>
        /// <param name="disposing">True, wenn verwaltete Ressourcen gelöscht werden sollen; andernfalls False.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Vom Windows Form-Designer generierter Code

        /// <summary>
        /// Erforderliche Methode für die Designerunterstützung.
        /// Der Inhalt der Methode darf nicht mit dem Code-Editor geändert werden.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.button_testconnection = new System.Windows.Forms.Button();
            this.richTextBox_send = new System.Windows.Forms.RichTextBox();
            this.richTextBox_receive = new System.Windows.Forms.RichTextBox();
            this.timer1_rec = new System.Windows.Forms.Timer(this.components);
            this.listBox_devices = new System.Windows.Forms.ListBox();
            this.button_open = new System.Windows.Forms.Button();
            this.button_speedtest = new System.Windows.Forms.Button();
            this.checkBox_autotest = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // button_testconnection
            // 
            this.button_testconnection.Location = new System.Drawing.Point(88, 12);
            this.button_testconnection.Name = "button_testconnection";
            this.button_testconnection.Size = new System.Drawing.Size(106, 23);
            this.button_testconnection.TabIndex = 0;
            this.button_testconnection.Text = "Test connection";
            this.button_testconnection.UseVisualStyleBackColor = true;
            this.button_testconnection.Click += new System.EventHandler(this.button_testconnection_Click);
            // 
            // richTextBox_send
            // 
            this.richTextBox_send.Location = new System.Drawing.Point(10, 130);
            this.richTextBox_send.Name = "richTextBox_send";
            this.richTextBox_send.Size = new System.Drawing.Size(264, 129);
            this.richTextBox_send.TabIndex = 1;
            this.richTextBox_send.Text = "";
            // 
            // richTextBox_receive
            // 
            this.richTextBox_receive.Location = new System.Drawing.Point(10, 265);
            this.richTextBox_receive.Name = "richTextBox_receive";
            this.richTextBox_receive.Size = new System.Drawing.Size(264, 129);
            this.richTextBox_receive.TabIndex = 2;
            this.richTextBox_receive.Text = "";
            // 
            // timer1_rec
            // 
            this.timer1_rec.Tick += new System.EventHandler(this.timer1_rec_Tick);
            // 
            // listBox_devices
            // 
            this.listBox_devices.FormattingEnabled = true;
            this.listBox_devices.Location = new System.Drawing.Point(12, 65);
            this.listBox_devices.Name = "listBox_devices";
            this.listBox_devices.Size = new System.Drawing.Size(262, 56);
            this.listBox_devices.TabIndex = 5;
            // 
            // button_open
            // 
            this.button_open.Location = new System.Drawing.Point(12, 12);
            this.button_open.Name = "button_open";
            this.button_open.Size = new System.Drawing.Size(70, 23);
            this.button_open.TabIndex = 6;
            this.button_open.Text = "Open";
            this.button_open.UseVisualStyleBackColor = true;
            this.button_open.Click += new System.EventHandler(this.button_open_Click);
            // 
            // button_speedtest
            // 
            this.button_speedtest.Location = new System.Drawing.Point(200, 12);
            this.button_speedtest.Name = "button_speedtest";
            this.button_speedtest.Size = new System.Drawing.Size(74, 23);
            this.button_speedtest.TabIndex = 7;
            this.button_speedtest.Text = "Speedtest";
            this.button_speedtest.UseVisualStyleBackColor = true;
            this.button_speedtest.Click += new System.EventHandler(this.button_speedtest_Click);
            // 
            // checkBox_autotest
            // 
            this.checkBox_autotest.AutoSize = true;
            this.checkBox_autotest.Location = new System.Drawing.Point(12, 42);
            this.checkBox_autotest.Name = "checkBox_autotest";
            this.checkBox_autotest.Size = new System.Drawing.Size(65, 17);
            this.checkBox_autotest.TabIndex = 8;
            this.checkBox_autotest.Text = "Autotest";
            this.checkBox_autotest.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(289, 412);
            this.Controls.Add(this.checkBox_autotest);
            this.Controls.Add(this.button_speedtest);
            this.Controls.Add(this.button_open);
            this.Controls.Add(this.listBox_devices);
            this.Controls.Add(this.richTextBox_receive);
            this.Controls.Add(this.richTextBox_send);
            this.Controls.Add(this.button_testconnection);
            this.Name = "Form1";
            this.Text = "Form1";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Form1_FormClosed);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Button button_testconnection;
        private System.Windows.Forms.RichTextBox richTextBox_send;
        private System.Windows.Forms.RichTextBox richTextBox_receive;
        private System.Windows.Forms.Timer timer1_rec;
        private System.Windows.Forms.ListBox listBox_devices;
        private System.Windows.Forms.Button button_open;
        private System.Windows.Forms.Button button_speedtest;
        private System.Windows.Forms.CheckBox checkBox_autotest;
    }
}

