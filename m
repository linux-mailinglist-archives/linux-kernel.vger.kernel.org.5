Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539AE7AD11B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjIYHJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjIYHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:09:21 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895F8BC;
        Mon, 25 Sep 2023 00:09:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F429E1AB2;
        Mon, 25 Sep 2023 09:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1695625753; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=JkYjCs7ILpiJtOXzQu2HrCn6MowdDRKuBZyqH6Tx4Mw=;
        b=MOBvtkUKGumst0ndMJmwb708TBqUbag1ByY3R1lwi5G1oxLCiUNr5E+IH6RWmBJ+vAaPEj
        3TE9IB93dtaotNumnpFk4xAYH0+roGqIMTSJCr9SHSGXIyBCWV3kXVdkhVY9FMuIiUa9iL
        3/VLDIvQERjfuYBnN85hATTvme64z4WP9O2Y9EOFMzgqHXCjg2EGzSVwa6/C0DIVaTFuMn
        aTStNhLyyENtpjkQgbFnI/VUwtRXB5k8THnm31EBQJa8Cu6SDJBScvQujcv09g2BIXyY/5
        +wBaEzEYQ5tS7/Rq+sVbHnGa89udy0a+SFjoa3mODMT9NXfKUd9pV0BJh5uxrQ==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.295-rt129
Date:   Mon, 25 Sep 2023 09:09:06 +0200
Message-ID: <20230925070906.20584-2-wagi@monom.org>
In-Reply-To: <20230925070906.20584-1-wagi@monom.org>
References: <20230925070906.20584-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.19.295-rt129-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 6d2a676e2033..90303f5aabcf 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt128
+-rt129
-- 
2.41.0

