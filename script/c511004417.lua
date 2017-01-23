--Acrobat Tower
function c511004417.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCost(c511004417.cost)
	e1:SetCondition(c511004417.condition)
	e1:SetTarget(c511004417.target)
	e1:SetOperation(c511004417.operation)
	c:RegisterEffect(e1)
end
function c511004417.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9f) and c:IsReleasable()
end
function c511004417.cost(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004417.costfilter,tp,LOCATION_MZONE,0,1,nil) end
	local tg=Duel.SelectMatchingCard(tp,c511004417.costfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Release(tg,REASON_COST)
end
function c511004417.condition(e,tp,eg,ev,ep,re,r,rp)
	return tp~=rp
end
function c511004417.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and Duel.IsPlayerCanDraw(1-tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,0,0,PLAYER_ALL,2)
end
function c511004417.operation(e,tp,eg,ev,ep,re,r,rp)
	if not Duel.IsPlayerCanDraw(tp,2) or not Duel.IsPlayerCanDraw(1-tp,2) then return end
	local g1=Group.CreateGroup()
	local g2=Group.CreateGroup()
	local loss=false
	while (not g1:IsExists(Card.IsType,1,nil,TYPE_MONSTER) or not g2:IsExists(Card.IsType,1,nil,TYPE_MONSTER)) and not loss do
		local s1=Duel.GetDecktopGroup(tp,2)
		local s2=Duel.GetDecktopGroup(1-tp,2)
		if not g1:IsExists(Card.IsType,1,nil,TYPE_MONSTER) then
			g1:Merge(s1)
			if s1:GetCount()<2 then loss=true end
			Duel.Draw(tp,2,REASON_EFFECT)
		end
		if not g2:IsExists(Card.IsType,1,nil,TYPE_MONSTER) then
			g2:Merge(s2)
			if s2:GetCount()<2 then loss=true end
			Duel.Draw(1-tp,2,REASON_EFFECT)
		end
	end
	Duel.ConfirmCards(1-tp,g1)
	Duel.ConfirmCards(tp,g2)
	if loss then return end
	Duel.SendtoGrave(g1,REASON_EFFECT)
	Duel.SendtoGrave(g2,REASON_EFFECT)
	local lv1=0
	local lv2=0
	local dam=Duel.GetMatchingGroupCount(Card.GetControler,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,nil)*200
	local chkc1=g1:GetFirst()
	while chkc1 do
		if chkc1:IsType(TYPE_MONSTER) then
			lv1=lv1+chkc1:GetLevel()
		end
		chkc1=g1:GetNext()
	end
	local chkc2=g2:GetFirst()
	while chkc2 do
		if chkc2:IsType(TYPE_MONSTER) then
			lv2=lv2+chkc2:GetLevel()
		end
		chkc2=g2:GetNext()
	end
	if lv1>=lv2 then
		Duel.Damage(tp,dam,REASON_EFFECT)
	else
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end