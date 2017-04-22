--Seven Swords Warrior (Manga)
function c511015124.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511015124,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_EQUIP)
	e1:SetTarget(c511015124.damtg)
	e1:SetOperation(c511015124.damop)
	c:RegisterEffect(e1)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511015124,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511015124.descon)
	e3:SetTarget(c511015124.destg)
	e3:SetOperation(c511015124.desop)
	c:RegisterEffect(e3)
end
function c511015124.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(700)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c511015124.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end

function c511015124.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsType,1,nil,TYPE_EQUIP)
end
function c511015124.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local n=eg:FilterCount(Card.IsType,nil,TYPE_EQUIP)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)>=n end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE):Select(tp,n,n,nil)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511015124.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end
