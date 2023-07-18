Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BFF7581EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGRQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGRQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:19:18 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FCF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:19:15 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R53zx5tHKzBR1P1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:19:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689697148; x=1692289149; bh=AogzKomP66K0/uB9YNT7xIqu11y
        FWvafad30597sScs=; b=PhKnUY408RdOsjwOtfnkCliB1GEe56MMtuvAxHE1gEP
        GYoBtJBRsoSkug8g1zugzVZ1nMQJaq+9fyp+xsAn/1zICfFAbTi0bamKm1APqLee
        lTxDAF+nHvJH7PUWoyX+MOLYgqIonmQwsP/H9jSCvA1p5uI+m2vF+Zc8ATLZ5MqZ
        9ofC0x9LPEtdjWsqqwBtth1sQ04qfiOrHk3U9Je0vlptq1PFaCXv1gfXtrqz6/Og
        CW1GzX6KFZXNUbHHFl52pweBaaSsMPL78MmyiH+3JVBhJa+TPri2wg2oeVGmRWYg
        K4wY62TVkLGIdUrYrpzfn04Nrw7fHVDx4jOb2bPkiXw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EcV5aKToLqkV for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 00:19:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R53zw5qNWzBQskk;
        Wed, 19 Jul 2023 00:19:08 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:19:08 +0800
From:   pangzizhen001@208suo.com
To:     kvalo@kernel.org, gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi/mvm: Fix typos in comments
In-Reply-To: <20230718161711.61222-1-wangjianli@cdjrlc.com>
References: <20230718161711.61222-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7d3a7075b8bf9af194c56c74eeaaefb7@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
  drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c 
b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index a5b432bc9e2f..4745cba25391 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -31,7 +31,7 @@ u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def 
*chandef)

  /*
   * Maps the driver specific control channel position (relative to the 
center
- * freq) definitions to the the fw values
+ * freq) definitions to the fw values
   */
  u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef)
  {
