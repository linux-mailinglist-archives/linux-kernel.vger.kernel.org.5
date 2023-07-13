Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FDD752DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjGMXGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjGMXF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81735A2;
        Thu, 13 Jul 2023 16:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77E4761AD2;
        Thu, 13 Jul 2023 23:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8E1C433C8;
        Thu, 13 Jul 2023 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289513;
        bh=EyXzBkwCcbW2KfzsTxr0QPFagr89P+FI8myIz19EKcw=;
        h=From:To:Cc:Subject:Date:From;
        b=P52H4xI8UFWopgCGr0tKAoaMpke7UEyMnlehBhQF0nBwmZc9XW0K+OEdzSFTTfgE9
         pNA9hwG2X6hYK6CvXSwrx7BfMiSqJWFu6uUL7mTbF3CdsIr1X70xTofVkDO8vCXIis
         0FJWRCQ9WFvRbaTXkmnAU8vHDgxzuSTo824NxkQSkc/rMjqW9jMS8/P0Mrm4CfmTMJ
         7yDImbC4nqvZNf+sZW4zWe0NXJxrCJndU32NbjB9lC4TGKlqvsUk2efMz6AXmonRyC
         zwzH5UiILC+MDmPo5tihH0QQDWfcEOsVkm6VJ10Now2fVdrHp+WABMg98XT4esRbIY
         MOBXQEOIWU6YA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH docs] docs: maintainers: add missing 's' in https for the base lore link
Date:   Thu, 13 Jul 2023 16:05:10 -0700
Message-ID: <20230713230510.1505201-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example and the git hook use HTTPS but the text for some
reason links to the non-SSL version.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/maintainer/configure-git.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
index a054de0c50dc..b731e8b78565 100644
--- a/Documentation/maintainer/configure-git.rst
+++ b/Documentation/maintainer/configure-git.rst
@@ -38,7 +38,7 @@ You may also like to tell ``gpg`` which ``tty`` to use (add to your shell rc fil
 Creating commit links to lore.kernel.org
 ----------------------------------------
 
-The web site http://lore.kernel.org is meant as a grand archive of all mail
+The web site https://lore.kernel.org is meant as a grand archive of all mail
 list traffic concerning or influencing the kernel development. Storing archives
 of patches here is a recommended practice, and when a maintainer applies a
 patch to a subsystem tree, it is a good idea to provide a Link: tag with a
-- 
2.41.0

