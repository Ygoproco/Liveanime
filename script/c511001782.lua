--パワー・ピカクス
function c511001782.initial_effect(c)
	aux.AddEquipProcedure(c)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90246973,0))
	e3:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c511001782.rmtg)
	e3:SetOperation(c511001782.rmop)
	c:RegisterEffect(e3)
end
function c511001782.rmfilter(c,lv)
	return c:IsLevelBelow(lv) and c:IsAbleToRemove()
end
function c511001782.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ec=e:GetHandler():GetEquipTarget()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c511001782.rmfilter(chkc,ec:GetLevel()) end
	if chk==0 then return Duel.IsExistingTarget(c511001782.rmfilter,tp,0,LOCATION_GRAVE,1,nil,ec:GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511001782.rmfilter,tp,0,LOCATION_GRAVE,1,1,nil,ec:GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511001782.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ec=c:GetEquipTarget()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 then
		local atk=tc:GetTextAttack()/2
		if atk<=0 then return end
		--Atk up
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetCondition(c511001782.atcon)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		e1:SetValue(atk)
		c:RegisterEffect(e1)
	end
end
function c511001782.atcon(e)
	local ec=e:GetHandler():GetEquipTarget()
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and Duel.GetAttackTarget() 
		and (ec==Duel.GetAttacker() or Duel.GetAttackTarget()==ec)
end
