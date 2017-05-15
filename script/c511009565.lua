--Performage Reversal Dancer
--fixed by MLD
function c511009565.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(511001762)
	e2:SetRange(LOCATION_PZONE)
	e2:SetLabel(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511009565.con)
	e2:SetTarget(c511009565.tg)
	e2:SetOperation(c511009565.op)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetLabel(LOCATION_MZONE)
	e3:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e3)
	if not c511009565.global_check then
		c511009565.global_check=true
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511009565.atkchk)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511009565.con(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	if eg:GetCount()~=1 then return false end
	local val=0
	if ec:GetFlagEffect(284)>0 then val=ec:GetFlagEffectLabel(284) end
	return ec:IsControler(1-tp) and ec:GetAttack()~=val
end
function c511009565.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xc6)
end
function c511009565.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009565.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009565.filter,tp,LOCATION_MZONE,0,1,nil) end
	local ec=eg:GetFirst()
	local atk=0
	local val=0
	if ec:GetFlagEffect(284)>0 then val=ec:GetFlagEffectLabel(284) end
	if ec:GetAttack()>val then atk=ec:GetAttack()-val
	else atk=val-ec:GetAttack() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009565.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetParam(atk)
end
function c511009565.op(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if e:GetLabel()==LOCATION_PZONE and not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c511009565.atkchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,419)==0 and Duel.GetFlagEffect(1-tp,419)==0 then
		Duel.CreateToken(tp,419)
		Duel.CreateToken(1-tp,419)
		Duel.RegisterFlagEffect(tp,419,nil,0,1)
		Duel.RegisterFlagEffect(1-tp,419,nil,0,1)
	end
end
