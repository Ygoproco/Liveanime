--Magicians Unite (Manga)
--マジシャンズ・クロス
--scripted by Larry126
function c511600005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511600005,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511600005.condition)
	e2:SetTarget(c511600005.target)
	e2:SetOperation(c511600005.operation)
	c:RegisterEffect(e2)
end
function c511600005.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c511600005.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511600005.filter,tp,LOCATION_MZONE,0,2,nil)
end
function c511600005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511600005.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511600005.filter,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c511600005.filter,tp,LOCATION_MZONE,0,2,2,nil,tp)
end
function c511600005.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g1=g:Select(tp,1,1,nil)
	g:Sub(g1)
	local tc1=g1:GetFirst()
	local tc2=g:GetFirst()
	if tc1:IsFacedown() or tc2:IsFacedown() or not tc1:IsRelateToEffect(e) or not tc2:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(3000)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc1:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	tc2:RegisterEffect(e2)
end