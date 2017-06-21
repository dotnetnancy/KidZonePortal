using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using System.IO;
using System.Xml;
using System.Collections.Specialized;

namespace CaptchaControl
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:WhoWhatWhere runat=server></{0}:WhoWhatWhere>")]
    public class WhoWhatWhere : WebControl, INamingContainer, IPostBackEventHandler
    {
        Assembly _assembly;
      
        XmlDocument _xmlDocument;

        //user needs to pick a category, then we choose the appropriate question/s for that category,
        //then the user needs to provide the correct answer for the questions, maybe we will start with
        //one question for now and then more questions later if necessary.  something like who what where
        //etc
        RadioButtonList rdoListAnswers = new RadioButtonList();
        DropDownList ddlCategories = new DropDownList();
        DropDownList ddlQuestions = new DropDownList();
        Image figureItOut = new Image();     

        Dictionary<string, List<string>> categoryIDToQuestionID = new Dictionary<string, List<string>>();
        Dictionary<string, string> questionIDToAnswer = new Dictionary<string, string>();
        Dictionary<string, string> questionIDToQuestion = new Dictionary<string, string>();
        Dictionary<string, string> categoryToImage = new Dictionary<string, string>();
        Dictionary<string, string> categoryToQuestion = new Dictionary<string, string>();
        Dictionary<string, Dictionary<string, string>> categoryToMultipleChoice = new Dictionary<string, Dictionary<string, string>>();


        public WhoWhatWhere()
        {

            try
            {
                _assembly = Assembly.GetExecutingAssembly();

                Stream fileStream = Assembly.GetExecutingAssembly().GetManifestResourceStream("CaptchaControl.data.xml");
                XmlDocument xml = null;

                if (fileStream != null)
                {
                    xml = new XmlDocument();
                    xml.Load(fileStream);
                }

                _xmlDocument = xml;
                InitializeDataStructures();

                //This seriously saved me from hours of pulling my hair out due to viewstate not having
                //the new values that the user set these to in the UI.  the control can render these, but
                //if they are not added to the controls collection then they are not handled correctly including
                //viewstate... 
                this.Controls.Add(ddlCategories);
                this.Controls.Add(ddlQuestions);
                this.Controls.Add(rdoListAnswers);

            }
            catch
            {
                //error

            }
        }

        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        public string Text
        {
            get
            {
                String s = (String)ViewState["Text"];
                return ((s == null) ? String.Empty : s);
            }

            set
            {
                ViewState["Text"] = value;
            }
        }

        public event EventHandler Change;

        public void RaisePostBackEvent(string eventArgument)
        {
            switch (eventArgument.ToLower())
            {
                case "change":
                    if (this.Change != null)
                        this.Change(this, new EventArgs());
                    break;
            }
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {          
            writer.RenderBeginTag(HtmlTextWriterTag.Table);
            writer.RenderBeginTag(HtmlTextWriterTag.Tr);
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            
            //this is what allows us to get postbacks on our controls in this webcontrol
            writer.AddAttribute(HtmlTextWriterAttribute.Onchange,
                //Page.GetPostBackClientHyperlink(ddlCategories, "change"));
                Page.GetPostBackEventReference(this, "change"));

            this.ddlCategories.RenderControl(writer);
            writer.RenderEndTag();    // td
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            writer.Write("/");
            writer.RenderEndTag();    // td
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            this.ddlQuestions.RenderControl(writer);
            writer.RenderEndTag();    // td           

            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            writer.Write("/");
            writer.RenderEndTag();    // td
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            this.figureItOut.RenderControl(writer);
            writer.RenderEndTag();    // td
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            this.rdoListAnswers.RenderControl(writer);
            writer.RenderEndTag();    // td
            writer.RenderEndTag();    // tr
            writer.RenderEndTag();    // table

            //output.Write(Text);
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);          
            
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!this.Page.IsPostBack)
            {
                this.figureItOut.ViewStateMode = System.Web.UI.ViewStateMode.Enabled;
                this.ViewStateMode = ViewStateMode.Enabled;
                this.ddlCategories.AutoPostBack = true;
                this.ddlCategories.ViewStateMode = ViewStateMode.Enabled;
                this.ddlCategories.DataSource = categoryIDToQuestionID;
                ddlCategories.DataValueField = "Key";
                ddlCategories.DataTextField = "Key";

                this.ddlCategories.DataBind();

                this.ddlCategories.SelectedIndexChanged += new EventHandler(ddlCategories_SelectedIndexChanged);
                this.ddlQuestions.SelectedIndexChanged += new EventHandler(ddlQuestions_SelectedIndexChanged);
                this.rdoListAnswers.SelectedIndexChanged += new EventHandler(rdoListAnswers_SelectedIndexChanged);

                this.ddlQuestions.AutoPostBack = true;
                this.ddlQuestions.ViewStateMode = ViewStateMode.Enabled;

                this.rdoListAnswers.AutoPostBack = true;
                this.rdoListAnswers.ViewStateMode = ViewStateMode.Enabled;
                this.ddlCategories.SelectedIndex = 0;
                this.ddlCategories_SelectedIndexChanged(ddlCategories, new EventArgs());
                this.ddlQuestions_SelectedIndexChanged(ddlQuestions, new EventArgs());                            
               
            }
            else
            {
                   string imageFileName = GetImageFileNameFromCategory(ddlCategories.SelectedValue);
                   if (!string.IsNullOrEmpty(imageFileName))
                   {
                       string strnamespace = this.GetType().Namespace;
                       string resourcePath = strnamespace + "." + imageFileName;
                       Stream imageStream = _assembly.GetManifestResourceStream(resourcePath);
                       figureItOut.ImageUrl = Page.ClientScript.GetWebResourceUrl(this.GetType(), resourcePath);
                   }

                     
                if (ViewState["ddlCategoriesSelectedValue"] != null)
                {
                    string viewStateCategories = (string)ViewState["ddlCategoriesSelectedValue"] ;
                    if (ddlCategories.SelectedValue != viewStateCategories)
                    {
                        this.ddlCategories_SelectedIndexChanged(ddlCategories, new EventArgs());
                        this.ddlQuestions_SelectedIndexChanged(ddlQuestions, new EventArgs());
                        this.rdoListAnswers_SelectedIndexChanged(rdoListAnswers, new EventArgs());
                    }
                    else
                    {
                        if (ViewState["ddlQuestionsSelectedValue"] != null)
                        {
                            string viewStateQuestions = (string)ViewState["ddlQuestionsSelectedValue"];
                            if (ddlQuestions.SelectedValue != viewStateQuestions)
                            {
                                this.ddlQuestions_SelectedIndexChanged(ddlQuestions, new EventArgs());
                                this.rdoListAnswers_SelectedIndexChanged(rdoListAnswers, new EventArgs());
                            }
                        }
                    }

                }
                if (ViewState["rdoListAnswers"] != null)
                {
                    string viewStateAnswers = (string)ViewState["rdoListAnswers"];
                    if (rdoListAnswers.SelectedValue != viewStateAnswers)
                    {
                        this.rdoListAnswers_SelectedIndexChanged(rdoListAnswers, new EventArgs());
                    }
                }
                
            }
     
        }

        protected override object SaveViewState()
        {
            ViewState.Add("ddlCategoriesSelectedValue", ddlCategories.SelectedValue);
            ViewState.Add("ddlQuestionsSelectedValue", ddlQuestions.SelectedValue);
            ViewState.Add("rdoListAnswers", rdoListAnswers.SelectedValue);
            return base.SaveViewState();
        }

        protected override void LoadViewState(object savedState)
        {
            base.LoadViewState(savedState);
           
        }


        void rdoListAnswers_SelectedIndexChanged(object sender, EventArgs e)
        {
            string questionID = ((RadioButtonList)sender).SelectedValue;
             
            string categoryByQuestion = GetCategoryIDByQuestionID(questionID);

            if (!string.IsNullOrEmpty(categoryByQuestion))
            {
                string imageFileName = GetImageFileNameFromCategory(categoryByQuestion);
                if (!string.IsNullOrEmpty(imageFileName))
                {
                    string strnamespace = this.GetType().Namespace;
                    string resourcePath = strnamespace + "." + imageFileName;
                    Stream imageStream = _assembly.GetManifestResourceStream(resourcePath);
                    figureItOut.ImageUrl = Page.ClientScript.GetWebResourceUrl(this.GetType(), resourcePath);
                }
            }

            if (questionIDToAnswer.ContainsKey(questionID))
            {
                this.Text = true.ToString();
            }
            else
                this.Text = false.ToString();
        }

        void ddlQuestions_SelectedIndexChanged(object sender, EventArgs e)
        {
            //by this point the user has chosen the question they would like us to present
            //so now we should present the image and the list of answers to choose from
            string questionID =  ((DropDownList)sender).SelectedItem.Value;
            string categoryByQuestion = GetCategoryIDByQuestionID(questionID);
            if (!string.IsNullOrEmpty(categoryByQuestion))
            {
                string imageFileName = GetImageFileNameFromCategory(categoryByQuestion);
                if (!string.IsNullOrEmpty(imageFileName))
                {
                    string strnamespace = this.GetType().Namespace;
                    string resourcePath = strnamespace + "." + imageFileName;
                    Stream imageStream = _assembly.GetManifestResourceStream(resourcePath);
                    figureItOut.ImageUrl = Page.ClientScript.GetWebResourceUrl(this.GetType(), resourcePath);

                    FillRadioButtonListWithAnswers(categoryByQuestion);
                }
            }


        }

        void ddlCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            string category = ((DropDownList)sender).SelectedItem.Value;
            List<string> questionIDs = GetQuestionsByCategoryID(category);
            Dictionary<string, string> questionsForThisCategory = new Dictionary<string, string>();
            if (categoryToQuestion.ContainsKey(category))
            {
                questionsForThisCategory.Add(questionIDs[0], categoryToQuestion[category]);
            }

            if (questionsForThisCategory.Count > 0)
            {
                ddlQuestions.DataSource = questionsForThisCategory;
                ddlCategories.AutoPostBack = true;
                ddlCategories.ViewStateMode = ViewStateMode.Enabled;
                ddlQuestions.DataValueField = "Key";

                ddlQuestions.DataTextField = "Value";
                ddlQuestions.DataBind();
            }


        }


        private void FillRadioButtonListWithAnswers(string category)
        {
            rdoListAnswers.Items.Clear();

            foreach (KeyValuePair<string, Dictionary<string,string>> kvp in categoryToMultipleChoice)
            {
                if (kvp.Key == category)
                {
                    foreach (KeyValuePair<string, string> kvp1 in kvp.Value)
                    {
                        rdoListAnswers.Items.Add(new ListItem() { Text = kvp1.Value, Value = kvp1.Key });
                    }
                }
            }
        }

       
        private string GetImageFileNameFromCategory(string categoryByQuestion)
        {
            if (categoryToImage.ContainsKey(categoryByQuestion))
            {
                return categoryToImage[categoryByQuestion];
            }
            return string.Empty;
        }

        private string GetCategoryIDByQuestionID(string questionID)
        {
            foreach (KeyValuePair<string, List<string>> kvp in categoryIDToQuestionID)
            {
                if (kvp.Value.Contains(questionID))
                {
                    return kvp.Key;
                }
            }
            return string.Empty;
        }


        private List<string> GetQuestionsByCategoryID(string category)
        {
            if (categoryIDToQuestionID.ContainsKey(category))
            {
                return categoryIDToQuestionID[category];
            }           
            return new List<string>();
        }

        private void InitializeDataStructures()
        {
            XmlNodeList categories = _xmlDocument.SelectNodes("//category");
            foreach (XmlNode category in categories)
            {
                categoryToQuestion.Add(category.Attributes["name"].Value, category.Attributes["value"].Value);
                //Dictionary<string, string> categoryIDToQuestionID = new Dictionary<string, string>();
                //Dictionary<string, string> questionIDToAnswer = new Dictionary<string, string>();
                //Dictionary<string, string> questionIDToQuestion = new Dictionary<string, string>();
                XmlNode subcategory = category.SelectSingleNode("subCategory");

                XmlNodeList questions = subcategory.SelectNodes("question");
                XmlNode answer = subcategory.SelectSingleNode("answer");
                if (!categoryToImage.ContainsKey(category.Attributes["name"].Value))
                {
                    categoryToImage.Add(category.Attributes["name"].Value, subcategory.Attributes["value"].Value);
                }

                foreach (XmlNode question in questions)
                {
                    if (categoryToMultipleChoice.ContainsKey(category.Attributes["name"].Value))
                    {

                        categoryToMultipleChoice[category.Attributes["name"].Value].Add(question.Attributes["name"].Value, question.Attributes["value"].Value);
                    }
                    else
                    {
                        Dictionary<string, string> dict = new Dictionary<string, string>();

                        dict.Add(question.Attributes["name"].Value, question.Attributes["value"].Value);
                        categoryToMultipleChoice.Add(category.Attributes["name"].Value, dict);
                    }  
    
                    if (categoryIDToQuestionID.ContainsKey(category.Attributes["name"].Value))
                    {
                        if (!categoryIDToQuestionID[category.Attributes["name"].Value].Contains(question.Attributes["name"].Value))
                        {
                            categoryIDToQuestionID[category.Attributes["name"].Value].Add(question.Attributes["name"].Value);
                        }
                    }
                    else
                    {
                        categoryIDToQuestionID.Add(category.Attributes["name"].Value,
                            new List<string>());
                        categoryIDToQuestionID[category.Attributes["name"].Value].Add(question.Attributes["name"].Value);

                    }

                    if (!questionIDToQuestion.ContainsKey(question.Attributes["name"].Value))
                    {
                        questionIDToQuestion.Add(question.Attributes["name"].Value,
                            category.Attributes["value"].Value);
                    }
                }

                if (!questionIDToAnswer.ContainsKey(answer.Attributes["value"].Value))
                {
                    questionIDToAnswer.Add(answer.Attributes["value"].Value, answer.Attributes["name"].Value);
                }

            }
        }
    }
}

       

#region pretty good example but with compositecontrol instead of webcontrol shows raising events
/*
// Register.cs
using System;
using System.ComponentModel;
using System.Drawing;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Samples.AspNet.CS.Controls
{
    [
    AspNetHostingPermission(SecurityAction.Demand,
        Level = AspNetHostingPermissionLevel.Minimal),
    AspNetHostingPermission(SecurityAction.InheritanceDemand, 
        Level=AspNetHostingPermissionLevel.Minimal),
    DefaultEvent("Submit"),
    DefaultProperty("ButtonText"),
    ToolboxData("<{0}:Register runat=\"server\"> </{0}:Register>"),
    ]
    public class Register : CompositeControl
    {
        private Button submitButton;
        private TextBox nameTextBox;
        private Label nameLabel;
        private TextBox emailTextBox;
        private Label emailLabel;
        private RequiredFieldValidator emailValidator;
        private RequiredFieldValidator nameValidator;

        private static readonly object EventSubmitKey = 
            new object();

        // The following properties are delegated to 
        // child controls.
        [
        Bindable(true),
        Category("Appearance"),
        DefaultValue(""),
        Description("The text to display on the button.")
        ]
        public string ButtonText
        {
            get
            {
                EnsureChildControls();
                return submitButton.Text;
            }
            set
            {
                EnsureChildControls();
                submitButton.Text = value;
            }
        }

        [
        Bindable(true),
        Category("Default"),
        DefaultValue(""),
        Description("The user name.")
        ]
        public string Name
        {
            get
            {
                EnsureChildControls();
                return nameTextBox.Text;
            }
            set
            {
                EnsureChildControls();
                nameTextBox.Text = value;
            }
        }

        [
        Bindable(true),
        Category("Appearance"),
        DefaultValue(""),
        Description(
            "Error message for the name validator.")
        ]
        public string NameErrorMessage
        {
            get
            {
                EnsureChildControls();
                return nameValidator.ErrorMessage;
            }
            set
            {
                EnsureChildControls();
                nameValidator.ErrorMessage = value;
                nameValidator.ToolTip = value;
            }
        }

        [
        Bindable(true),
        Category("Appearance"),
        DefaultValue(""),
        Description("The text for the name label.")
        ]
        public string NameLabelText
        {
            get
            {
                EnsureChildControls();
                return nameLabel.Text;
            }
            set
            {
                EnsureChildControls();
                nameLabel.Text = value;
            }
        }

        [
        Bindable(true),
        Category("Default"),
        DefaultValue(""),
        Description("The e-mail address.")
        ]
        public string Email
        {
            get
            {
                EnsureChildControls();
                return emailTextBox.Text;
            }
            set
            {
                EnsureChildControls();
                emailTextBox.Text = value;
            }
        }

        [
        Bindable(true),
        Category("Appearance"),
        DefaultValue(""),
        Description(
            "Error message for the e-mail validator.")
        ]
        public string EmailErrorMessage
        {
            get
            {
                EnsureChildControls();
                return emailValidator.ErrorMessage;
            }
            set
            {
                EnsureChildControls();
                emailValidator.ErrorMessage = value;
                emailValidator.ToolTip = value;
            }
        }

        [
        Bindable(true),
        Category("Appearance"),
        DefaultValue(""),
        Description("The text for the e-mail label.")
        ]
        public string EmailLabelText
        {
            get
            {
                EnsureChildControls();
                return emailLabel.Text;
            }
            set
            {
                EnsureChildControls();
                emailLabel.Text = value;

            }
        }

        // The Submit event.
        [
        Category("Action"),
        Description("Raised when the user clicks the button.")
        ]
        public event EventHandler Submit
        {
            add
            {
                Events.AddHandler(EventSubmitKey, value);
            }
            remove
            {
                Events.RemoveHandler(EventSubmitKey, value);
            }
        }

        // The method that raises the Submit event.
        protected virtual void OnSubmit(EventArgs e)
        {
            EventHandler SubmitHandler =
                (EventHandler)Events[EventSubmitKey];
            if (SubmitHandler != null)
            {
                SubmitHandler(this, e);
            }
        }

        // Handles the Click event of the Button and raises
        // the Submit event.
        private void _button_Click(object source, EventArgs e)
        {
            OnSubmit(EventArgs.Empty);
        }

        protected override void RecreateChildControls()
        {
            EnsureChildControls();
        }


        protected override void CreateChildControls()
        {
            Controls.Clear();

            nameLabel = new Label();

            nameTextBox = new TextBox();
            nameTextBox.ID = "nameTextBox";

            nameValidator = new RequiredFieldValidator();
            nameValidator.ID = "validator1";
            nameValidator.ControlToValidate = nameTextBox.ID;
            nameValidator.Text = "Failed validation.";
            nameValidator.Display = ValidatorDisplay.Static;

            emailLabel = new Label();

            emailTextBox = new TextBox();
            emailTextBox.ID = "emailTextBox";

            emailValidator = new RequiredFieldValidator();
            emailValidator.ID = "validator2";
            emailValidator.ControlToValidate = 
                emailTextBox.ID;
            emailValidator.Text = "Failed validation.";
            emailValidator.Display = ValidatorDisplay.Static;

            submitButton = new Button();
            submitButton.ID = "button1";
            submitButton.Click 
                += new EventHandler(_button_Click);

            this.Controls.Add(nameLabel);
            this.Controls.Add(nameTextBox);
            this.Controls.Add(nameValidator);
            this.Controls.Add(emailLabel);
            this.Controls.Add(emailTextBox);
            this.Controls.Add(emailValidator);
            this.Controls.Add(submitButton);
        }


        protected override void Render(HtmlTextWriter writer)
        {
            AddAttributesToRender(writer);

            writer.AddAttribute(
                HtmlTextWriterAttribute.Cellpadding,
                "1", false);
            writer.RenderBeginTag(HtmlTextWriterTag.Table);

            writer.RenderBeginTag(HtmlTextWriterTag.Tr);
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            nameLabel.RenderControl(writer);
            writer.RenderEndTag();
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            nameTextBox.RenderControl(writer);
            writer.RenderEndTag();
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            nameValidator.RenderControl(writer);
            writer.RenderEndTag();
            writer.RenderEndTag();

            writer.RenderBeginTag(HtmlTextWriterTag.Tr);
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            emailLabel.RenderControl(writer);
            writer.RenderEndTag();
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            emailTextBox.RenderControl(writer);
            writer.RenderEndTag();
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            emailValidator.RenderControl(writer);
            writer.RenderEndTag();
            writer.RenderEndTag();

            writer.RenderBeginTag(HtmlTextWriterTag.Tr);
            writer.AddAttribute(
                HtmlTextWriterAttribute.Colspan, 
                "2", false);
            writer.AddAttribute(
                HtmlTextWriterAttribute.Align, 
                "right", false);
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            submitButton.RenderControl(writer);
            writer.RenderEndTag();
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            writer.Write("&nbsp;");
            writer.RenderEndTag();
            writer.RenderEndTag();

            writer.RenderEndTag();
        }
    }
}

*/
#endregion


/*    Assembly _assembly;
         Stream _imageStream;
         StreamReader _textStreamReader;

         /// <summary>
         /// The main entry point for the application.
         /// </summary>
         [STAThread]
         static void Main() 
         {
            Application.Run(new Form1());
         }

         private void Form1_Load(object sender, System.EventArgs e)
         {
            try
            {
               _assembly = Assembly.GetExecutingAssembly();
               _imageStream = _assembly.GetManifestResourceStream("MyNamespace.MyImage.bmp");
              _textStreamReader = new StreamReader(_assembly.GetManifestResourceStream("MyNamespace.MyTextFile.txt"));
            }
            catch
            {
               MessageBox.Show("Error accessing resources!");
            }		
         }

         private void button1_Click(object sender, System.EventArgs e)
         {
            try
            {
               pictureBox1.Image = new Bitmap(_imageStream);
            }
            catch 
            {
               MessageBox.Show("Error creating image!");
            }
         }

         private void button2_Click(object sender, System.EventArgs e)
         {
            try
            {
               if(_textStreamReader.Peek() != -1)
               {
                  textBox1.Text = _textStreamReader.ReadLine();
               }
            }
            catch
            {
               MessageBox.Show("Error writing text!");
            }		
         }
      }
*/

/* [DefaultProperty("Value")]
   [ToolboxData("<{0}:DateEditBox runat=server></{0}:DateEditBox>")]
   public class DateEditBox : CompositeControl
   {
      private TextBox txtMonth = new TextBox();
      private TextBox txtDay   = new TextBox();
      private TextBox txtYear  = new TextBox();

      protected override void OnInit(EventArgs e)
      {
         base.OnInit(e);
         txtMonth.ID        = this.ID + "_month";
         txtMonth.MaxLength = 2;
         txtMonth.Width     = this.Width;

         txtDay.ID        = this.ID + "_day";
         txtDay.MaxLength = 2;
         txtDay.Width     = this.Width;

         txtYear.ID        = this.ID + "_year";
         txtYear.MaxLength = 4;
         txtYear.Width     = this.Width;
      }

      [Bindable(true)]
      [Category("Appearance")]
      [DefaultValue("")]
      [Localizable(true)]
      public DateTime Value
      {
         get
         {
            EnsureChildControls();
            if (txtMonth.Text == "" || txtDay.Text == "" ||
                txtYear.Text == "")
               return DateTime.MinValue;
            else
               return new DateTime(Convert.ToInt32(txtYear.Text),
                  Convert.ToInt32(txtMonth.Text),
                  Convert.ToInt32(txtDay.Text));
         }

         set
         {
            EnsureChildControls();
            txtMonth.Text = value.Month.ToString();
            txtDay.Text   = value.Day.ToString();
            txtYear.Text  = value.Year.ToString();
         }
      }
      protected override void CreateChildControls()
      {
         this.Controls.Add(txtMonth);
         this.Controls.Add(txtDay);
         this.Controls.Add(txtYear);
         base.CreateChildControls();
      }
      public override void RenderControl(HtmlTextWriter writer)
      {
         writer.RenderBeginTag(HtmlTextWriterTag.Table);
         writer.RenderBeginTag(HtmlTextWriterTag.Tr);
         writer.RenderBeginTag(HtmlTextWriterTag.Td);
         txtMonth.RenderControl(writer);
         writer.RenderEndTag();    // td
         writer.RenderBeginTag(HtmlTextWriterTag.Td);
         writer.Write("/");
         writer.RenderEndTag();    // td
         writer.RenderBeginTag(HtmlTextWriterTag.Td);
         txtDay.RenderControl(writer);
         writer.RenderEndTag();    // td
         writer.RenderBeginTag(HtmlTextWriterTag.Td);
         writer.Write("/");
         writer.RenderEndTag();    // td
         writer.RenderBeginTag(HtmlTextWriterTag.Td);
         txtYear.RenderControl(writer);
         writer.RenderEndTag();    // td
         writer.RenderEndTag();    // tr
         writer.RenderEndTag();    // table
      }
   }
}
*/
