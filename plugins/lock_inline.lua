do
local function pre_process(msg)

    local inline = 'mate:'..msg.to.id
    if msg.text == '[unsupported]' and redis:get(inline) and not is_momod(msg) then
            delete_msg(msg.id, ok_cb, true)
end
    return msg
    end
    
 local function lock_inline(msg, matches)
if is_momod(msg) and matches[1] == "lock" and matches[2] == "inline" then
local inline = 'mate:'..msg.to.id
redis:set(inline, true)
return "تبلیغات شیشه ای و هایپر لینک قفل شد توسط :\n @"..(msg.from.username or "--")
end
if is_momod(msg) and matches[1] == "unlock" and matches[2] == "inline" then
    local inline = 'mate:'..msg.to.id
    redis:del(inline)
    return "قفل تبلیغات شیشه ای و هایپر لینک غیرفعال شد توسط\n @"..(msg.from.username or "--")
  end
end
return {
    patterns ={
        '^[/!#](lock) (inline)$',
        '^[/!#](unlock) (inline)$',
    },
run = lock_inline,
pre_process = pre_process 
}
end