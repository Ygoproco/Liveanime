--Electrode Beast Anion
-- [Monster / Effect]
-- [Thunder:Light 2* 300/300]
function c511008506.initial_effect(c)

	-- [Effect e1, e2 and e3] If this card is removed of field, draw 1 card.
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511008506,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511008506.condition)
	e1:SetTarget(c511008506.target)
	e1:SetOperation(c511008506.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e3)
end

---------- ################# < Effect e1|e2|e3 > ################# ----------

function c511008506.condition(e,tp,eg,ep,ev,re,r,rp)
	-- Condition: the previous location of this card, its the field.
	local thisCard = e:GetHandler()
	return thisCard:IsPreviousLocation(LOCATION_ONFIELD) and eg:IsExists(c511008506.filterPreviousLocation, 1, thisCard)
end
function c511008506.target(e,tp,eg,ep,ev,re,r,rp,chk)
	-- Target
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511008506.operation(e,tp,eg,ep,ev,re,r,rp)
	-- Operation: Draw 1 card
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end


function c511008506.filterPreviousLocation(c)
	-- Filter: Card is 'Electrode Beast Cation, and its previous location is field
	return c:IsCode(511008507) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
---------- ################# < /Effect e1|e2|e3 > ################# ----------