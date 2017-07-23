--Fake Trap (DOR)
--scripted by GameMaster (GM)
function c511005650.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511005650.condition)
	e1:SetTarget(c511005650.target)
	e1:SetOperation(c511005650.activate)
	c:RegisterEffect(e1)
end


function c511005650.condition(e,tp,eg,ep,ev,re,r,rp)
   return re:IsHasType(EFFECT_TYPE_ACTIVATE,18144506) and re:GetHandler():GetCode()==18144506  and Duel.IsChainNegatable(ev) 
end
	 
function c511005650.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end

function c511005650.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end

 
 
 