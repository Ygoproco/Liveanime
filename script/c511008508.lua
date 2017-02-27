--Castle Gate (Anime)
-- [Monster / Effect]
-- [Warrior:Earth 6* 0/2400]
function c511008508.initial_effect(c)
	
	--[Effect e1] battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--[Effect e2] damage to player
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511008508,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c511008508.cost)
	e2:SetTarget(c511008508.target)
	e2:SetOperation(c511008508.operation)
	c:RegisterEffect(e2)
end

----- ########## < Effect e2 > ########## -----

function c511008508.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsFaceup,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,Card.IsFaceup,1,1,nil)
	e:SetLabel(sg:GetFirst():GetAttack())
	Duel.Release(sg,REASON_COST)
end
function c511008508.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c511008508.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end

----- ########## < / Effect e2 > ########## -----