--Numbers Overlay Boost (Anime)
--Scripted by IanxWaifu
function c511024008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511024008.target)
	e1:SetOperation(c511024008.activate)
	c:RegisterEffect(e1)
end
function c511024008.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and c:GetOverlayCount()==0
end
function c511024008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingMatchingCard(c511024008.filter,tp,LOCATION_MZONE,0,1,nil) 
			and Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,nil,TYPE_MONSTER) end
end
function c511024008.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511024008.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local g=Duel.GetMatchingGroup(nil,tp,LOCATION_HAND,0,nil,TYPE_MONSTER)
		if g:GetCount()>0 then
			local og=g:Select(tp,1,2,nil)
			Duel.Overlay(tc,og)
		end
	end
end
