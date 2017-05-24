--Net Resonator
function c511009513.initial_effect(c)
	--become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c511009513.condition)
	e2:SetOperation(c511009513.operation)
	c:RegisterEffect(e2)
end
function c511009513.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end
function c511009513.operation(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local rc=c:GetReasonCard()
if rc:GetFlagEffect(511009513)==0 then
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511009513,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_ABSOLUTE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetAbsoluteRange(ep,1,0)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c511009513.damval)
	e1:SetLabel(ep)
	rc:RegisterEffect(e1,true)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	rc:RegisterEffect(e2,true)
	rc:RegisterFlagEffect(511009513,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c511009513.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 and e:GetHandler():GetControler()==e:GetLabel() then return 0 end
	return val
end
