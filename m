Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A017591B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjGSJb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGSJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:31:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E9186
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:31:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5VvX0BtgzBR5lb
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:31:52 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689759111; x=1692351112; bh=LItqP0llwziE0Rh0tkeMsYWBjcC
        emIDMOFOvno6nS6k=; b=nCKn0hTdixU+lqLNSIUoagua6whh2WdHvOraOw3UZsk
        Gi0NAF1gU4cpxEvHYX/1XjJWb1RvxvBYGR4CxV39qnIr33WjMIePC06a5BELZF1T
        t9lTlNjYKMc/JQy8ssWfyla0HxYQq5FjPPSgFiFD5T37rv34ZxbM6PihRr+4FcSS
        gHEvAv8YGgYXcP842ZLjRKwtVJ9P7ovEdLAiUpyV/fS63NNAq8f9oF4XzwuwkU+x
        azgNUPHTY+rV/kcoT/eJjafw4fDCCntS/fKLTDRR2Ut4fgvqsr7OYCxI/SGPIYxQ
        7p3AjePkUt9jn8gF7tEPML6MFaho2hU+2PIHw9SO1pA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J-01tpFKFT9G for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:31:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5VvW4lmDzBR1Nw;
        Wed, 19 Jul 2023 17:31:51 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:31:51 +0800
From:   hanyu001@208suo.com
To:     kvalo@kernel.org
Cc:     libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] libertas: debugfs: Added missing spaces
In-Reply-To: <tencent_0EA6836B1E10A9623158112DD43D48C95605@qq.com>
References: <tencent_0EA6836B1E10A9623158112DD43D48C95605@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <013fa54eeb505b6a7080c6d4ccc3a445@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

./drivers/net/wireless/marvell/libertas/debugfs.c:712: ERROR: spaces 
required around that '=' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:712: ERROR: spaces 
required around that '<' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:723: ERROR: spaces 
required around that '=' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:723: ERROR: spaces 
required around that '<' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:734: ERROR: spaces 
required around that '=' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:734: ERROR: spaces 
required around that '<' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:754: ERROR: spaces 
required around that '=' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:754: ERROR: spaces 
required around that '<' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:754: ERROR: space 
required before the open parenthesis '('
./drivers/net/wireless/marvell/libertas/debugfs.c:759: ERROR: spaces 
required around that '=' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:759: ERROR: spaces 
required around that '<' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:759: ERROR: space 
required before the open parenthesis '('
./drivers/net/wireless/marvell/libertas/debugfs.c:766: ERROR: spaces 
required around that '=' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:766: ERROR: spaces 
required around that '<' (ctx:VxV)
./drivers/net/wireless/marvell/libertas/debugfs.c:766: ERROR: space 
required before the open parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/net/wireless/marvell/libertas/debugfs.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/debugfs.c 
b/drivers/net/wireless/marvell/libertas/debugfs.c
index c604613..8939bf4 100644
--- a/drivers/net/wireless/marvell/libertas/debugfs.c
+++ b/drivers/net/wireless/marvell/libertas/debugfs.c
@@ -709,7 +709,7 @@ void lbs_debugfs_init_one(struct lbs_private *priv, 
struct net_device *dev)

      priv->debugfs_dir = debugfs_create_dir(dev->name, lbs_dir);

-    for (i=0; i<ARRAY_SIZE(debugfs_files); i++) {
+    for (i = 0; i < ARRAY_SIZE(debugfs_files); i++) {
          files = &debugfs_files[i];
          priv->debugfs_files[i] = debugfs_create_file(files->name,
                                   files->perm,
@@ -720,7 +720,7 @@ void lbs_debugfs_init_one(struct lbs_private *priv, 
struct net_device *dev)

      priv->events_dir = debugfs_create_dir("subscribed_events", 
priv->debugfs_dir);

-    for (i=0; i<ARRAY_SIZE(debugfs_events_files); i++) {
+    for (i = 0; i < ARRAY_SIZE(debugfs_events_files); i++) {
          files = &debugfs_events_files[i];
          priv->debugfs_events_files[i] = 
debugfs_create_file(files->name,
                                   files->perm,
@@ -731,7 +731,7 @@ void lbs_debugfs_init_one(struct lbs_private *priv, 
struct net_device *dev)

      priv->regs_dir = debugfs_create_dir("registers", 
priv->debugfs_dir);

-    for (i=0; i<ARRAY_SIZE(debugfs_regs_files); i++) {
+    for (i = 0; i < ARRAY_SIZE(debugfs_regs_files); i++) {
          files = &debugfs_regs_files[i];
          priv->debugfs_regs_files[i] = debugfs_create_file(files->name,
                                   files->perm,
@@ -751,19 +751,19 @@ void lbs_debugfs_remove_one(struct lbs_private 
*priv)
  {
      int i;

-    for(i=0; i<ARRAY_SIZE(debugfs_regs_files); i++)
+    for (i = 0; i < ARRAY_SIZE(debugfs_regs_files); i++)
          debugfs_remove(priv->debugfs_regs_files[i]);

      debugfs_remove(priv->regs_dir);

-    for(i=0; i<ARRAY_SIZE(debugfs_events_files); i++)
+    for (i = 0; i < ARRAY_SIZE(debugfs_events_files); i++)
          debugfs_remove(priv->debugfs_events_files[i]);

      debugfs_remove(priv->events_dir);
  #ifdef PROC_DEBUG
      debugfs_remove(priv->debugfs_debug);
  #endif
-    for(i=0; i<ARRAY_SIZE(debugfs_files); i++)
+    for (i = 0; i < ARRAY_SIZE(debugfs_files); i++)
          debugfs_remove(priv->debugfs_files[i]);
      debugfs_remove(priv->debugfs_dir);
  }
