--Soul Demolition (Anime)
--scripted by GameMaster(GM)
function c511005641.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511005641.con)
    c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511005641,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_BOTH_SIDE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c511005641.tg)
	e2:SetCondition(c511005641.con)
	e2:SetOperation(c511005641.op)
	c:RegisterEffect(e2)
end

function c511005641.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND)
end
function c511005641.rfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end


function c511005641.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511005641.cfilter,tp,LOCATION_MZONE,0,1,nil)
end

function c511005641.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511005641.rfilter,tp,0,LOCATION_GRAVE,1,nil) end
	local oppmonNum = Duel.GetMatchingGroupCount(c511005641.rfilter,tp,0,LOCATION_GRAVE,nil)
	local s1=math.max(oppmonNum,oppmonNum)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511005641.rfilter,tp,0,LOCATION_GRAVE,1,s1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511005641.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	g=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local ct=g:GetCount()*500
Duel.Damage(tp,ct,REASON_EFFECT)
end
