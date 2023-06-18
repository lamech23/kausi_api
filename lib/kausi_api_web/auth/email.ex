defmodule KausiApiWeb.Auth.Email do
  import Bamboo.Email
  import Bamboo.MandrillHelper

  def send_email(user) do
    new_email()
    # IO.inspect(new_email())
    # |> template("My Mandrill Template Name")
    |> to(user.email)
    |> from("lamechcruze@gmail.com")
    |> subject("reset password link")
    |> html_body("<p>You are reciving this email because you or someone else has requested the reset of password for your account.\n\n'
    +'please click on the following link bellow or paste this link into your browser to complete this proces within an hour of reciving it :\n\n'
    
     </p>")
    
    |> KausiApiWeb.Auth.Mailer.deliver_now()
  end


  
end
