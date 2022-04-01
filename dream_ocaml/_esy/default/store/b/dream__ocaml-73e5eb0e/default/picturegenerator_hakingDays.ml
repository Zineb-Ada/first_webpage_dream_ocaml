#1 "picturegenerator_hakingDays.eml.ml"
(* let render param =
let ___eml_buffer = Buffer.create 4096 in
(Buffer.add_string ___eml_buffer "<html>\n<body>\n  <h1>The URL parameter was ");
(Printf.bprintf ___eml_buffer "%s" (Dream.html_escape (
#4 "picturegenerator_hakingDays.eml.ml"
                                  param 
)));
(Buffer.add_string ___eml_buffer "!</h1>\n</body>\n</html>\n\n");
(Buffer.contents ___eml_buffer)
#8 "picturegenerator_hakingDays.eml.ml"
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
let ___eml_buffer = Buffer.create 4096 in
(Buffer.add_string ___eml_buffer "<html>\n<body>\n  <h1>");
(Printf.bprintf ___eml_buffer "%i" (
#30 "picturegenerator_hakingDays.eml.ml"
                code 
));
(Buffer.add_string ___eml_buffer "  ");
(Printf.bprintf ___eml_buffer "%s" (Dream.html_escape (
#30 "picturegenerator_hakingDays.eml.ml"
                             reason 
)));
(Buffer.add_string ___eml_buffer "</h1>\n  <pre>");
(Printf.bprintf ___eml_buffer "%s" (Dream.html_escape (
#31 "picturegenerator_hakingDays.eml.ml"
                 debug_info 
)));
(Buffer.add_string ___eml_buffer "</pre>\n</body>\n</html>\n");
(Buffer.contents ___eml_buffer)
#34 "picturegenerator_hakingDays.eml.ml"
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
let ___eml_buffer = Buffer.create 4096 in
(Buffer.add_string ___eml_buffer "<html>\n<body>\n  <h1>upgrade your mood </h1>\n  <img src =  \"photos/");
(Printf.bprintf ___eml_buffer "%s" (Dream.html_escape (
#60 "picturegenerator_hakingDays.eml.ml"
                              message 
)));
(Buffer.add_string ___eml_buffer "/");
(Printf.bprintf ___eml_buffer "%d" (
#60 "picturegenerator_hakingDays.eml.ml"
                                             pictures () 
));
(Buffer.add_string ___eml_buffer ".jpg\">\n  <img src =  \"photos/");
(Printf.bprintf ___eml_buffer "%s" (Dream.html_escape (
#61 "picturegenerator_hakingDays.eml.ml"
                              message 
)));
(Buffer.add_string ___eml_buffer "/");
(Printf.bprintf ___eml_buffer "%d" (
#61 "picturegenerator_hakingDays.eml.ml"
                                             pictures () 
));
(Buffer.add_string ___eml_buffer ".jpg\">\n  <a href=\"/nextpictures\" >Next</a>\n</body>\n</html>\n\n");
(Buffer.contents ___eml_buffer)
#66 "picturegenerator_hakingDays.eml.ml"
let show_form ?message () =
let ___eml_buffer = Buffer.create 4096 in
(Buffer.add_string ___eml_buffer "<html>\n<body>\n");
#69 "picturegenerator_hakingDays.eml.ml"
    begin match message with

#70 "picturegenerator_hakingDays.eml.ml"
    | None -> ()

#71 "picturegenerator_hakingDays.eml.ml"
    | Some message ->

(Buffer.add_string ___eml_buffer "       <p>You entered: <b>");
(Printf.bprintf ___eml_buffer "%s" (Dream.html_escape (
#72 "picturegenerator_hakingDays.eml.ml"
                              message 
)));
(Buffer.add_string ___eml_buffer "!</b></p>\n");
#73 "picturegenerator_hakingDays.eml.ml"
    end;

(Buffer.add_string ___eml_buffer "    <form  method=\"GET\" action=\"/pictures\">\n    <label > <h2> You're down and you want to upgrade your mood ? you're in the place to be: <h2> </label>\n      \n      <select name= \"message\">\n        <option value=\"\">--Please choose your favorite animal--</option>\n        <option value=\"dog\">Dog</option>\n        <option value=\"cat\">Cat</option>\n        <option value=\"hamster\">Hamster</option>\n        <option value=\"Tarides\">Tarides</option>\n    </select>\n    <br><br>\n    <input type=\"submit\" value=\"have fun\">\n  </form>\n</body>\n</html>\n\n\n");
(Buffer.contents ___eml_buffer)
#91 "picturegenerator_hakingDays.eml.ml"
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
        | Some message -> Dream.html (randompicture message));
    
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
