using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Net.Mail;


namespace TestWCFServiceCalls
{
    class Program
    {
        static void Main(string[] args)
        {

            //HpCodeQuestionFindMaxSum();

            string input = "n a ncy";
            ReplaceAllSpacesInAStringEasy(input);
            ReplaceAllSpacesInAStringMoreManualCharArrayBufferInStringBuilder(input);

            Console.ReadLine();


            //TrySendEmail();

            ////httpBinding set up in the config file of this client
            //using (AccountServiceClient accountClient = new AccountServiceClient())
            //{
                
            //    object obj = accountClient.LoginUser("testinternetregistration2", "12345678");
            //}

            ////restful call to the endpoint action/method
            //bool result = Login("testinternetregistration2", "12345678");
            
        }

        private static void ReplaceAllSpacesInAStringMoreManualCharArrayBufferInStringBuilder(string input)
        {
            //maybe we need to determine length based on how many spaces

            int length = input.Length;


            string result = null;

            Console.WriteLine("Before:  " + input);

            if (!input.Contains(' '))
            {
                result = input;
            }
            else
            {
                char [] inputArray = null;

                int more  = Array.FindAll(input.ToCharArray(),delegate(char arg)
                           {
                               return arg.Equals(char.IsWhiteSpace(arg));
                           }).Length;

                inputArray = new char[length + more * 3];
                for(int i = 0; i<inputArray.Length;i++)                    
                {
                    foreach (char inputC in input)
                    {
                        if (char.IsWhiteSpace(inputC))
                        {
                            inputArray[i] = '%';
                            inputArray[i++] = '2';
                            inputArray[i++] = '0';
                        }
                    }
                }

                result = inputArray.ToString();                
            }
            Console.WriteLine(result);
        }

        private static string ReplaceAllSpacesInAStringEasy(string input)
        {
            string result = null;

            Console.WriteLine("Before:  " + input);

            if (!input.Contains(' '))
            {
                result = input;            
            }
            else
            {
                StringBuilder sb = new StringBuilder(input);
                result = sb.Replace(" ", "%20").ToString();
            }

            Console.WriteLine(result);

            return result;           

        }

        private static void HpCodeQuestionFindMaxSum()
        {
            int[] array = new int[] { 5, 4, 3, 1, 2 };

            int prevIndex = 0;
            int nextIndex = 0;
            int maxSum = 0;
            int start = 0;
            int end = array.Length;

            for (int i = start; i < end - 1; i++)
            {
                int current = array[i];

                for (int j = start + 1; j < end; j++)
                {
                    int next = array[j];

                    if ((current + next) > maxSum)
                    {
                        maxSum = current + next;
                        prevIndex = i;
                        nextIndex = j;
                    }
                }
            }

            Console.WriteLine("Max Sum:  " + maxSum.ToString());
            Console.WriteLine("Previous Index:  " + prevIndex.ToString());
            Console.WriteLine("Next Index:  " + nextIndex.ToString());
        }

        private static void TrySendEmail()
        {
            using (AccountServiceClient accountClient = new AccountServiceClient())
            {

                object obj = accountClient.SendTestEmail("nancyconceicao@hotmail.com");
            }
        }

        public static bool Login(string username, string password)
        {
            bool authenticated = false;

           
                WebRequest request = HttpWebRequest.Create("http://localhost/AccountService/AccountService.svc/LoginUser");
                request.Method = "POST";
                request.ContentType = "application/json";

                StringBuilder data = new StringBuilder();
                data.Append("{\"username\":\"" + username + "\",");
                data.Append("\"password\":\"" + password + "\"}");

                // Create a byte array of the data we want to send
                byte[] byteData = UTF8Encoding.UTF8.GetBytes(data.ToString());

                // Set the content length in the request headers
                request.ContentLength = byteData.Length;

                // Write data
                using (Stream postStream = request.GetRequestStream())
                {
                    postStream.Write(byteData, 0, byteData.Length);
                }

                string output = null;

                // Get response
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    // Get the response stream
                    StreamReader reader = new StreamReader(response.GetResponseStream());

                    output = reader.ReadToEnd();
                }

                //not sure what happened here it may be the way my client calls right now but the response is not json
                //it can be also just plain true or false
                bool flag = default(bool);
                if (bool.TryParse(output, out flag))
                {
                    authenticated = flag;
                }
                else
                {

                    if (!string.IsNullOrEmpty(output))
                    {
                        authenticated = GetBooleanValueFromJsonString(output);
                    }
                }

            
            return authenticated;
        }

        public static bool GetBooleanValueFromJsonString(string output)
        {
            bool authenticated = false;
            //we know that we are looking for something that looks like:
            //{d:true} or {d:false}
            string[] strings = output.Split(':');

            if (strings.Length == 2)
            {
                //then we at least have a 2 part json string returned if greater than or less than 2 parts we did not get
                //what we are expecting we should now have 2 parts {d and either true} or false}
                if (strings[1].ToLower().Contains("true"))
                {
                    authenticated = true;
                }
            }
            return authenticated;
        }


    }
}
