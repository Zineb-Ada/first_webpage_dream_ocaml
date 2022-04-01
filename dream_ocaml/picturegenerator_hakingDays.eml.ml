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
    <html>
    <body >
      <h1 style="text-align: center;">upgrade your mood </h1>
        <br>
        <img src="photos/<%s message %>/<%d pictures message %>.jpg" alt="Image" style="border-color: #849460;border-radius: 10px;
        width:600px;height:500px;margin-left: 390">
        <br><br>

      <form  method="GET" action="/pictures">
        <input type="submit" action="/pictures" value="Next" style="background-color:pink; border-color: #849460; border-style:solid;
        width:150px;height:30px;margin-left: 620;border-radius: 10px">
      </form>
    </body>
    </html>

let show_form ?message () =
  <html>
  <body style="background-image:url(photos/ocamllogo.jpg);">
%   begin match message with
%   | None -> ()
%   | Some message ->
       <p>You entered: <b><%s message %>!</b></p>
%   end;
    <form  method="GET" action="/pictures">
      <label > <h2 style="border-color: #849460;border-radius: 10px;text-align:center; margin-top:40px" > You're down and you want to upgrade your mood ? you're in the place to be: <h2> </label>
        <br><br>
        <select name= "message" style="border-color: #849460;border-radius: 10px;margin-left: 590;width:300px;height:50px;">
          <option value="">--Please choose your favorite animal--</option>
          <option value="dog">Dogs</option>
          <option value="cat">Cats</option>
          <option value="hamster">Hamsters</option>
      </select>
      <br><br>
      <input type="submit" value="have fun with" style="background-color:pink; border-color: #849460; border-style:solid;
      width:150px;height:30px;margin-left: 670;border-radius: 10px; margin-top:30px">
    </form>
  </body>
  </html>


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
