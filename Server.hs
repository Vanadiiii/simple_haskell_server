import Network.Socket
import System.IO

main :: IO ()                                    
main = do                                        
  sock <- socket AF_INET Stream 0                
  bind sock (SockAddrInet 4000 0)                
  listen sock 2                                  
  putStrLn "Listening on port 4000..."           

  loopForever sock                               

loopForever :: Socket -> IO ()                   
loopForever sock = do                            
  (conn, _) <- accept sock                       
  handleSock <- socketToHandle conn ReadWriteMode

  line <- hGetLine handleSock                    
  putStrLn $ "Request received: " ++ line        

  hPutStrLn handleSock $ "Hey, client!"          
  hClose handleSock                              
  loopForever sock

