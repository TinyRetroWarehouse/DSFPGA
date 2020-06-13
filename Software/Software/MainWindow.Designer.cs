namespace Software
{
    partial class MainWindow
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
            this.button_Monitor = new System.Windows.Forms.Button();
            this.button_regmap_lua = new System.Windows.Forms.Button();
            this.richTextBox_console = new System.Windows.Forms.RichTextBox();
            this.button_compilevhdl = new System.Windows.Forms.Button();
            this.button_Vsimquiet = new System.Windows.Forms.Button();
            this.button_vsimgui = new System.Windows.Forms.Button();
            this.button_testspeed = new System.Windows.Forms.Button();
            this.button_regmap_csharp = new System.Windows.Forms.Button();
            this.button_rs232fileconnect = new System.Windows.Forms.Button();
            this.checkBox_receivedata = new System.Windows.Forms.CheckBox();
            this.timer_datareceive = new System.Windows.Forms.Timer(this.components);
            this.button_testconnection = new System.Windows.Forms.Button();
            this.button_controller = new System.Windows.Forms.Button();
            this.comboBox_screenmode = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // button_Monitor
            // 
            this.button_Monitor.Location = new System.Drawing.Point(477, 12);
            this.button_Monitor.Name = "button_Monitor";
            this.button_Monitor.Size = new System.Drawing.Size(103, 23);
            this.button_Monitor.TabIndex = 0;
            this.button_Monitor.Text = "Monitor";
            this.button_Monitor.UseVisualStyleBackColor = true;
            this.button_Monitor.Click += new System.EventHandler(this.button_Monitor_Click);
            // 
            // button_regmap_lua
            // 
            this.button_regmap_lua.Location = new System.Drawing.Point(12, 41);
            this.button_regmap_lua.Name = "button_regmap_lua";
            this.button_regmap_lua.Size = new System.Drawing.Size(191, 23);
            this.button_regmap_lua.TabIndex = 1;
            this.button_regmap_lua.Text = "Generate Registermap Lua";
            this.button_regmap_lua.UseVisualStyleBackColor = true;
            this.button_regmap_lua.Click += new System.EventHandler(this.button_regmap_Click);
            // 
            // richTextBox_console
            // 
            this.richTextBox_console.Location = new System.Drawing.Point(12, 122);
            this.richTextBox_console.Name = "richTextBox_console";
            this.richTextBox_console.Size = new System.Drawing.Size(984, 628);
            this.richTextBox_console.TabIndex = 2;
            this.richTextBox_console.Text = "";
            // 
            // button_compilevhdl
            // 
            this.button_compilevhdl.Location = new System.Drawing.Point(12, 12);
            this.button_compilevhdl.Name = "button_compilevhdl";
            this.button_compilevhdl.Size = new System.Drawing.Size(130, 23);
            this.button_compilevhdl.TabIndex = 3;
            this.button_compilevhdl.Text = "Compile VHDL";
            this.button_compilevhdl.UseVisualStyleBackColor = true;
            this.button_compilevhdl.Click += new System.EventHandler(this.button_compilevhdl_Click);
            // 
            // button_Vsimquiet
            // 
            this.button_Vsimquiet.Location = new System.Drawing.Point(282, 12);
            this.button_Vsimquiet.Name = "button_Vsimquiet";
            this.button_Vsimquiet.Size = new System.Drawing.Size(130, 23);
            this.button_Vsimquiet.TabIndex = 4;
            this.button_Vsimquiet.Text = "Simulate VHDL";
            this.button_Vsimquiet.UseVisualStyleBackColor = true;
            this.button_Vsimquiet.Click += new System.EventHandler(this.button_Vsimquiet_Click);
            // 
            // button_vsimgui
            // 
            this.button_vsimgui.Location = new System.Drawing.Point(282, 41);
            this.button_vsimgui.Name = "button_vsimgui";
            this.button_vsimgui.Size = new System.Drawing.Size(130, 23);
            this.button_vsimgui.TabIndex = 5;
            this.button_vsimgui.Text = "Simulate VHDL with Gui";
            this.button_vsimgui.UseVisualStyleBackColor = true;
            this.button_vsimgui.Click += new System.EventHandler(this.button_vsimgui_Click);
            // 
            // button_testspeed
            // 
            this.button_testspeed.Location = new System.Drawing.Point(477, 41);
            this.button_testspeed.Name = "button_testspeed";
            this.button_testspeed.Size = new System.Drawing.Size(103, 23);
            this.button_testspeed.TabIndex = 7;
            this.button_testspeed.Text = "Test Speed";
            this.button_testspeed.UseVisualStyleBackColor = true;
            this.button_testspeed.Click += new System.EventHandler(this.button_testspeed_Click);
            // 
            // button_regmap_csharp
            // 
            this.button_regmap_csharp.Location = new System.Drawing.Point(12, 70);
            this.button_regmap_csharp.Name = "button_regmap_csharp";
            this.button_regmap_csharp.Size = new System.Drawing.Size(191, 23);
            this.button_regmap_csharp.TabIndex = 9;
            this.button_regmap_csharp.Text = "Generate Registermap C#";
            this.button_regmap_csharp.UseVisualStyleBackColor = true;
            this.button_regmap_csharp.Click += new System.EventHandler(this.button_regmap_csharp_Click);
            // 
            // button_rs232fileconnect
            // 
            this.button_rs232fileconnect.Location = new System.Drawing.Point(282, 70);
            this.button_rs232fileconnect.Name = "button_rs232fileconnect";
            this.button_rs232fileconnect.Size = new System.Drawing.Size(130, 23);
            this.button_rs232fileconnect.TabIndex = 10;
            this.button_rs232fileconnect.Text = "RS232 Fileconnect";
            this.button_rs232fileconnect.UseVisualStyleBackColor = true;
            this.button_rs232fileconnect.Click += new System.EventHandler(this.button_rs232fileconnect_Click);
            // 
            // checkBox_receivedata
            // 
            this.checkBox_receivedata.AutoSize = true;
            this.checkBox_receivedata.Location = new System.Drawing.Point(477, 99);
            this.checkBox_receivedata.Name = "checkBox_receivedata";
            this.checkBox_receivedata.Size = new System.Drawing.Size(92, 17);
            this.checkBox_receivedata.TabIndex = 11;
            this.checkBox_receivedata.Text = "Receive Data";
            this.checkBox_receivedata.UseVisualStyleBackColor = true;
            // 
            // timer_datareceive
            // 
            this.timer_datareceive.Enabled = true;
            this.timer_datareceive.Tick += new System.EventHandler(this.timer_datareceive_Tick);
            // 
            // button_testconnection
            // 
            this.button_testconnection.Location = new System.Drawing.Point(477, 70);
            this.button_testconnection.Name = "button_testconnection";
            this.button_testconnection.Size = new System.Drawing.Size(103, 23);
            this.button_testconnection.TabIndex = 15;
            this.button_testconnection.Text = "Test Connection";
            this.button_testconnection.UseVisualStyleBackColor = true;
            this.button_testconnection.Click += new System.EventHandler(this.button_testconnection_Click);
            // 
            // button_controller
            // 
            this.button_controller.Location = new System.Drawing.Point(645, 12);
            this.button_controller.Name = "button_controller";
            this.button_controller.Size = new System.Drawing.Size(103, 23);
            this.button_controller.TabIndex = 16;
            this.button_controller.Text = "Controller";
            this.button_controller.UseVisualStyleBackColor = true;
            this.button_controller.Click += new System.EventHandler(this.button_controller_Click);
            // 
            // comboBox_screenmode
            // 
            this.comboBox_screenmode.FormattingEnabled = true;
            this.comboBox_screenmode.Items.AddRange(new object[] {
            "200/100 Ver",
            "100/100 Ver",
            "300/200 Hoz",
            "200/300 Hoz"});
            this.comboBox_screenmode.Location = new System.Drawing.Point(645, 70);
            this.comboBox_screenmode.Name = "comboBox_screenmode";
            this.comboBox_screenmode.Size = new System.Drawing.Size(121, 21);
            this.comboBox_screenmode.TabIndex = 17;
            this.comboBox_screenmode.SelectedIndexChanged += new System.EventHandler(this.comboBox_screenmode_SelectedIndexChanged);
            // 
            // MainWindow
            // 
            this.AllowDrop = true;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1008, 762);
            this.Controls.Add(this.comboBox_screenmode);
            this.Controls.Add(this.button_controller);
            this.Controls.Add(this.button_testconnection);
            this.Controls.Add(this.checkBox_receivedata);
            this.Controls.Add(this.button_rs232fileconnect);
            this.Controls.Add(this.button_regmap_csharp);
            this.Controls.Add(this.button_testspeed);
            this.Controls.Add(this.button_vsimgui);
            this.Controls.Add(this.button_Vsimquiet);
            this.Controls.Add(this.button_compilevhdl);
            this.Controls.Add(this.richTextBox_console);
            this.Controls.Add(this.button_regmap_lua);
            this.Controls.Add(this.button_Monitor);
            this.Name = "MainWindow";
            this.Text = "Mainwindow";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MainWindow_FormClosing);
            this.DragDrop += new System.Windows.Forms.DragEventHandler(this.MainWindow_DragDrop);
            this.DragEnter += new System.Windows.Forms.DragEventHandler(this.MainWindow_DragEnter);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button_Monitor;
        private System.Windows.Forms.Button button_regmap_lua;
        private System.Windows.Forms.RichTextBox richTextBox_console;
        private System.Windows.Forms.Button button_compilevhdl;
        private System.Windows.Forms.Button button_Vsimquiet;
        private System.Windows.Forms.Button button_vsimgui;
        private System.Windows.Forms.Button button_testspeed;
        private System.Windows.Forms.Button button_regmap_csharp;
        private System.Windows.Forms.Button button_rs232fileconnect;
        private System.Windows.Forms.CheckBox checkBox_receivedata;
        private System.Windows.Forms.Timer timer_datareceive;
        private System.Windows.Forms.Button button_testconnection;
        private System.Windows.Forms.Button button_controller;
        private System.Windows.Forms.ComboBox comboBox_screenmode;
    }
}

