--Indiora Doom Volt the Cubic Emperor (Movie)
function c511004434.initial_effect(c)
	local g=Group.CreateGroup()
	g:KeepAlive()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1)
	e1:SetCondition(c511004434.condition)
	e1:SetTarget(c511004434.target)
	e1:SetOperation(c511004434.operation)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c511004434.target0)
	e2:SetOperation(c511004434.operation0)
	c:RegisterEffect(e2)
	--atk update
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_BASE_ATTACK)
	e3:SetValue(function (e) return 800*e:GetHandler():GetOverlayGroup():FilterCount(Card.IsType,nil,TYPE_MONSTER) end)
	c:RegisterEffect(e3)
	--return instead
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROY)
	e4:SetTarget(c511004434.target1)
	e4:SetOperation(c511004434.operation1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetOperation(c511004434.op)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
end
function c511004434.condition(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511004434.filter(c,sc)
	return c:IsType(TYPE_MONSTER) and (c:IsSetCard(0x10e3) or c:IsCode(15610297)) and c:IsCanBeXyzMaterial(sc)
end
function c511004434.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004434.filter,tp,LOCATION_MZONE,0,3,nil,e:GetHandler()) and e:GetHandler():IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) end
	local tg=Duel.SelectMatchingCard(tp,c511004434.filter,tp,LOCATION_MZONE,0,3,3,nil,e:GetHandler())
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511004434.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg and tg:GetCount()>0 then
		local mg=tg:Clone()
		local tc=tg:GetFirst()
		while tc do
			if tc:GetOverlayCount()~=0 then Duel.SendtoGrave(tc:GetOverlayGroup(),REASON_RULE) end
			tc=tg:GetNext()
		end
		c:SetMaterial(mg)
		Duel.Overlay(c,mg)
		Duel.SpecialSummon(c,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)
	end
end
function c511004434.target0(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,800)
end
function c511004434.operation0(e,tp,eg,ev,ep,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end
function c511004434.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) and c:IsType(TYPE_MONSTER) and (c:IsSetCard(0x10e3) or c:IsCode(15610297))
end
function c511004434.target1(e,tp,eg,ev,ep,re,r,rp,chk)
	local c=e:GetHandler()
	local mg=e:GetLabelObject()   
	if mg then
		mg=mg:Filter(c511004434.spfilter,nil,e,tp)
	end
	if chk==0 then return c:IsAbleToHand() and mg and mg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>mg:GetCount() 
		and not (Duel.IsPlayerAffectedByEffect(tp,59822133) and mg:GetCount()>1) end
	Duel.SetTargetCard(mg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,mg,mg:GetCount(),0,0)
end
function c511004434.operation1(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local mg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local count=mg:GetCount()
	mg=mg:Filter(c511004434.spfilter,nil,e,tp)
	if mg:GetCount()<count then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<mg:GetCount() or (Duel.IsPlayerAffectedByEffect(tp,59822133) and mg:GetCount()>1) then return end
	Duel.SendtoHand(c,nil,REASON_EFFECT)
	Duel.SpecialSummon(mg,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)
end
function c511004434.op(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetOverlayGroup()
	if g:GetCount()==0 then return end
	g:KeepAlive()
	e:GetLabelObject():SetLabelObject(g)
end
