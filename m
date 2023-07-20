Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291CE75B10E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGTOTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjGTOTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:19:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8CC1B6;
        Thu, 20 Jul 2023 07:19:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-55c85b4b06bso411925a12.2;
        Thu, 20 Jul 2023 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689862769; x=1690467569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UmiVU80Lqrzb2qyigiYCT+sEr22kLYoauqxq19CCww=;
        b=NwUPRLEEVzwl5/ARikpjhHMyNoe34pLZ06fuw6S+6nqDxVkP6c8jh7+kftmpicZkwo
         MG8ef7WsxO7pTw/ejQX9L/UTo6r9r3qJb4fOYf+g0qk97i/0jJJPBYnuIGkc0Ub711Ly
         RzQ8kILhNPGyY+fdHWu0UZgVNo5+sDtxkR7X5PrpRiX5/RhX1trvGVjShZCj7BuInKje
         jxjBQVXKWo/TlMgQBF8Te4zsebIR6eWsTdB4//BBpxeRN4cYmNyDc4TnYzpSqnTXN4Ng
         Ut3SK6V237rtTC8N/wHiBriX9JI8SSh0GPhDORFxwGgsuhrbCeYXJDeWwFbLBPFJx3/R
         Zvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689862769; x=1690467569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UmiVU80Lqrzb2qyigiYCT+sEr22kLYoauqxq19CCww=;
        b=h4y8QrrQ5bxn7qffZDao6BIlQnR9yfQ8/iBHr31suNrfId69/qJpJek1rusFzW56Yl
         YEIBzIjZkRT2Ii6IRO5dyeXJQzRoWuOUX+vi0juk2bMkSpPcje9jeSqTUuZQNjVIp00a
         PKFRbuaeIiUEC/f3HKuwNFImeaGfogwxIhqY+hIdL0e0SPPKUzCcLr0FwdYRUlNhIVpW
         EvdRy+D5RvtC3ST5vKsJYrSp/JhMn3tah9F2eCtE9KxPPk9n6B9IIw4k/Nmwrt3WXyW4
         obLAxcDge1J7G2GtBFesiSfIhC27XJbCTyU0DCLGbsld3uh/zwdZ7joKbEsHAcmaAajq
         novA==
X-Gm-Message-State: ABy/qLadNlZVQt4zmosrLl1gi62fYm68/oAHiJcs4IRH84RFLNXU46ph
        hNg2QIpf0iy8ydQTEKb2lGjNmvhOdO75qIp7/wo=
X-Google-Smtp-Source: APBJJlGCfMxsJ3oRcHRe5IGiQDj+LW1uJY91a8CE4WULWa2DXXCNEB6RqDWpgIdBPKPtVG7K8A0r0g==
X-Received: by 2002:a17:90b:3b51:b0:263:f5fa:cf1b with SMTP id ot17-20020a17090b3b5100b00263f5facf1bmr14705654pjb.30.1689862768717;
        Thu, 20 Jul 2023 07:19:28 -0700 (PDT)
Received: from localhost.localdomain ([113.251.0.121])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a670100b002630bfd35b0sm2711594pjj.7.2023.07.20.07.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:19:28 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_TW: remove the mailing list entry for zh_TW
Date:   Thu, 20 Jul 2023 22:18:46 +0800
Message-Id: <20230720141846.1787-1-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to some reasons the current mailing list will be revoked and new one
will replace it in the future, hence remove the entry from MAINTAINERS
ahead of time.

Signed-off-by: Hu Haowen <src.res.211@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5c16bb92fe2..36e67c46a4a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21707,7 +21707,6 @@ F:	kernel/trace/trace_sched_wakeup.c
 
 TRADITIONAL CHINESE DOCUMENTATION
 M:	Hu Haowen <src.res.211@gmail.com>
-L:	linux-doc-tw-discuss@lists.sourceforge.net (moderated for non-subscribers)
 S:	Maintained
 W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
-- 
2.34.1

