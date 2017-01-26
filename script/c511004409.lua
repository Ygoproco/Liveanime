--Fruit of Destruction
function c511004409.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511004409.cos)
	c:RegisterEffect(e1)
	--sp
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511004409.spcon)
	e2:SetTarget(c511004409.sptg)
	e2:SetOperation(c511004409.spop)
	c:RegisterEffect(e2)
	--sb
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511004409.mtcon)
	e3:SetOperation(c511004409.mtop)
	c:RegisterEffect(e3)
end
function c511004409.cosfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and c:IsFaceup()
end
function c511004409.cos(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004409.cosfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local tg=Duel.SelectMatchingCard(tp,c511004409.cosfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SendtoGrave(tg,REASON_COST)
end
function c511004409.spconfilter(c,e,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and (bit.band(c:GetPreviousTypeOnField(),TYPE_MONSTER)==TYPE_MONSTER) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT)
end
function c511004409.spcon(e,tp,eg,ev,ep,re,r,rp)
	return eg:IsExists(c511004409.spconfilter,1,nil,e,tp)
end
function c511004409.spfilter1(c,e,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and (bit.band(c:GetPreviousTypeOnField(),TYPE_MONSTER)==TYPE_MONSTER) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT) and c:IsCanBeSpecialSummoned(e,tp,SUMMON_TYPE_SPECIAL,false,true)
end
function c511004409.spfilter2(c)
	return c:IsType(TYPE_MONSTER) and c:GetAttack()>=3000
end
function c511004409.sptg(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and eg:IsExists(c511004409.spfilter1,1,nil,e,tp) and Duel.IsExistingMatchingCard(c511004409.spfilter2,tp,LOCATION_MZONE,0,1,nil) end
	local tg=eg:FilterSelect(tp,c511004409.spfilter1,1,1,nil,e,tp):GetFirst()
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,1,0,0)
end
function c511004409.spop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(c511004409.spfilter2,tp,LOCATION_MZONE,0,1,nil) then return end
	local red=Duel.SelectMatchingCard(tp,c511004409.spfilter2,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	local tg=Duel.GetFirstTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-3000)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	red:RegisterEffect(e1)
	Duel.SpecialSummon(tg,SUMMON_TYPE_SPECIAL,tp,tp,false,true,POS_FACEUP)
end
function c511004409.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511004409.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c511004409.cosfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) and Duel.SelectYesNo(tp,aux.Stringid(123456789,3)) then
		Duel.SendtoGrave(Duel.SelectMatchingCard(tp,c511004409.cosfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler()),REASON_COST)
	else
		Duel.Damage(tp,3000,REASON_COST)
	end
end