Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C4775A474
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGTChO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTChM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:37:12 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ECC2103
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:37:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5xfX0jsNzBRDrS
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:37:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689820626; x=1692412627; bh=yDmsFZdUx//T+d2JUdth5wQgh+t
        umS2t3JK5YxYiAHE=; b=qSpU6VthrVdb9qW4+QsmcSiiQzF9QghP5HAeAoVFqWO
        IoG/9YQTEz2pHqNzsFqvEqGDZ0rhmzD2sIOKvqSF8n3DVGYKzauCzuQyWxVyD+mu
        4YLQKAELvB2IRIfd1aLL9d0skfqJSk6s0/3zC2cYzarh+TktO+u0Y3P3w+sh52mA
        wYL15kKER00jN0NXeFlsDasLRh8loXUMcmMtW2jCtXXmJGrS/9vtBv6KBTvulLg+
        UVh6Jv6gPCb21xipvd5oKiSDlPEvv//ESlJIgtTUjdMZ4+9ZNr7CUiw98fdbKv7K
        zyFHcbBqLHt8aL2hCF6ywjr4wo3J369DGrtQ+Lw5f9g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m8wdPqKpXV1z for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 10:37:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5xfV1fZKzBJDhY;
        Thu, 20 Jul 2023 10:37:06 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 10:37:06 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] dvb-frontends: add missing spaces before ','
In-Reply-To: <20230720023552.1070-1-xujianghui@cdjrlc.com>
References: <20230720023552.1070-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9bf6cfcbeb9a0854fdb2a29d74885725@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
