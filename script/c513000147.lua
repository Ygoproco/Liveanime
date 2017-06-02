--Speed Spell - The End of the Storm (Anime)
--Ｓｐ－ジ・エンド・オブ・ストーム
--scripted by Larry126
function c513000147.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c513000147.con)
	e1:SetTarget(c513000147.target)
	e1:SetOperation(c513000147.activate)
	c:RegisterEffect(e1)
end
function c513000147.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>9
end
function c513000147.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,0,g:GetCount()*300)
end
function c513000147.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local ct1=Duel.Destroy(g1,REASON_EFFECT)
	local ct2=Duel.Destroy(g2,REASON_EFFECT)
	Duel.Damage(tp,ct1*300,REASON_EFFECT)
	Duel.Damage(1-tp,ct2*300,REASON_EFFECT)
end