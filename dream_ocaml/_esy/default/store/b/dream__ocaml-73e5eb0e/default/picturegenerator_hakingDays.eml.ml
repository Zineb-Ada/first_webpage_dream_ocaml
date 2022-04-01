(* let render param =
  <html>
  <body>
    <h1>The URL parameter was <%s param %>!</h1>
  </body>
  </html>

let () =
  Dream.run 
  @@ Dream.logger
  @@ Dream.router [

    Dream.get "/:word"
      (fun request ->
        Dream.param request "word"
        |> render
        |> Dream.html);

  ] *)

  (* let my_error_template _error debug_info suggested_response =
    let status = Dream.status suggested_response in
    let code = Dream.status_to_int status
    and reason = Dream.status_to_string status in
  
    Dream.set_header suggested_response "Content-Type" Dream.text_html;
    Dream.set_body suggested_response begin
      <html>
      <body>
        <h1><%i code %>  <%s reason %></h1>
        <pre><%s debug_info %></pre>
      </body>
      </html>
    end;
    Lwt.return suggested_response
  
  let () =
    Dream.run ~error_handler:(Dream.error_template my_error_template)
    @@ Dream.logger
    @@ Dream.not_found *)
(* Random.self_init ();;
let randompictures l = List.iter (Random.full_init ["photos"]) "photos" *)
(* let randompicture l = Random.self_init Printf.sprintf "photos" *)
(* let randompicture _error debug_info suggested_response = *)
  (* let status = Dream.status suggested_response in *)
  (* let code = Dream.status_to_int status
  and reason = Dream.status_to_string status in *)
  (* Dream.set_header suggested_response "Content-Type" Dream.photos_html;
  Dream.set_body suggested_response begin *)

Random.self_init
(* let listofpictures message = 
  let folder = [] in 
   *)
let pictures () = Random.int 8
let randompicture message  =
    <html>
    <body>
      <h1>upgrade your mood </h1>
      <img src =  "photos/<%s message %>/<%d pictures () %>.jpg">
      <img src =  "photos/<%s message %>/<%d pictures () %>.jpg">
      <a href="/nextpictures" >Next</a>
    </body>
    </html>

let show_form ?message () =
  <html>
  <body>
%   begin match message with
%   | None -> ()
%   | Some message ->
       <p>You entered: <b><%s message %>!</b></p>
%   end;
    <form  method="GET" action="/pictures">
      <label > <h2> You're down and you want to upgrade your mood ? you're in the place to be: <h2> </label>
        
        <select name= "message">
          <option value="">--Please choose your favorite animal--</option>
          <option value="dog">Dog</option>
          <option value="cat">Cat</option>
          <option value="hamster">Hamster</option>
          <option value="Tarides">Tarides</option>
      </select>
      <br><br>
      <input type="submit" value="have fun">
    </form>
  </body>
  </html>


let () =
  Dream.run 
  @@ Dream.set_secret "foo"
  @@ Dream.logger

  @@ fun request ->

    match Dream.cookie request "message" with
    | Some message ->
      Printf.ksprintf
        Dream.html "Your preferred animal is %s!" (Dream.html_escape message)

    | None ->
      let response = Dream.response "Set animal preference; come again!" in
      Dream.add_header response "Content-Type" Dream.text_html;
      Dream.set_cookie response request "message" "ut-OP";
      Lwt.return response


  @@ Dream.memory_sessions
  @@ Dream.router [

    Dream.get 
    "/photos/**" (Dream.static "./photos");

    Dream.get "/pictures"
      (fun request ->
        match Dream.query request "message" with
        | None ->
          Dream.empty `Bad_Request
        | Some message -> 
          
           v);
    
    Dream.get "/nextpictures"
      (fun request ->
        match Dream.query request "message" with
        | None ->
          Dream.empty `Bad_Request
        | Some message -> Dream.html (randompicture message));
          
    
    Dream.get  "/"
      (fun _ ->
        Dream.html (show_form ()));

    Dream.post "/postform"
      (fun request ->
        match%lwt Dream.form request with
        | `Ok ["message", message] ->
          Dream.html (show_form ~message ())
        | _ ->
          Dream.empty `Bad_Request);
  ]
