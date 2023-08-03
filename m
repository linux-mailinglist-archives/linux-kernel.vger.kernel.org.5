Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0602776EE26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjHCPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjHCPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:30:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0ECA2;
        Thu,  3 Aug 2023 08:30:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-56433b1b0e0so741878a12.0;
        Thu, 03 Aug 2023 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691076619; x=1691681419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIsx14YgPYJW5lTdhQ19poi53WNF65BBIWAeixCNdYI=;
        b=DhC2UPtIcqkXYEvGs0tQ5/Dj39qY2eHDZU5BlRigku214hAaVeUkPYgr8FTOOc7iFY
         XNkUCWdJUyPAR002CqlYUdfJ7uE3icNki+9JpzjjYKYaxDAabxguAqVWIsPvXesDmbG5
         bC23Bp0DaSToNjK/Nuq+MItRLMBAoNWMn9jmMq3SPCSW0FHijAqWZdrSB2bXbLYYgE0v
         ClyQxUy0Emai0YS+nMt8vDuLnBuKFEst2lPuhacNt1aSKa5egaVtRfoRSiGzWf8He/z6
         w/DY7dDDIp6zfYCVjq52Ms8HvQR/ZeFNrTf4Jm/8PIYBIfGmd4aG4ZgvytqNPzPKTv+t
         gdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076619; x=1691681419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIsx14YgPYJW5lTdhQ19poi53WNF65BBIWAeixCNdYI=;
        b=NzhfupPwaeo4tFEKvqnYR5ByQzFmtKr0tELv969y9/+9ImSOdnM3VGWUBvtWI3U+Pc
         TN8KS8is2QpT1B/bj+oa0K1WHTmWIwNsqmnvvkkhafPkkVzytNTVtLljoZV/ZHAuSW1Q
         24s8ci3l97SAnkkXli1z612QRpyy7YdJsvUC4X2QwD8UpDb8sdfCnPQrZASrGxHGRh4Q
         GxzU+VTsrt1DBzyVZrWyyv7tjZYCcHe96Q6qzI99bCrFue5HRxs7VZVcxnq9qmFvUT8i
         zd3TS7UZBi64ix6SEWRhsGbYwMKP5Maxd5vMxosAypv9gmilZrKBzOaR9Cvjlw113SLy
         cmBA==
X-Gm-Message-State: ABy/qLZgMOOpdGvCiH6LfVLBUXj6RmaAdgjAxPf4otIcKhW6L0BSRzcB
        wg36A2lMoE/T1XUn3l5oBuLipnaPcKBUtw==
X-Google-Smtp-Source: APBJJlHPMyTfc1DNnjbkEPW0Bsld07yS3uKJqxfCHrQh85vjAv60tXFYGILAOhju8yCxCBlfW0lYmA==
X-Received: by 2002:a17:90a:17a5:b0:268:ac3:b1f6 with SMTP id q34-20020a17090a17a500b002680ac3b1f6mr17030287pja.24.1691076619220;
        Thu, 03 Aug 2023 08:30:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100e:4034:19a2:fe9:9d1b:5681])
        by smtp.gmail.com with ESMTPSA id pj1-20020a17090b4f4100b00263d3448141sm102956pjb.8.2023.08.03.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:30:18 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH 8/8] Added a valid hyperlink
Date:   Thu,  3 Aug 2023 21:00:13 +0530
Message-Id: <20230803153014.25378-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The hyperlink to datasheet in website are subject to change.
Created stable hyperlinks to view datasheets.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
 Documentation/spi/spi-sc18is602.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/spi/spi-sc18is602.rst b/Documentation/spi/spi-sc18is602.rst
index 4ab9ca346..0dd7e3b95 100644
--- a/Documentation/spi/spi-sc18is602.rst
+++ b/Documentation/spi/spi-sc18is602.rst
@@ -6,7 +6,7 @@ Supported chips:
 
   * NXP SI18IS602/602B/603
 
-    Datasheet: https://www.nxp.com/documents/data_sheet/SC18IS602_602B_603.pdf
+    Datasheet: https://nbviewer.org/github/spidocs/spi-sc18is602/blob/main/spi-sc18is602.pdf
 
 Author:
         Guenter Roeck <linux@roeck-us.net>
-- 
2.25.1

