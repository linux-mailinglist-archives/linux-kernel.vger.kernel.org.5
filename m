Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6087564CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGQNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGQNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:25:09 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D92F12D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:24:26 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by albert.telenet-ops.be with bizsmtp
        id NDPz2A00K0ucMBo06DPzZQ; Mon, 17 Jul 2023 15:23:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLOCc-001fvf-Ku;
        Mon, 17 Jul 2023 15:23:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLOCl-007QvQ-I6;
        Mon, 17 Jul 2023 15:23:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v3] drm: Spelling s/randevouz/rendez-vous/
Date:   Mon, 17 Jul 2023 15:23:58 +0200
Message-Id: <084bf178dd676a4f07933eb9fcd04d3e30a779ba.1689600209.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "rendez-vous".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
v3:
  - Add Reviewed-by,

v2:
  - s/vouz/vous/.
---
 include/drm/task_barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
index 217c1cf21c1ab7d5..f6e6ed52968133d2 100644
--- a/include/drm/task_barrier.h
+++ b/include/drm/task_barrier.h
@@ -24,7 +24,7 @@
 #include <linux/atomic.h>
 
 /*
- * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
+ * Reusable 2 PHASE task barrier (rendez-vous point) implementation for N tasks.
  * Based on the Little book of semaphores - https://greenteapress.com/wp/semaphores/
  */
 
-- 
2.34.1

