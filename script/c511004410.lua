--Flower of Destruction
function c511004410.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511004410.cos)
	c:RegisterEffect(e1)
	--special summoned = damage + atkchange
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511004410.dacon)
	e2:SetTarget(c511004410.datg)
	e2:SetOperation(c511004410.daop)
	c:RegisterEffect(e2)
	--sb
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511004410.mtcon)
	e3:SetOperation(c511004410.mtop)
	c:RegisterEffect(e3)
end
function c511004410.cosfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and c:IsFaceup()
end
function c511004410.cos(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004410.cosfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local tg=Duel.SelectMatchingCard(tp,c511004410.cosfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SendtoGrave(tg,REASON_COST)
end
function c511004410.filterloli(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c511004410.dacon(e,tp,eg,ev,ep,re,r,rp)
	return eg and eg:IsExists(c511004410.filterloli,1,nil,tp)
end
function c511004410.dafilter1(c)
	return c:IsType(TYPE_MONSTER) and c:GetAttack()<c:GetTextAttack()
end
function c511004410.dafilter2(c)
	return c:IsType(TYPE_MONSTER)
end
function c511004410.datg(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004410.dafilter1,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingTarget(c511004410.dafilter2,1-tp,LOCATION_MZONE,0,1,nil) end
	local tg1=Duel.SelectTarget(tp,c511004410.dafilter1,tp,LOCATION_MZONE,0,1,1,nil)
	local tg2=Duel.SelectTarget(tp,c511004410.dafilter2,1-tp,LOCATION_MZONE,0,1,1,nil)
	Group.Merge(tg1,tg2)
	Duel.SetTargetCard(tg1)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,tg2,1,0,0)
end
function c511004410.daop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg1=tg:Filter(Card.IsControler,nil,tp):GetFirst()
	local tg2=tg:Filter(Card.IsControler,nil,1-tp):GetFirst()
	if tg1 then
		local dam=tg1:GetTextAttack()-tg1:GetAttack()
		if dam<0 then dam=-dam end
		if Duel.Damage(1-tp,dam,REASON_EFFECT)~=0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-dam)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tg2:RegisterEffect(e1)
		end
	end
end
function c511004410.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511004410.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c511004410.cosfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) and Duel.SelectYesNo(tp,aux.Stringid(123456789,3)) then
		Duel.SendtoGrave(Duel.SelectMatchingCard(tp,c511004410.cosfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler()),REASON_COST)
	else
		Duel.Damage(tp,1000,REASON_COST)
	end
end