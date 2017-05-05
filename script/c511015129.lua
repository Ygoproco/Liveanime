--Number 72: Line Monster Chariot Hisha
function c511015129.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c511015129.indes)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(698785,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG2_XMDETACH)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511015129.cost)
	e2:SetTarget(c511015129.target)
	e2:SetOperation(c511015129.operation)
	c:RegisterEffect(e2)
end
function c511015129.indes(e,c)
	return not c:IsSetCard(0x48)
end

function c511015129.filter(c,seq,flag)
	return c:GetSequence()==4-seq or (flag~=0 and c:IsLocation(LOCATION_MZONE) and (c:GetSequence()==4-seq+1 or c:GetSequence()==4-seq-1))
end
function c511015129.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511015129.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local flag=e:GetHandler():GetFlagEffect(511015130)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015129.filter,tp,0,LOCATION_ONFIELD,1,nil,e:GetHandler():GetSequence(),flag) end
	local g=Duel.GetMatchingGroup(c511015129.filter,tp,0,LOCATION_ONFIELD,nil,e:GetHandler():GetSequence(),flag)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511015129.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511015129.filter,tp,0,LOCATION_ONFIELD,nil,e:GetHandler():GetSequence(),e:GetHandler():GetFlagEffect(511015130))
	Duel.Destroy(g,REASON_EFFECT)
end