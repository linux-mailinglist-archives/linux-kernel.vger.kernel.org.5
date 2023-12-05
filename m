Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69933804936
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbjLEFMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbjLEFMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:12:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05260CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701753163;
        bh=Y/UcMyZulCMpkKSxYUXawhkspAHbn05SpEAtSEun5f8=;
        h=From:To:Cc:Subject:Date:From;
        b=e/wAoH+jxLNN6y6pGOoENMhYs6iAjqi0qMSAD3hkk1mXBmV+u6rKYDB5BiPg6LELO
         xZ1xgrfVUhxQzgcLjcLxdgoG6iiGCoY836W9XYzhCTgEd2csFkuQL61qTzRcbBMK7c
         NmjfZ5Mt3fvTiQghsxPvswHJZryEc/Ltj009Lj+quYT5TlyUO7oUymHarqJPQ6LS9Q
         LwBzj1ugvHD73nQdNXcGJcgj1hAmeBu4zgas1pVsOYgd3j7ZbrJtG1n8kOjEIcfApi
         E4quCoXT9ZhC8mj+Nzbjfjw1kS9ChPhYV48cNEiSvOGPy5zsZfObIgCzqjAUa78L8T
         OhTQf/fSmQokA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SkpZM4Spcz4wdB;
        Tue,  5 Dec 2023 16:12:43 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <linux-kernel@vger.kernel.org>, oss@buserror.net,
        <christophe.leroy@csgroup.eu>
Subject: [PATCH] MAINTAINERS: powerpc: Transfer PPC83XX to Christophe
Date:   Tue,  5 Dec 2023 16:12:39 +1100
Message-ID: <20231205051239.737384-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe volunteered[1] to maintain PPC83XX.

1: https://lore.kernel.org/all/7b1bf4dc-d09d-35b8-f4df-16bf00429b6d@csgroup.eu/

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 562d048863ee..d4efe48cc36a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12287,21 +12287,21 @@ S:	Orphan
 F:	arch/powerpc/platforms/40x/
 F:	arch/powerpc/platforms/44x/
 
-LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
+LINUX FOR POWERPC EMBEDDED PPC85XX
 M:	Scott Wood <oss@buserror.net>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
 F:	Documentation/devicetree/bindings/cache/freescale-l2cache.txt
 F:	Documentation/devicetree/bindings/powerpc/fsl/
-F:	arch/powerpc/platforms/83xx/
 F:	arch/powerpc/platforms/85xx/
 
-LINUX FOR POWERPC EMBEDDED PPC8XX
+LINUX FOR POWERPC EMBEDDED PPC8XX AND PPC83XX
 M:	Christophe Leroy <christophe.leroy@csgroup.eu>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/platforms/8xx/
+F:	arch/powerpc/platforms/83xx/
 
 LINUX KERNEL DUMP TEST MODULE (LKDTM)
 M:	Kees Cook <keescook@chromium.org>
-- 
2.43.0

