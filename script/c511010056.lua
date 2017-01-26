--No.56 ゴールドラット (Anime)
function c511010056.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,3)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55935416,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG2_XMDETACH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c511010056.drcost)
	e1:SetTarget(c511010056.drtg)
	e1:SetOperation(c511010056.drop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511010056.indes)
	c:RegisterEffect(e2)
	if not c511010056.global_check then
		c511010056.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511010056.numchk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511010056.xyz_number=56
function c511010056.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010056.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511010056.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local ct=Duel.Draw(p,d,REASON_EFFECT)
	if ct~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
function c511010056.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,55935416)
	Duel.CreateToken(1-tp,55935416)
end
function c511010056.indes(e,c)
	return not c:IsSetCard(0x48)
end