--Light Barrier (ANIME)
--scripted by GameMaster(GM)
function c511005633.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetCondition(c511005633.coincon)
e1:SetTarget(c511005633.cointg)
e1:SetOperation(c511005633.coinop)
c:RegisterEffect(e1)
--flip coin to determin active or not
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(73206827,0))
e2:SetCategory(CATEGORY_COIN)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
e2:SetRange(LOCATION_FZONE)
e2:SetCountLimit(1)
e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
e2:SetCondition(c511005633.coincon)
e2:SetTarget(c511005633.cointg)
e2:SetOperation(c511005633.coinop)
c:RegisterEffect(e2)
--coin adjust
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetCode(73206827)
e3:SetRange(LOCATION_FZONE)
e3:SetTargetRange(LOCATION_MZONE,0)
e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5))
e3:SetCondition(c511005633.effectcon)
c:RegisterEffect(e3)
--recover
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(73206827,1))
e4:SetCategory(CATEGORY_RECOVER)
e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e4:SetRange(LOCATION_FZONE)
e4:SetCode(EVENT_BATTLE_DESTROYING)
e4:SetTarget(c511005633.rectg)
e4:SetOperation(c511005633.recop)
e4:SetCondition(c511005633.reccon)
c:RegisterEffect(e4)
--disable
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetCode(EFFECT_DISABLE)
e5:SetRange(LOCATION_FZONE)
e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
e5:SetTarget(c511005633.tg5)
e5:SetCondition(c511005633.con5)
c:RegisterEffect(e5)
--recover
local e6=Effect.CreateEffect(c)
e6:SetDescription(aux.Stringid(73206827,1))
e6:SetCategory(CATEGORY_RECOVER)
e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e6:SetRange(LOCATION_FZONE)
e6:SetCode(EVENT_BATTLE_DESTROYING)
e6:SetTarget(c511005633.rectg2)
e6:SetOperation(c511005633.recop2)
e6:SetCondition(c511005633.reccon2)
c:RegisterEffect(e6)
--disable
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_FIELD)
e7:SetCode(EFFECT_DISABLE)
e7:SetRange(LOCATION_FZONE)
e7:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
e7:SetTarget(c511005633.tg5)
e7:SetCondition(c511005633.effectcon)
c:RegisterEffect(e7)
end

--e2
function c511005633.coincon(e,tp,eg,ep,ev,re,r,rp)
return tp==Duel.GetTurnPlayer()
end

function c511005633.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end



function c511005633.coinop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if not c:IsRelateToEffect(e) then return end
c:ResetFlagEffect(511005633)--reset coin flip description
local res=0
res=Duel.TossCoin(tp,1) 
c:RegisterFlagEffect(511005633,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,res,63-res)-- set hint to the coin flip
if res==0 then
	c:RegisterFlagEffect(73206828,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,2)
	  end
end




--e3
function c511005633.effectcon(e)
local c=e:GetHandler()
return c:GetFlagEffect(73206828)==0 or c:IsHasEffect(EFFECT_CANNOT_DISABLE)
end

--e4
function c511005633.reccon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local rc=eg:GetFirst()
return rc:IsRelateToBattle()  and rc:IsFaceup() and rc:IsControler(tp) and c:GetFlagEffect(73206828)==0
end


function c511005633.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local tc=eg:GetFirst():GetBattleTarget()
local atk=tc:GetBaseAttack()
if atk<0 then atk=0 end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(atk)
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end

function c511005633.recop(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Recover(p,d,REASON_EFFECT)
end


--e5
function c511005633.tg5(e,c)
return c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x5)
end

function c511005633.con5(e)
local c=e:GetHandler()
return e:GetHandler():GetFlagEffectLabel(73206828)==1
end

--e6

function c511005633.reccon2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local rc=eg:GetFirst()
return rc:IsRelateToBattle()  and rc:IsFaceup() and rc:IsControler(1-tp) and c:GetFlagEffect(73206828)==0
end	


function c511005633.rectg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local tc=eg:GetFirst():GetBattleTarget()
local atk=tc:GetBaseAttack()
if atk<0 then atk=0 end
Duel.SetTargetPlayer(1-tp)
Duel.SetTargetParam(atk)
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,atk)
end

function c511005633.recop2(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Recover(p,d,REASON_EFFECT)
end

