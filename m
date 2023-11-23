Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBF7F656D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbjKWRa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbjKWRaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:30:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C578798
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:30:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C1CC433C9;
        Thu, 23 Nov 2023 17:30:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
        (envelope-from <rostedt@goodmis.org>)
        id 1r6DX9-00000003686-1XJT;
        Thu, 23 Nov 2023 12:30:35 -0500
Message-ID: <20231123173035.230352894@goodmis.org>
User-Agent: quilt/0.67
Date:   Thu, 23 Nov 2023 12:25:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 5/5] MAINTAINERS: TRACING: Add Mathieu Desnoyers as Reviewer
References: <20231123172539.582640797@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

In order to make sure I get CC'd on tracing changes for which my input
would be relevant, add my name as reviewer of the TRACING subsystem.

Link: https://lore.kernel.org/linux-trace-kernel/20231115155018.8236-1-mathieu.desnoyers@efficios.com

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af79..a2d4ef4d90f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22078,6 +22078,7 @@ F:	drivers/watchdog/tqmx86_wdt.c
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
-- 
2.42.0


