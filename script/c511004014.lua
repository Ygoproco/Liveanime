--Battle City
--Scripted by Edo9300
function c511004014.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(0xff)
	e1:SetCondition(c511004014.con)
	e1:SetOperation(c511004014.op)
	c:RegisterEffect(e1)
	--Double Tribute
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetTarget(function(e,c)return c:GetSummonLocation()==LOCATION_EXTRA and c:GetMaterialCount()==2 end)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Triple Tribute
	local e2a=Effect.CreateEffect(c)
	e2a:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2a:SetType(EFFECT_TYPE_FIELD)
	e2a:SetRange(LOCATION_REMOVED)
	e2a:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2a:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2a:SetTarget(function(e,c)return c:GetSummonLocation()==LOCATION_EXTRA and c:GetMaterialCount()>=3 end)
	e2a:SetValue(1)
	c:RegisterEffect(e2a)
	--faceup def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetCode(EFFECT_DEVINE_LIGHT)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetTargetRange(1,1)
	c:RegisterEffect(e3)
	--summon with 3 tribute
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e4:SetRange(LOCATION_REMOVED)
	e4:SetTargetRange(0xff,0xff)
	e4:SetTarget(function(e,c)return c:GetLevel()>=10 and c:GetFlagEffect(511004015)==1 end)
	e4:SetCondition(c511004014.ttcon)
	e4:SetOperation(c511004014.ttop)
	e4:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetTarget(function(e,c)return c:GetLevel()>=10 and c:GetFlagEffect(511004017)==1 end)
	e5:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e5)
	--Cannot Attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CANNOT_ATTACK)
	e6:SetRange(LOCATION_REMOVED)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)	
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetTarget(function(e,c)return c:IsStatus(STATUS_SPSUMMON_TURN) and c:GetFlagEffect(511004016)==0 end)
	c:RegisterEffect(e6)
	--Quick
	local e7=Effect.CreateEffect(c)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_BECOME_QUICK)
	e7:SetRange(LOCATION_REMOVED)
	e7:SetTargetRange(0xff,0xff)
	e7:SetCondition(function(e)return Duel.GetCurrentPhase()>=0x08 and Duel.GetCurrentPhase()<=0x80 end)
	c:RegisterEffect(e7)
	--Negate
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)	
	e8:SetCode(EVENT_CHAIN_SOLVING)
	e8:SetRange(LOCATION_REMOVED)
	e8:SetOperation(c511004014.negop)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EVENT_DESTROYED)
	e9:SetOperation(c511004014.negop2)
	c:RegisterEffect(e9)
	--To controler's grave
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e10:SetRange(LOCATION_REMOVED)
	e10:SetCode(EVENT_ADJUST)
	e10:SetOperation(c511004014.gvop)
	c:RegisterEffect(e10)
	--Attack
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e11:SetRange(LOCATION_REMOVED)
	e11:SetCode(EVENT_LEAVE_FIELD)
	e11:SetCondition(function(e,tp)ph=Duel.GetCurrentPhase()return ph>=PHASE_BATTLE_STEP and ph<PHASE_DAMAGE and Duel.GetAttackTarget()~=nil and not Duel.GetAttackTarget():IsReason(REASON_BATTLE)end)
	e11:SetOperation(function()Duel.NegateAttack()end)
	c:RegisterEffect(e11)
	local e11a=e11:Clone()
	e11a:SetCode(EVENT_BE_MATERIAL)
	c:RegisterEffect(e11a)
end
function c511004014.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetTributeCount(c)>=3
end
function c511004014.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511004014.con(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end
function c511004014.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,511004014) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND and Duel.IsPlayerCanDraw(e:GetHandlerPlayer(),1)then
		Duel.Draw(tp,1,REASON_RULE)
	end
	local g=Duel.GetMatchingGroup(aux.NOT(Card.IsHasEffect),tp,0xff,0xff,nil,EFFECT_LIMIT_SUMMON_PROC)
	local g2=Duel.GetMatchingGroup(aux.NOT(Card.IsHasEffect),tp,0xff,0xff,nil,EFFECT_LIMIT_SET_PROC)
	local tc=g:GetFirst()
	if tc then
		while tc do
			tc:RegisterFlagEffect(511004015,0,0,1)
			tc=g:GetNext()
		end
	end
	local tc2=g2:GetFirst()
	if tc2 then
		while tc2 do
			tc2:RegisterFlagEffect(511004017,0,0,1)
			tc2=g2:GetNext()
		end
	end
end
function c511004014.negop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():GetFlagEffect(511000173)>0 and re:IsActiveType(TYPE_TRAP+TYPE_SPELL) then
		Duel.NegateEffect(ev)
	end
end
function c511004014.negop2(e,tp,eg,ep,ev,re,r,rp)
	if eg:GetCount()==0 then return false end
	local tc=eg:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511000173,0,RESET_CHAIN,1)
		tc=eg:GetNext()
	end
end
function c511004014.gvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(function(c)return c:GetFlagEffect(511004014)==0 end,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_SEND_REPLACE)
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetTarget(c511004014.reptg)
			e1:SetOperation(c511004014.repop)
			e1:SetCondition(c511004014.repcon)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511004014,0,0,1)
			tc=g:GetNext()
		end
	end
end
function c511004014.repcon(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	return c:GetControler()~=c:GetOwner()
end
function c511004014.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetDestination()==LOCATION_GRAVE and c:GetFlagEffect(511004014)>0 and c:IsLocation(LOCATION_ONFIELD) end
	return true
end
function c511004014.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:ResetFlagEffect(511004014)
	if bit.band(r,REASON_DESTROY)~=0 then
		c:RegisterFlagEffect(511000173,RESET_CHAIN,0,1)
	end
	Duel.SendtoGrave(e:GetHandler(),r,e:GetHandler():GetControler())
end
function c511004014.repval(e,c)
	return c:GetControler()~=c:GetOwner() and c:GetPreviousLocation()==LOCATION_ONFIELD and c:GetDestination()==LOCATION_GRAVE
end
