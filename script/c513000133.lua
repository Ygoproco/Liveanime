--Anit the Ray
--Scripted by Keddy
function c513000133.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4004,2))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c513000133.target)
	e1:SetOperation(c513000133.operation)
	c:RegisterEffect(e1)
	if not c513000133.global_check then
		c513000133.global_check=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_UPDATE_ATTACK)
		ge1:SetValue(c513000133.eff)
		ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		ge1:SetTarget(aux.TargetBoolFunction(c513000133.effcon))
		Duel.RegisterEffect(ge1,0)
	end
end
function c513000133.filter(c,e,tp)
	return (c:IsSetCard(0x216) or c:IsCode(52085072) or c:IsCode(42364257) or c:IsCode(59839761) or c:IsCode(511001326)) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000133.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK) and c513000133.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000133.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c513000133.cfilter(c,tc)
	return c:IsFaceup() and (c:IsSetCard(0x216) or c:IsCode(52085072)) and c~=tc
end
function c513000133.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c513000133.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if g:GetCount()==0 then return end
	local mg=Duel.GetMatchingGroup(c513000133.cfilter,tp,LOCATION_MZONE,0,tc,c)
	local xg=c:GetOverlayGroup()
	if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	if xg:GetCount()~=0 then Duel.SendtoGrave(xg,REASON_EFFECT) end
	if mg:GetCount()>0 then
		mg:AddCard(c)
		Duel.Overlay(tc,mg)
	else
		c:CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
function c513000133.eff(e,c)
	if c:GetFlagEffect(513000133)==0 then 
		--Disable
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(4004,3))
		e1:SetCategory(CATEGORY_NEGATE+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
		e1:SetType(EFFECT_TYPE_QUICK_O)
		e1:SetCode(EVENT_FREE_CHAIN)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c513000133.discon)
		e1:SetCost(c513000133.discost)
		e1:SetOperation(c513000133.disop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1,true)
		c:RegisterFlagEffect(513000133,RESET_EVENT+0x1fe0000,0,1)
		if not c:IsType(TYPE_EFFECT) then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_ADD_TYPE)
			e2:SetValue(TYPE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e2,true)
		end
		return 0
	end
end
function c513000133.effcon(c)
	return c:GetOverlayGroup():IsExists(Card.IsCode,1,nil,513000133)
end
function c513000133.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c513000133.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetOverlayGroup():FilterCount(Card.IsCode,nil,513000133)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local g=c:GetOverlayGroup():FilterSelect(tp,Card.IsCode,1,1,nil,513000133)
--	local oc=g:GetFirst():GetOverlayTarget()
	Duel.SendtoGrave(g,REASON_EFFECT)
--	Duel.RaiseSingleEvent(oc,EVENT_DETACH_MATERIAL,e,0,0,0,0)
end
function c513000133.gfilter(c)
	return c:IsFaceup() and not c:IsDisabled()
end
function c513000133.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c513000133.gfilter,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do 
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	local g2=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	local stc=g2:GetFirst()
	while stc do
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_ATTACK_FINAL)
		e3:SetValue(function (e,c) return c:GetBaseAttack() end)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		stc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e4:SetValue(function (e,c) return c:GetBaseDefense() end)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		stc:RegisterEffect(e4)
		stc=g2:GetNext()
	end
end