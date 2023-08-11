Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB67792CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbjHKPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjHKPTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:19:21 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F730F6;
        Fri, 11 Aug 2023 08:19:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4ABB5DB01F;
        Fri, 11 Aug 2023 17:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1691767149; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=pUgCMrEnKngrJxmw46rroynEm/3fnaUWpWkwTH6+zuc=;
        b=Es8+ojckoL2SVzDugv3tD/rv3cUkfKH8TZwtglvVvpJ4k8OVK/ZhuMtdrbsU+h01SYYlGN
        QVCWQFQEfC3bWrNJhIzQS9oSo7WFKinKR9J3aR9T9PzsQRM3y00vqD5Dj55dJ9P5JeRzUL
        0xBh9t/kJZ+/obNJqkItEDJhNgtIn4xYbtdYlGRuFRUSRyPKi8NF1hhxpR2HX1cNkJDVpm
        JGoOvLu8YHm6SOk/I/uEdVinl6Y6SuBZ/pYIIqWIIseGJG4A73q5IH6OJYNTeQnacgGrQU
        +ddG54ZztGJYJQnjZ95vArP6Jp+6FuLbWZcJRPo4XpPYBou5Db9ydoCIlB36Ow==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.291-rt127-rc1
Date:   Fri, 11 Aug 2023 17:19:04 +0200
Message-ID: <20230811151904.16196-2-wagi@monom.org>
In-Reply-To: <20230811151904.16196-1-wagi@monom.org>
References: <20230811151904.16196-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.19.291-rt127-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index a44fd6cdf249..51ede3d1e767 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt126
+-rt127-rc1
-- 
2.41.0

