Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4534760A60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjGYGfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGYGfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:35:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758019F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D2066154C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4CBC433C8;
        Tue, 25 Jul 2023 06:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690266938;
        bh=hBOiCrB2pZoay5rRcxDyKRF2mihgGZMEDV9unye5yIM=;
        h=From:To:Cc:Subject:Date:From;
        b=a6JZ585QOtZTSC2v7W33b0iswfPl4Bz+JhrJQUHOfBUl8etTrYtpr2kmwnPuT7iqp
         8ybwKQioX9BqFVAOiGv4WGsGzRbYOjgOhZ9MXW60y31jpysFKimYC4LPB+Un9izYL7
         dg+E5w7vPAEO0XYOHV89ocdgG0B7bzQl/91b5K04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Documentation: embargoed-hardware-issues.rst: add AMD to the list
Date:   Tue, 25 Jul 2023 08:35:27 +0200
Message-ID: <20230725063527.3627081-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMD back to the embargoed-hardware-issues.rst list.  There was
confusion about a recent issue that ended up being due to third-party's
misrepresentation, not AMD, so add AMD back to the list to get notified
properly as they understand the proper procedures to follow.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/embargoed-hardware-issues.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 81a8fb0862a4..cb686238f21d 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -244,6 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
 an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
+  AMD		Tom Lendacky <thomas.lendacky@amd.com>
   Ampere	Darren Hart <darren@os.amperecomputing.com>
   ARM		Catalin Marinas <catalin.marinas@arm.com>
   IBM Power	Anton Blanchard <anton@linux.ibm.com>
-- 
2.41.0

