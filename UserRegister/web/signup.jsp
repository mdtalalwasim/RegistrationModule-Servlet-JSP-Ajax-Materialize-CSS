<%-- 
    Document   : userSignup
    Created on : Oct 4, 2022, 8:54:35 PM
    Author     : Md. Talal Wasim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>


    </head>
    <body style="background:url(img/registerBackgorund.png); background-size: cover">
        <div class="container">



            <div class="row">
                <div class="col m6 offset-m3">
                    <div class="card">
                        <div class="card-content">
                            <h3 style="margin-top:10px;" class="center-align">Register here!!</h3>
                            <h5 id="msg" class="center-align"></h5>

                            <div class="form center-align">

                                <form action="Register" method="post" id="myform">

                                    <input type="text" name="user_name" placeholder="Enter name here"/>
                                    <input type="password" name="user_password" placeholder="Enter password here"/>
                                    <input type="email" name="user_email" placeholder="Enter email here"/>

                                    <div class="file-field input-field">
                                        <div class="btn">
                                            <span>File</span>
                                            <input name="image" type="file">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text">
                                        </div>
                                    </div>


                                    <button type="submit" class="btn" style="margin-top: 10px;" >Submit</button>

                                </form>

                            </div>

                            <div class="loader center-align " style="margin-top: 10px; display: none;"  >

                                <div class="preloader-wrapper big active">
                                    <div class="spinner-layer spinner-blue">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-red">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-yellow">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-green">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>
                                </div>

                                <h5>Please wait...</h5>

                            </div>


                        </div>


                    </div>

                </div>

            </div>

        </div>


        <script
            src="https://code.jquery.com/jquery-3.6.1.min.js"
            integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
            crossorigin="anonymous">

        </script>
        <script>
            $(document).ready(function () {
                console.log("page is ready...");
            });


            /**
             * Start...
             * ajax is asynchronous js
             * usgin Ajax...the below steps will happens.
             * using ajax--without reloading the current webpage...
             * request sent to the backend and backend sent response as well...&
             * all the data sent to the Database.
             * 
             * */


            //start.....
            $("#myform").on('submit', function (event) {

                //by default behavior of form will prevented
                //means form will not go to any other page... 
                event.preventDefault();

                /**
                 * //get all value of the forms
                 * //serialize() => whole forms will converted
                 * //in string with key, value pair => name, "user inputed name"
                 */


                /**
                 * if your form has only simple data like String type data
                 * then serialize() can be used... but if your form has other data type 
                 * like audio, video, file, image etc... 
                 * then you can not used serialize();
                 * solution:
                 * we have create an object of FormData() and pass the whole form through it
                 * FormData() using this;
                 * var or let formsValue=new FormData(this);
                 * */

                //var formsValues = $(this).serialize();
                let formsValues = new FormData(this);//"this" means full form.
                console.log(formsValues);



                //loading/loader activity...
                $(".loader").show();//showing loading before the request sent...
                $(".form").hide();// when loader start form will hide.


                $.ajax({//user data insterted request or ajax request which is sending request to backend

                    url: "Register", //url="where_you_want_to_send_forms_data"
                    data: formsValues,
                    type: 'POST',
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        console.log("Success...!");
                        
                        // if success...
                        //loading/loader activity...
                        $(".loader").hide();//if request is success then loading/loader will hide...
                        $(".form").show();// and form will show again...


                        //if get done from servlet...
                        if (data.trim() === 'done') {
                            $('#msg').html("Successfully Registered!");
                            $('#msg').addClass('green-text');
                        } else {

                            $('#msg').html("Something went wrong on server...!!");
                            $('#msg').addClass('red-text');
                            console.log("I am in else block!");
                        }
                        //end get done...

                  
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(data);
                        console.log("Error...!");

                        //if error occured 
                        //loading/loader activity...
                        $(".loader").hide();//if get any error when request sent to 
                        //backend then loading/loader will hide...
                        $(".form").show();// and form will show again...

                        //if get error!
                        $('#msg').html("Something went wrong on server...!!");
                        $('#msg').addClass('red-text');
                        console.log("I am in error");

                    },
                    
                    //the above all code enough for simple forms / simple string type value,
                    //for image, audio,video, file, types form value we need to write below code as well
                    //just below 2 lines for others types of data[for image of data in form]
                    processData: false,
                    contentType: false 
                     
                    
                });



            });
            //end.....

            /**
             * End...
             * ajax is asynchronous js
             * usgin Ajax...the below steps will happens.
             * using ajax--without reloading the current webpage...
             * request sent to the backend and backend sent response as well...&
             * all the data sent to the Database.
             * 
             * */

        </script>
    </body>
</html>
