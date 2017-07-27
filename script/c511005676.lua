--Gyakutenno Megami (DOR)
--scripted by GameMaster (GM)
function c511005676.initial_effect(c)
--Monster with 1000ATK or lower gain atk/def 1000
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c511005676.operation)
	c:RegisterEffect(e1)
end

function c511005676.atktg(e,c)
return Duel.GetMatchingGroup(c511005676.filter,tp,LOCATION_MZONE,0,nil)
end

function c511005676.filter(c)
    return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:GetAttack()<=1000)
  end
  
function c511005676.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511005676.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetTarget(c511005676.atktg)
		e1:SetValue(1000)
		tc:RegisterEffect(e1) 
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2) 
		tc=g:GetNext()
	end
end
