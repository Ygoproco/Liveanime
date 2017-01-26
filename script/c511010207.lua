--Number C107: Neo Galaxy-Eyes Tachyon Dragon (Anime)
--CNo.107 超銀河眼の時空龍 (Anime)
--Scripted By TheOnePharaoh
function c511010207.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,3)
	c:EnableReviveLimit()
	--Rank Up Check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511010207.rankupregcon)
	e1:SetOperation(c511010207.rankupregop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511010207,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c511010207.negcost)
	e2:SetOperation(c511010207.negop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511010207.indes)
	c:RegisterEffect(e3)
	if not c511010207.global_check then
		c511010207.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(c511010207.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE+PHASE_DRAW)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511010207.check2op)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge3:SetOperation(c511010207.numchk)
		Duel.RegisterEffect(ge3,0)
	end
end
c511010207.xyz_number=107
function c511010207.checkop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rc then
	rc:RegisterFlagEffect(511010207,RESET_PHASE+PHASE_END,0,1,1)
	end
end
function c511010207.check2op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0x1e+LOCATION_DECK+LOCATION_EXTRA+LOCATION_REMOVED,0x1e+LOCATION_DECK+LOCATION_EXTRA+LOCATION_REMOVED,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			tc:RegisterFlagEffect(511010208,RESET_PHASE+PHASE_END,0,1,tc:GetLocation())
			tc:RegisterFlagEffect(511010209,RESET_PHASE+PHASE_END,0,1,tc:GetControler())
			tc:RegisterFlagEffect(511010210,RESET_PHASE+PHASE_END,0,1,tc:GetPosition())
			tc:RegisterFlagEffect(511010211,RESET_PHASE+PHASE_END,0,1,tc:GetSequence())
			tc=g:GetNext()
		end
	end
end
function c511010207.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010207.filter(c)
	return c:IsFaceup() and (c:IsLocation(LOCATION_SZONE) or c:IsType(TYPE_EFFECT)) and not c:IsDisabled()
end
function c511010207.retfilter(c,tid)
	return c:GetFlagEffect(511010207)>0
end
function c511010207.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local gn=Duel.GetMatchingGroup(c511010207.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	local tcn=gn:GetFirst()
	while tcn do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tcn:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tcn:RegisterEffect(e2)
		tcn=gn:GetNext()
	end
	local g=Duel.GetMatchingGroup(c511010207.retfilter,tp,0x1e+LOCATION_DECK+LOCATION_EXTRA+LOCATION_REMOVED,0x1e+LOCATION_DECK+LOCATION_EXTRA+LOCATION_REMOVED,e:GetHandler())
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			if tc:GetFlagEffectLabel(511010208)==LOCATION_HAND then
				Duel.SendtoHand(g,tc:GetFlagEffectLabel(511010209),REASON_EFFECT)
			elseif tc:GetFlagEffectLabel(511010208)==LOCATION_GRAVE then
				Duel.SendtoGrave(tc,REASON_EFFECT,tc:GetFlagEffectLabel(511010209))
			elseif tc:GetFlagEffectLabel(511010208)==LOCATION_REMOVED then
				Duel.Remove(tc,tc:GetPreviousPosition(),REASON_EFFECT,tc:GetFlagEffectLabel(511010209))
			elseif tc:GetFlagEffectLabel(511010208)==LOCATION_DECK then
				Duel.SendtoDeck(tc,tc:GetFlagEffectLabel(511010209),0,REASON_EFFECT)
			elseif tc:GetFlagEffectLabel(511010208)==LOCATION_EXTRA then
				Duel.SendtoDeck(tc,tc:GetFlagEffectLabel(511010209),0,REASON_EFFECT)
			else
				Duel.MoveToField(tc,tc:GetFlagEffectLabel(511010209),tc:GetFlagEffectLabel(511010209),tc:GetFlagEffectLabel(511010208),tc:GetFlagEffectLabel(511010210),true)
				Duel.MoveSequence(tc,tc:GetFlagEffectLabel(511010211))
			end
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
			tc=g:GetNext()
		end
	end
	Duel.BreakEffect()
	local ct=Duel.GetMatchingGroupCount(Card.IsOnField,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if ct>0 and Duel.SelectYesNo(tp,551) then 
		local ga=Duel.SelectMatchingCard(tp,Card.IsOnField,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0,ct,nil)
		local tca=ga:GetFirst()
		while tca do
			tca:RegisterFlagEffect(511010212,RESET_PHASE+PHASE_END,0,1)
			tca=ga:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(0,1)
		e1:SetValue(c511010207.aclimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511010207.aclimit(e,c,sg,re,tp)
	return c:GetHandler():IsOnField() and not c:GetHandler():IsImmuneToEffect(e) and c:GetHandler():GetFlagEffect(511010212)==0
end

function c511010207.rumfilter(c)
	return c:IsCode(88177324) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511010207.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511010207.rumfilter,1,nil)
end
function c511010207.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010207,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511010207.atkcon)
	e1:SetCost(c511010207.atkcost)
	e1:SetTarget(c511010207.atktg)
	e1:SetOperation(c511010207.atkop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511010207.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c511010207.rfilter(c)
	return c:GetAttackAnnouncedCount()<=0
end
function c511010207.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511010207.rfilter,2,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,c511010207.rfilter,2,2,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c511010207.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEffectCount(EFFECT_EXTRA_ATTACK)==0 end
end
function c511010207.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

function c511010207.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,68396121)
	Duel.CreateToken(1-tp,68396121)
end
function c511010207.indes(e,c)
	return not c:IsSetCard(0x48)
end
