--Future Battle
function c511000782.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000782.target)
	e1:SetLabel(1)
	c:RegisterEffect(e1)
	--Battle
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(511000782,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511000782.con)
	e2:SetTarget(c511000782.tg)
	e2:SetOperation(c511000782.op)
	c:RegisterEffect(e2)
end
function c511000782.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return c511000782.tg(e,tp,eg,ep,ev,re,r,rp,0,chkc) end
	if c511000782.con(e,tp,eg,ep,ev,re,r,rp) and c511000782.tg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(c511000782.op)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		c511000782.tg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c511000782.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE and Duel.GetTurnPlayer()==tp
end
function c511000782.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsAttackable()
end
function c511000782.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511000782.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000782.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsPlayerCanSpecialSummon(tp) and tc and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and (not tc:IsPublic() or tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK,1-tp)) 
		and e:GetHandler():GetFlagEffect(511000782)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000782.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:GetHandler():RegisterFlagEffect(511000782,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	if tc:IsPublic() and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK,1-tp) then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
	else
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	end
end
function c511000782.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.DisableShuffleCheck()
		Duel.ConfirmDecktop(1-tp,1)
		local g=Duel.GetDecktopGroup(1-tp,1)
		local rc=g:GetFirst()
		if rc:IsType(TYPE_MONSTER) then
			if rc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK,1-tp) and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
				and Duel.SpecialSummon(rc,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)>0 then
				local fid=c:GetFieldID()
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_MUST_ATTACK)
				e1:SetCondition(c511000782.atkcon)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				e1:SetLabelObject(rc)
				tc:RegisterEffect(e1)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
				tc:RegisterEffect(e2)
				tc:RegisterFlagEffect(51100782,RESET_EVENT+0x1fe0000,0,1,fid)
				local e3=e2:Clone()
				e3:SetCondition(aux.TRUE)
				e3:SetCode(EFFECT_MUST_BE_ATTACKED)
				e3:SetValue(c511000782.atkval)
				e3:SetLabel(fid)
				e3:SetLabelObject(tc)
				rc:RegisterEffect(e3)
				local e4=Effect.CreateEffect(e:GetHandler())
				e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
				e4:SetCode(EVENT_LEAVE_FIELD)
				e4:SetOperation(c511000782.regop)
				e4:SetLabel(fid)
				e4:SetLabelObject(e)
				rc:RegisterEffect(e4,true)
				rc:RegisterFlagEffect(51100783,RESET_EVENT+0x1fe0000,0,1,fid)
			end
		else
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
function c511000782.atkcon(e)
	local tc=e:GetLabelObject()
	return tc and c:GetFlagEffectLabel(51100783)==e:GetLabel()
end
function c511000782.atkval(e,c)
	return not c:IsImmuneToEffect(e) and c==e:GetLabelObject() and c:GetFlagEffectLabel(51100782)==e:GetLabel()
end
function c511000782.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_BATTLE) and c:GetReasonCard() and c:GetReasonCard():GetFlagEffectLabel(51100782)==e:GetLabel() then
		if e:GetLabelObject():GetLabel()~=1 then
			e:GetLabelObject():SetCountLimit(1)
		end
		e:GetOwner():ResetFlagEffect(511000782)
	end
	e:Reset()
end
