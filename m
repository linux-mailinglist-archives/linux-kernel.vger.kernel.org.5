Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3003787D30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbjHYBbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbjHYBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:31:23 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38F1BC6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:31:20 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-64f42fcd809so2680086d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692927080; x=1693531880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKvsMas+qEcAlugOn+9wZjgalcDhIyVOg4JqGCjGn+U=;
        b=eLs/cIOxI6hTplD2C7Bg4P1JBB6fetnBS1lLTGtVCrOwsFQxlcx5J2oQMtA0uZziBw
         9JZhhoiemOnqY8vyQXRfUy8S/si8rkKObeOaUiOKhvQ7LgRAP4UgBhGjF0fwTei+ROZr
         feUIQMk/EtI73iiYbJRcGEkPXwzyvH/WZN+4XSZ1qNzAoewB8x7Jt3SuzIMGbALomrlR
         DsaW6p228rxuKqrAHvbG2N3P61aw7A/nnmb9XXqOhlEpLXOrvpkc3WahM1lOUJAK5rdU
         4wc8+z/v1tLO8ttf/S8i0UCCnOMX9TdIJcUd6RbIHAJsMMDpXHQ1+aDXLTo8rsinyF/8
         drVA==
X-Gm-Message-State: AOJu0Yzo8DTTn9CK2HwQuWWD7oV8QR3mhSfEq87tikKsSC8wPhQibk/g
        nekn8+bCvDvk+oD5ejDBQaM+JciWV7dr7O7M
X-Google-Smtp-Source: AGHT+IGU4+5mp3V4vFhWprGmaso9Cr6Ki/5acm/+OqRs/OHVKXkju0ONcrPdH2LUiIjpaR/O6a3dKA==
X-Received: by 2002:a0c:c547:0:b0:64f:3882:512a with SMTP id y7-20020a0cc547000000b0064f3882512amr15197867qvi.13.1692927079987;
        Thu, 24 Aug 2023 18:31:19 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8fff:fff6:56dc:6bcb:5787])
        by smtp.gmail.com with ESMTPSA id z18-20020a0c8f12000000b0064f49005a47sm195210qvd.87.2023.08.24.18.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 18:31:19 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Baoquan He <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] docs: fix link s390/zfcpdump.rst
Date:   Fri, 25 Aug 2023 04:30:57 +0300
Message-ID: <20230825013102.1487979-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after move of Documentation/s390 to Documentation/arch/s390

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/Kconfig.kexec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 9bfe68fe9676..7aff28ded2f4 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -110,7 +110,7 @@ config CRASH_DUMP
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
 	  For s390, this option also enables zfcpdump.
-	  See also <file:Documentation/s390/zfcpdump.rst>
+	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 
 config CRASH_HOTPLUG
 	bool "Update the crash elfcorehdr on system configuration changes"
-- 
2.41.0

