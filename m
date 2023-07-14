Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176E75351F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjGNIgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjGNIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:36:38 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E173A7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:36:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2Pw25qlkzBR9sk
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:36:34 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689323794; x=1691915795; bh=yDmsFZdUx//T+d2JUdth5wQgh+t
        umS2t3JK5YxYiAHE=; b=tdzQpImzGDHTgnf1eoApsCYwHJxGnOMFkLkq3aCnP5D
        GnCSWNcoDzBWzKHICyzivhTxE6Rl1e8ptQlWwfNwe89UKD3wpnjz2mgBlztypPhz
        ZMf+ecVtns8wdO1/Qym8RNBejmaLm/KJ+rmhTXw8gUyH9Pgj3GLmPrkR3+HzxfOc
        rv0ehCrgPqH1bmn+YHuxCFAfBxZlb+snLAcwashqkfCA4HB/ixufwDGTXBD+JUsV
        ip97LR8lfT/wGVWYUmTZKqcEw0Lggqs4ic1eymZEB27BPJmQchvofao2zzp7+EhO
        8KEzBBceXldRR2vq74khVAU2J5Hvq4yQ+gXs/2CKwfg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ekef7IhS7_h1 for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 16:36:34 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2Pw24H0jzBR9sg;
        Fri, 14 Jul 2023 16:36:34 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 16:36:34 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] dvb-frontends: add missing spaces before ','
In-Reply-To: <20230714083530.14582-1-xujianghui@cdjrlc.com>
References: <20230714083530.14582-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <92cefa11c3b11e1fcc60196671c62afb@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/media/dvb-frontends/dib3000mc.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib3000mc.h 
b/drivers/media/dvb-frontends/dib3000mc.h
index 5ed3d9147f8b..b837e107881e 100644
--- a/drivers/media/dvb-frontends/dib3000mc.h
+++ b/drivers/media/dvb-frontends/dib3000mc.h
@@ -73,7 +73,7 @@ struct i2c_adapter 
*dib3000mc_get_tuner_i2c_master(struct dvb_frontend *demod,
  }
  #endif // CONFIG_DVB_DIB3000MC

-extern int dib3000mc_pid_control(struct dvb_frontend *fe, int index, 
int pid,int onoff);
+extern int dib3000mc_pid_control(struct dvb_frontend *fe, int index, 
int pid, int onoff);
  extern int dib3000mc_pid_parse(struct dvb_frontend *fe, int onoff);

  extern void dib3000mc_set_config(struct dvb_frontend *, struct 
dib3000mc_config *);
