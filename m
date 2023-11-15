Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00847EC798
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjKOPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjKOPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:49:57 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D619E;
        Wed, 15 Nov 2023 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700063394;
        bh=h8BeeUtryFB1IFOqZ1UsvXGcEOQuYKR5x0QNoI3HzV4=;
        h=From:To:Cc:Subject:Date:From;
        b=kXyZKvl03+gDeKUqdSSKeziCsZXarIM/oeb49dEkBTgRQB5eMYpSZ3STaUVqhFFb8
         +9FBDZoBK6fea9UnN7vp9RpaRmFzRHaVfiaqN0LWupVauhLpao0/Sac4vj2cP9ye4E
         eH4npy5YpuD31XAUD1d1nuhnVhk3EXjQ29l4JvRomuOyrUw7eo3zQsopcrgknVu4pj
         84Akuu6Fa9CcfRMw0BU8CNHoJBCWm5Fh2YImWSUQWpgz8eaqc+2seK7Cf77EBcu3/d
         SdU7QWHhI5IK/eFpSCMn2XAg/xHGJYJhqF1Ng1IVJ6ooxh2khhs09tBbKTdGdv3yQA
         qJWXpapjhKnPQ==
Received: from thinkos.internal.efficios.com (unknown [12.186.190.1])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SVnfn5vqHz1cYv;
        Wed, 15 Nov 2023 10:49:53 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: TRACING: Add Mathieu Desnoyers as Reviewer
Date:   Wed, 15 Nov 2023 10:50:18 -0500
Message-Id: <20231115155018.8236-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make sure I get CC'd on tracing changes for which my input
would be relevant, add my name as reviewer of the TRACING subsystem.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cc6bf79fdd8..a7c2092d0063 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21622,6 +21622,7 @@ F:	drivers/hwmon/pmbus/tps546d24.c
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
-- 
2.39.2

