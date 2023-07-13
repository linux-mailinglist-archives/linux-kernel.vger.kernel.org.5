Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F24751A77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjGMHzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjGMHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:55:39 -0400
X-Greylist: delayed 489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 00:55:28 PDT
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7489E2113
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:55:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EECF8DE5A3;
        Thu, 13 Jul 2023 09:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1689234435; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=JVx/wMmu2mafrXhkeZJ9fNSWsicdmXECOnuVK0+2598=;
        b=mMD8MnrVy0aqEPXhB+UqtB2KUM+5tY3yiV0+J2y/kcWGucg2ZY/HrT3sbAzp2e4WLd4l0+
        PsyPRLWao0s28B1zeUebjKUtASMp1e/9zZA64wOvgXme5nxSYeZn6IM072RqpPMjxEdNNs
        jK9+kyQ/06ezMcil7dPnby4gTYCJfmHy57Qw2X6eqWM+Hur42M5YwuUangwAoTw7DT5vSy
        Zw7hVTuaObx4eWvyNOuHIopp4Dm/XdxPx1GA0K5+29k9lcElLPMnrI2n6zm60Pe7XAeFPL
        Y9oope3OxIOScSPOxbYWfTyl8XvEjgxeNj/FXZ0b/t5FlgRr++Q0r7GUDs7Kxw==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.288-rt126
Date:   Thu, 13 Jul 2023 09:47:07 +0200
Message-ID: <20230713074707.1188-2-wagi@monom.org>
In-Reply-To: <20230713074707.1188-1-wagi@monom.org>
References: <20230713074707.1188-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.19.288-rt126-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 9d0cfbcac7f4..a44fd6cdf249 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt125
+-rt126
-- 
2.41.0

