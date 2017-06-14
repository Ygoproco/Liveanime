--マグネッツ２号 a.k.a M-Warrior 2 (DOR)
--by Pratama
function c511004344.initial_effect(c)
	--flip effect, atk & def update of all "M-Warrior 1" currently on the field by 500 points.
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e2:SetOperation(c511004344.operation)
	c:RegisterEffect(e2)
end
function c511004344.atktg(e,c)
	return c:GetFieldID()<=e:GetLabel() and (c:IsCode(56342351) or c:GetOriginalCode()==511005632)
end
function c511004344.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
		local mg,fid=g:GetMaxGroup(Card.GetFieldID)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(c511004344.atktg)
		e1:SetValue(500)
		e1:SetLabel(fid)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		--Cloning value UPDATE ATK to DEF
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end

--Cards Effect (DOR) based on PS2 Game:
--When this card is flipped face-up, all "M-Warrior 1" atk & def increased by 500 points.
