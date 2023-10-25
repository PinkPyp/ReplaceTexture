-- To identify a runtime server-side, name the NewTXD "runtime", and NewTXN as the image link, then include the Width and Height as shown below

Config = {
  Replaces = {
    --Platform Texture Replaces w/ runtime 
    --{OldTXD="platform:/textures/skydome",OldTXN="starfield",NewTXD="runtime",NewTXN='https://media4.giphy.com/media/l0HlBaC5Kp9cXZDTa/giphy-downsized-large.gif', Width=512, Height=512},
    
    --Player Clothing Texture Replaces w/ runtime 
    --{OldTXD="mp_m_freemode_01/jbib_diff_000_a_uni",OldTXN="jbib_diff_000_a_uni",NewTXD="runtime",NewTXN='https://media4.giphy.com/media/l0HlBaC5Kp9cXZDTa/giphy-downsized-large.gif', Width=512, Height=512},
    
    --Common Texture Replaces w/ streamed textures
    --{OldTXD="vehshare",OldTXN="yankton_plate",NewTXD="newvehshare",NewTXN='plate09'},
  }
}