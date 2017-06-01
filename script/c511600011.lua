--Palladium Oracle Mahad (Anime)
--Scripted by Larry126
function c511600011.initial_effect(c)
--special summon
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(71703785,0))
	e0:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e0:SetCode(EVENT_PREDRAW)
	e0:SetRange(LOCATION_HAND)
	e0:SetCondition(c511600011.spcon2)
	e0:SetCost(c511600011.spcost)
	e0:SetTarget(c511600011.sptg1)
	e0:SetOperation(c511600011.spop1)
	c:RegisterEffect(e0) 
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71703785,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_DRAW)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511600011.spcon1)
	e1:SetCost(c511600011.spcost)
	e1:SetTarget(c511600011.sptg1)
	e1:SetOperation(c511600011.spop1)
	c:RegisterEffect(e1)   
--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetCondition(c511600011.atkcon)
	e2:SetValue(c511600011.atkval)
	c:RegisterEffect(e2) 
end
function c511600011.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c511600011.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function c511600011.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c511600011.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511600011.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
function c511600011.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	local bc=e:GetHandler():GetBattleTarget()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and bc and bc:IsAttribute(ATTRIBUTE_DARK)
end
function c511600011.atkval(e,c)
	return e:GetHandler():GetAttack()*2
end