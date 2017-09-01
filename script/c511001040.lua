--ドラゴン族・封印の壺
function c511001040.initial_effect(c)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511001040.remop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511001040.con)
	e2:SetOperation(c511001040.op)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e2:Clone()
	e5:SetCode(EVENT_CHANGE_POS)
	c:RegisterEffect(e5)
	local e6=e2:Clone()
	e6:SetCode(EVENT_CHAIN_SOLVED)
	c:RegisterEffect(e6)
	--def
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_UPDATE_DEFENSE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(c511001040.defval)
	c:RegisterEffect(e7)
end
function c511001040.cfilter(c)
	return c:GetFlagEffect(511001040)>0
end
function c511001040.con(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c511001040.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c511001040.filter(c,e,tid)
	if not c:IsRace(RACE_DRAGON) or c:IsFacedown() or c:IsImmuneToEffect(e) then return false end
	return c:GetFlagEffect(511001040)==0
end
function c511001040.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(511001040)==0 then
		c:RegisterFlagEffect(511001040,RESET_EVENT+0x1ff0000,0,0)
	end
	if not c:IsDisabled() and c:IsFaceup() then
		local g=Duel.GetMatchingGroup(c511001040.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler(),e,e:GetHandler():GetFieldID())
		if g:GetCount()>0 then
			Duel.Overlay(c,g)
		end
	else
		local og=c:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
	end
end
function c511001040.remop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsDisabled() and c:IsFacedown() then
		local og=c:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
	end
end
function c511001040.defval(e,c)
	local g=c:GetOverlayGroup()
	if not g or g:GetCount()<=0 then return 0 end
	local def=0
	local tc=g:GetFirst()
	while tc do
		local tdef=tc:GetDefense()
		if tdef<0 then tdef=0 end
		def=def+tdef
		tc=g:GetNext()
	end
	return def
end
