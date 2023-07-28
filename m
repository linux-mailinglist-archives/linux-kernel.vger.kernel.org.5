Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71776777D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjG1VQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjG1VQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F03C0E;
        Fri, 28 Jul 2023 14:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 997BB62209;
        Fri, 28 Jul 2023 21:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92267C433C8;
        Fri, 28 Jul 2023 21:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690578981;
        bh=vtrKkVyBJ04h0WQ+xRn/gxnfxqEJUFW7+xMuf47mB0k=;
        h=From:To:Cc:Subject:Date:From;
        b=lW5U2/PI0wIIh50ZezAOKwQy05mb/Sg3hlrjI5qp9bhGy5Hn8tsH6p8aPfuz7G92I
         T1Fs+katykgRYTYgW2XNTrjlwXdpSdFUI+i5vYKXLWSHqrg0PrNKvxA5N4K0QcXCH8
         BdWvEI2BbfRSBCwhquqgTMXeKmQ3F5kDDtEDa2b1mJGnvmhRnDIG7eyDlkvIe+vR0z
         ELeLk+/2nMEsQuOi9Y0uca8sNVPyxxYI6o2Wh7ElFiAM0F/6e4/u7n044TfrkP5pCW
         jfYpMlPlDxEs33szIH9xo+gUUmC7rxmC7vV2bZdcUt7z9U+azJTzipH424uOTmEjkB
         CAm0YEkWpLSCA==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Docs/process/changes: Consolidate NFS-utils update links
Date:   Fri, 28 Jul 2023 21:16:15 +0000
Message-Id: <20230728211616.59550-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two update links for NFS-utils are in two duplicate sessions.
Consolidate.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/process/changes.rst | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 5561dae94f85..f05eada0383e 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -545,6 +545,7 @@ NFS-utils
 ---------
 
 - <http://sourceforge.net/project/showfiles.php?group_id=14>
+- <http://nfs.sourceforge.net/>
 
 Iptables
 --------
@@ -561,11 +562,6 @@ OProfile
 
 - <http://oprofile.sf.net/download/>
 
-NFS-Utils
----------
-
-- <http://nfs.sourceforge.net/>
-
 Kernel documentation
 ********************
 
-- 
2.25.1

