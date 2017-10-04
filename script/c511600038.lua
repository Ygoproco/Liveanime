--Magical Dimension (Anime)
function c511600038.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511600038.condition)
	e1:SetCost(c511600038.cost)
	e1:SetTarget(c511600038.target)
	e1:SetOperation(c511600038.activate)
	c:RegisterEffect(e1)
end
function c511600038.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c511600038.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.IsExistingMatchingCard(c511600038.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511600038.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c511600038.filter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511600038.rfilter(c,fid)
	return c:IsReleasableByEffect() and c:GetFieldID()~=fid
end
function c511600038.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local chkcost=e:GetLabel()==1 and true or false
	if chk==0 then
		if chkcost then
			return Duel.CheckReleaseGroup(tp,nil,2,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
				and Duel.IsExistingMatchingCard(c511600038.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		else
			e:SetLabel(0)
			return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511600038.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		end
	end
	e:SetLabel(0)
	if chkcost then
		local g=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
		Duel.Release(g,REASON_COST)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511600038.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.SelectMatchingCard(tp,c511600038.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		tc:RegisterFlagEffect(511600038,RESET_EVENT+0x1fe0000,0,1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetLabelObject(tc)
		e2:SetCondition(c511600038.descon)
		e2:SetOperation(c511600038.desop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511600038.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(511600038)~=0 then
		return true
	else
		e:Reset()
		return false
	end
end
function c511600038.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
end