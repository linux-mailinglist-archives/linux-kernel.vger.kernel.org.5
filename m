Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B647E2094
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjKFL60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjKFL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:58:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066EC94;
        Mon,  6 Nov 2023 03:58:18 -0800 (PST)
Date:   Mon, 06 Nov 2023 11:58:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699271897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Df9J214P8Zz/oGO9QrDdGXEMmj4NrRZS6MYKXAvIxCc=;
        b=M1kghMMEkrl+K+UtS7CV8LZdbVZFYP+qnp5SDw60+zbXKl2DJq6Yu6dNw9M2J0jWFIO4EP
        zZfxAp9bXxToG7daTUcl8AJZIq14aTLpMuecIQiRrDCJJl27B50O5rVG40HS2t1E7T+cG1
        p9xLkC6bRNKbPWCcsYwi6qQ8MUSJEqBctcqbs80Tn1VRu30fCpC5omNi5DRI+wGZPHmTO4
        RJ3SPeMN7cpKjHvVNSP57GTmcg/jwVUobXPF5UWyGSElVeli9U11+OejqEgOi9wcx7zD/E
        Wc0/2wwwolPAwjNXYSLfrLhxk1qGxgaATqhaxBMd8jgciMXrnj5XcwCJGvYlzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699271897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Df9J214P8Zz/oGO9QrDdGXEMmj4NrRZS6MYKXAvIxCc=;
        b=8GEYy3ZAQlQUp4WOpr3BpHEhGgZ0drOnhm1lm+La67VYnpFcfhglpNB+oSK9/Rlt4r4JYA
        dwx0gs8XxJxq88Cg==
From:   "tip-bot2 for Bagas Sanjaya" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Documentation: Indent 'note::' directive for
 protocol version number note
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231106101206.76487-2-bagasdotme@gmail.com>
References: <20231106101206.76487-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Message-ID: <169927189613.3135.13352646601079651163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     18216762bcf618c52b85719d3563243f80e4a2d4
Gitweb:        https://git.kernel.org/tip/18216762bcf618c52b85719d3563243f80e4a2d4
Author:        Bagas Sanjaya <bagasdotme@gmail.com>
AuthorDate:    Mon, 06 Nov 2023 17:12:04 +07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 06 Nov 2023 12:53:57 +01:00

x86/Documentation: Indent 'note::' directive for protocol version number note

The protocol version number note is between the protocol version table and
the memory layout section. As such, Sphinx renders the note directive not
only on the actual note, but until the end of doc.

Indent the directive so that only the actual protocol version number
note is rendered as such.

Fixes: 2c33c27fd603 ("x86/boot: Introduce kernel_info")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/r/20231106101206.76487-2-bagasdotme@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/arch/x86/boot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index f5d2f24..22cc7a0 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -77,7 +77,7 @@ Protocol 2.14	BURNT BY INCORRECT COMMIT
 Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
 =============	============================================================
 
-.. note::
+  .. note::
      The protocol version number should be changed only if the setup header
      is changed. There is no need to update the version number if boot_params
      or kernel_info are changed. Additionally, it is recommended to use
