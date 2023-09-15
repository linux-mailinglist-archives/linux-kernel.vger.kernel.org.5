Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29E67A270C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjIOTQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjIOTQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:16:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87380170E;
        Fri, 15 Sep 2023 12:16:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf7423ef3eso21197405ad.3;
        Fri, 15 Sep 2023 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694805384; x=1695410184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yxY6+HbG+ICeEhQvZXJriceyMdYdIehQa5XbmklSH3s=;
        b=IjgXin3GF2MKrkGtG9LE3txz2c+/vm1pppLLMZvWv64A4xAtbm5kEefXDyfszB7jcy
         yJtLehRzU9OvQdyTakW3Lu2e0hW1mjJpe8IgLeBmO+k1kdIOnGw8EzoIhRTeRe22VArZ
         SdrpF0P/SJn0BqLQZQnwrdjAbOwxBpAwl5ubGOLoq8mQ3QketorknbsweCJ/pPaeZQrk
         lKMs0UYlu/oV7ZP/XZbjAcb1aDMqcrwexp8UTv4usJw/UjDxercWpdS5USj1YJLfUBQK
         KlS43ahzOo5+VDQAvIZqUQs1x4jnDvX9TXNfH7ZL7re1FXYNV+KoqG4t337yJ5A99n62
         4+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694805384; x=1695410184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxY6+HbG+ICeEhQvZXJriceyMdYdIehQa5XbmklSH3s=;
        b=gjMUPsN3z8m8C68vamMmiESvBJka1QXfI3P6bonFiSHRPnYbAxSdKq+xH6EzgJE8CZ
         50Fu9f0sXtRmca2VzhqSE/lb1mkn6aZerWnmMrXGXxOJBi9IgIaODOHoVl3t9M6t6wZB
         QM4GJUaydH0da4GXkqbQPqQKQUqoKZzKBV2zWyyTprZEYPozS/wty86jcs85x4WWeKs6
         2xyW8W9pCf7FhDcRp2D7/u2b/HEnnjpHm1Fr9OcWUMBJgBpC4VHinUy0d+2O0YP787q5
         6A6GzUfZRcfUJgLcn/8Fb8mWLvEmwKOq8jJLjXwIpi6wm/TQ7VEB/VtyItV3pHAR3Kge
         13Zg==
X-Gm-Message-State: AOJu0YyIcDXv94edXUVSQhDUYTVUhvZWv87zvgnsvWcsIXKRJhPeO7Jj
        iBwg91bGLSUtAFlJ4WEb1+mWCafMm9wc7zMh
X-Google-Smtp-Source: AGHT+IEeqcClEaGFppon7PDzrDsjzlhWAM7HEhhhSjWJTQ46WhULLQsdhliSNh3l2ZHhFyGFLdg22g==
X-Received: by 2002:a17:902:c149:b0:1c4:4c0f:8d91 with SMTP id 9-20020a170902c14900b001c44c0f8d91mr606194plj.69.1694805384387;
        Fri, 15 Sep 2023 12:16:24 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:c4b6:ed28:95c7:9a77:34ba])
        by smtp.gmail.com with ESMTPSA id ja2-20020a170902efc200b001c444106bcasm830720plb.46.2023.09.15.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:16:23 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.linux@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, vkoul@kernel.org,
        davem@davemloft.net, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Update Bhupesh's email address
Date:   Sat, 16 Sep 2023 00:46:00 +0530
Message-Id: <20230915191600.3410862-1-bhupesh.linux@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the email address for Bhupesh's maintainer entry and fill in
.mailmap accordingly.

Signed-off-by: Bhupesh Sharma <bhupesh.linux@gmail.com>
---
 .mailmap    | 5 +++++
 MAINTAINERS | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a0a6efe87186..a69dfc6bbf1f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -94,6 +94,11 @@ Ben M Cahill <ben.m.cahill@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
 Ben Widawsky <bwidawsk@kernel.org> <ben.widawsky@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhsharma@redhat.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@freescale.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@st.com>
+Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
 Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
 Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@linaro.org>
 Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@sonymobile.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fa7487b7729b..620301a2b5ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17740,7 +17740,7 @@ F:	drivers/net/ethernet/qualcomm/emac/
 
 QUALCOMM ETHQOS ETHERNET DRIVER
 M:	Vinod Koul <vkoul@kernel.org>
-R:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
+R:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 L:	netdev@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
2.38.1

