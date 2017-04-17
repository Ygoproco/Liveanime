--Sealer Formation
--  By Shad3/ fixed for errors by GameMaster

local scard=c511005067

function scard.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --Add/Draw
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
  e2:SetCode(EVENT_PREDRAW)
  e2:SetRange(LOCATION_SZONE)
  e2:SetCondition(scard.cd)
  e2:SetOperation(scard.op)
  c:RegisterEffect(e2)
  --Global const
  if not scard.global_check then
    scard.global_check=true
    local ge2=Effect.CreateEffect(c)
    ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    ge2:SetCode(EVENT_ADJUST)
    ge2:SetCountLimit(1)
    ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
    ge2:SetOperation(scard.archchk)
    Duel.RegisterEffect(ge2,0)
  end
end

function scard.archchk(e,tp,eg,ep,ev,re,r,rp)
  if Duel.GetFlagEffect(0,420)==0 then 
    Duel.CreateToken(tp,420)
    Duel.CreateToken(1-tp,420)
    Duel.RegisterFlagEffect(0,420,0,0,0)
  end
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
  return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and Duel.GetDrawCount(tp)>0 and Duel.IsExistingMatchingCard(scard.fil,tp,LOCATION_GRAVE,0,1,nil)
end

function scard.fil(c)
  return c420.IsSeal(c) and c:IsAbleToHand()
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
   if Duel.GetDrawCount(tp)>0 and Duel.IsExistingMatchingCard(scard.fil,tp,LOCATION_GRAVE,0,1,nil)  then
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_DRAW_COUNT)
    e1:SetTargetRange(1,0)
    e1:SetReset(RESET_PHASE+PHASE_DRAW)
    e1:SetValue(0)
    Duel.RegisterEffect(e1,tp)
    local g=Duel.SelectMatchingCard(tp,scard.fil,tp,LOCATION_GRAVE,0,1,1,nil)
    if g:GetCount()>0 then Duel.SendtoHand(g,tp,REASON_EFFECT+REASON_REVEAL) end
  end
end
