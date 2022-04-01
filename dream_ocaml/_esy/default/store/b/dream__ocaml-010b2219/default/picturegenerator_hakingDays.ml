#1 "picturegenerator_hakingDays.eml.ml"
Random.self_init
let dir_contents dir =
  let rec loop result = function
    | f::fs when Sys.is_directory f ->
          Sys.readdir f
          |> Array.to_list
          |> List.filter (fun filename -> if filename = ".DS_Store" then false else true)
          |> List.map (Filename.concat f)
          |> List.append fs
          |> loop result
    | f::fs -> loop (f::result) fs
    | []    -> result
  in
    loop [] [dir]

let pictures message = 
  let lengthfolders = List.length  (dir_contents ("photos/"^message)) in
  Printf.printf("%d \n%!") lengthfolders;
  Random.int (lengthfolders) 
  let randompicture message  =
let ___eml_buffer = Buffer.create 4096 in
(Buffer.add_string ___eml_buffer "<html>\n<body >\n  <h1 style=\"text-align: center;\">upgrade your mood </h1>\n    <br>\n    <img src=\"photos/");
(Printf.bprintf ___eml_buffer "%s" (Dream.html_escape (
#25 "picturegenerator_hakingDays.eml.ml"
                             message 
)));
(Buffer.add_string ___eml_buffer "/");
(Printf.bprintf ___eml_buffer "%d" (
#25 "picturegenerator_hakingDays.eml.ml"
                                            pictures message 
));
(Buffer.add_string ___eml_buffer ".jpg\" alt=\"Image\" style=\"border-color: #849460;border-radius: 10px;\n    width:600px;height:500px;margin-left: 390\">\n    <br><br>\n\n  <form  method=\"GET\" action=\"/pictures\">\n    <input type=\"submit\" action=\"/pictures\" value=\"Next\" style=\"background-color:pink; border-color: #849460; border-style:solid;\n    width:150px;height:30px;margin-left: 620;border-radius: 10px\">\n  </form>\n</body>\n</html>\n\n");
(Buffer.contents ___eml_buffer)
#36 "picturegenerator_hakingDays.eml.ml"
let show_form ?message () =
let ___eml_buffer = Buffer.create 4096 in
(Buffer.add_string ___eml_buffer "<html>\n<body style=\"background-image:url(photos/ocamllogo.jpg);\">\n");
#39 "picturegenerator_hakingDays.eml.ml"
    begin match message with

#40 "picturegenerator_hakingDays.eml.ml"
    | None -> ()

#41 "picturegenerator_hakingDays.eml.ml"
    | Some message ->

(Buffer.add_string ___eml_buffer "       <p>You entered: <b>");
(Printf.bprintf ___eml_buffer "%s" (Dream.html_escape (
#42 "picturegenerator_hakingDays.eml.ml"
                              message 
)));
(Buffer.add_string ___eml_buffer "!</b></p>\n");
#43 "picturegenerator_hakingDays.eml.ml"
    end;

(Buffer.add_string ___eml_buffer "    <form  method=\"GET\" action=\"/pictures\">\n    <label > <h2 style=\"border-color: #849460;border-radius: 10px;text-align:center; margin-top:40px\" > You're down and you want to upgrade your mood ? you're in the place to be: <h2> </label>\n      <br><br>\n      <select name= \"message\" style=\"border-color: #849460;border-radius: 10px;margin-left: 590;width:300px;height:50px;\">\n        <option value=\"\">--Please choose your favorite animal--</option>\n        <option value=\"dog\">Dogs</option>\n        <option value=\"cat\">Cats</option>\n        <option value=\"hamster\">Hamsters</option>\n    </select>\n    <br><br>\n    <input type=\"submit\" value=\"have fun with\" style=\"background-color:pink; border-color: #849460; border-style:solid;\n    width:150px;height:30px;margin-left: 670;border-radius: 10px; margin-top:30px\">\n  </form>\n</body>\n</html>\n\n\n");
(Buffer.contents ___eml_buffer)
#61 "picturegenerator_hakingDays.eml.ml"
let () =
  Dream.run 
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router [

    Dream.get 
    "/photos/**" (Dream.static "./photos");

    Dream.get "/pictures"
      (fun request ->
        match Dream.query request "message" with
        | None ->
          (match Dream.cookie request "animal" with
          | Some message ->
            Dream.html (randompicture message)
          | None ->
            Dream.empty `Bad_Request)
        | Some message -> 
          let%lwt response = Dream.html (randompicture message) in
          Dream.set_cookie response request "animal" message;
          Lwt.return response);
    
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
