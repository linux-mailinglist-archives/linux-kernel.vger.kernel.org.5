Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272D8804932
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjLEFL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEFLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:11:52 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0320CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701753114;
        bh=2anY2QdcZbB0B1tISoPHXMFtfB5Mk2f/RoHBqPIh/pc=;
        h=From:To:Cc:Subject:Date:From;
        b=Xo8WphHlrv0Dfbn1TxwQ6oFPLlSjpj4t7DW39/rp8v3ZBM/fb9IANjYOYT8UrK7rb
         7p6+gy769o6XvpgH7di0z4ljE4VYF7x/nFWoCjLCRavC3uWgoDykGh0A3ikLlRBv2M
         oa05KZOhCJltd/4VyjhMM/JiDgBcgnIvtZaT+0HIcp0s7FPTv2fVu2aL08cfUnmQaj
         yqwzl3thzwRAUZMsmL3Y9ccgKqM1I4nMdZ9p9YrIVnZiOVSt3zpWu0jskuk3plSlns
         BgehYzH8qWSOU7SMziAyzaPBpkriIAze1scn1XIgA7r2UeRjnQ1Y3g3zXcin5GgXuz
         2In9bguNy/nBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SkpYP2tqHz4wd6;
        Tue,  5 Dec 2023 16:11:53 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <linux-kernel@vger.kernel.org>, <aneesh.kumar@linux.ibm.com>,
        <naveen.n.rao@linux.ibm.com>, <christophe.leroy@csgroup.eu>,
        <npiggin@gmail.com>
Subject: [PATCH] MAINTAINERS: powerpc: Add Aneesh & Naveen
Date:   Tue,  5 Dec 2023 16:11:05 +1100
Message-ID: <20231205051105.736470-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh and Naveen are helping out with some aspects of upstream
maintenance, add them as reviewers.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af79..562d048863ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12240,6 +12240,8 @@ LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Michael Ellerman <mpe@ellerman.id.au>
 R:	Nicholas Piggin <npiggin@gmail.com>
 R:	Christophe Leroy <christophe.leroy@csgroup.eu>
+R:	Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
+R:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 W:	https://github.com/linuxppc/wiki/wiki
-- 
2.43.0

