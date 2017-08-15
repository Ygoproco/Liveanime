-- Null and Void (Anime)
-- scripted by: UnknownGuest
--fixed by MLD
function c810000055.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c810000055.condition)
	e1:SetTarget(c810000055.target)
	e1:SetOperation(c810000055.activate)
	c:RegisterEffect(e1)
end
function c810000055.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c810000055.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c810000055.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=eg:Filter(Card.IsRelateToEffect,nil,e):Filter(Card.IsControler,nil,1-tp)
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
