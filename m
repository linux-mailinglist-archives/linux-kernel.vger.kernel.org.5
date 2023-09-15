Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1E7A2A3B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjIOWJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbjIOWJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:09:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5161FDE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694815735;
        bh=jCDRcudEV2z0xDygC01UEyiZ7ZUyQQRl+C43Vbs1reA=;
        h=From:Date:Subject:To:Cc:From;
        b=NBE+2GQvW+3ZM96PIB3FTFCsDWsGtRXsgh4WE06R/zbUaUNhgSwfG9TxDSeWzm+v0
         ds7lxizlKv/6ZLzUGg9JdCAq4ggaQwza9pjv5vhQrG+fYqbmvHi5zt6vab4zVWXlvK
         V6j7K9G76Fyz0zbK8eniBbnk3dhINtdBWIZb+hq8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 16 Sep 2023 00:08:54 +0200
Subject: [PATCH] MAINTAINERS: nolibc: update tree location
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230916-nolibc-tree-v1-1-06c9b59a5035@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPXVBGUC/x3MQQqAIBBA0avIrBPUQqirRAtHpxoIDY0IpLsnL
 d/i/wqFMlOBSVTIdHPhFBt0J8DvLm4kOTSDUaZXo7YypoPRyysTyWA1OhwcoUdoxZlp5ee/zcv
 7futbGbBdAAAA
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694815735; l=849;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jCDRcudEV2z0xDygC01UEyiZ7ZUyQQRl+C43Vbs1reA=;
 b=p3MGH3rGLs9mlIl4dhvLUiWlSsgCRrJlTFkDU3aLK7DWk8gS4M/wzt3GqG5zde0qxFaMDnttk
 ILg2/13cXCuDxchHp/8MO/2fy9xntMBnGdyUXtBK/zmDIwTBaXFWu5P
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nolibc tree moved out of Willys user namespace into its own.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..6c83087ea396 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15131,7 +15131,7 @@ NOLIBC HEADER FILE
 M:	Willy Tarreau <w@1wt.eu>
 M:	Thomas Weißschuh <linux@weissschuh.net>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
 F:	tools/include/nolibc/
 F:	tools/testing/selftests/nolibc/
 

---
base-commit: 3f79a57865b33f49fdae6655510bd27c8e6610e0
change-id: 20230916-nolibc-tree-d61bab4aebcb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

