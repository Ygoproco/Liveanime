--神の進化
--Divine Evolution
--updated by Larry126
function c513000065.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTarget(c513000065.target)
	e1:SetOperation(c513000065.activate)
	c:RegisterEffect(e1)
	if not c513000065.global_check then
		c513000065.global_check=true
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c513000065.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
function c513000065.chk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,421)==0 and Duel.GetFlagEffect(1-tp,421)==0 then
		Duel.CreateToken(tp,421)
		Duel.CreateToken(1-tp,421)
		Duel.RegisterFlagEffect(tp,421,nil,0,1)
		Duel.RegisterFlagEffect(1-tp,421,nil,0,1)
	end
end
-------------------------------------------------------------------
function c513000065.filter(c)
	return c:IsFaceup() and c:IsHasEffect(513000065) and c:GetFlagEffect(5130000650)==0
end
function c513000065.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000065.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c513000065.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c513000065.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(4010,7))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(513000065)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetCountLimit(1)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetOperation(c513000065.atkup)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local code1,code2=tc:GetOriginalCodeRule()
		if code1==10000000 or code2==10000000 then
			--change name
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			e3:SetCode(EFFECT_CHANGE_CODE)
			e3:SetValue(511600030)
			tc:RegisterEffect(e3)
		end
		tc:RegisterFlagEffect(5130000650,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
end
function c513000065.atkup(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--Atk/Def up
	local e2=Effect.CreateEffect(e:GetOwner())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetValue(1000)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end