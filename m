Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B547D757702
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjGRIrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjGRIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:47:17 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FBBE4C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:47:13 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4syR2Xs4zBR9sx
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:47:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689670031; x=1692262032; bh=/LH0pQnbYVRnvqCUHOhkQ9PVPu0
        B6RTYRYGFtKomC5A=; b=c4byWfxTuLP7VbGvp+eBajKlNIh5iQM/DQQDGQxB6Jz
        O5ty0+a33IHA89NpkPrQ4EiqyAvYkBac+FCB1gHtrat5kQOaDsJv9gEIXx/+QAd+
        +D84wj3Bj7GOjMPuOfg7joPjrsektfnKFFL0jy9vG9VrEvxKKWlig3Y3NsELsFEh
        Xst0AU6YjQASF8I1ULiaEej/97ySgm1IDARY4RFKbh2jF/cscMJXbjb6rrLjt07y
        wrQMu89ZNox/m4XQZP5Uk4Rxzwk6yNjXNJFMovJf3zAEbM9fF73+PN8mVzJyneie
        gGQok4Kemu2pUocZxEkFjPrpAIMaIBmBL1et+qg5xoQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BB8J_31xlw82 for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 16:47:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4syR0qpnzBR7bp;
        Tue, 18 Jul 2023 16:47:11 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:47:11 +0800
From:   hanyu001@208suo.com
To:     geoff@infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: platforms: ps3: Add require space after that ';'
In-Reply-To: <tencent_61CFD504E2AA1B2AEDC779888E686B6AA309@qq.com>
References: <tencent_61CFD504E2AA1B2AEDC779888E686B6AA309@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <5a46daa59b79aa6031cf465f4648c689@208suo.com>
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

Fixes checkpatch errors:

./arch/powerpc/platforms/ps3/platform.h:198: ERROR: space required after 
that ';' (ctx:VxV)
./arch/powerpc/platforms/ps3/platform.h:200: ERROR: space required after 
that ';' (ctx:VxV)
./arch/powerpc/platforms/ps3/platform.h:202: ERROR: space required after 
that ';' (ctx:VxV)
./arch/powerpc/platforms/ps3/platform.h:204: ERROR: space required after 
that ';' (ctx:VxV)
./arch/powerpc/platforms/ps3/platform.h:206: ERROR: space required after 
that ';' (ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/ps3/platform.h | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/platform.h 
b/arch/powerpc/platforms/ps3/platform.h
index 6beecdb0d51f..715167ab7348 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -195,15 +195,15 @@ int ps3_repository_write_highmem_info(unsigned int 
region_index,
  int ps3_repository_delete_highmem_info(unsigned int region_index);
  #else
  static inline int ps3_repository_write_highmem_region_count(
-    unsigned int region_count) {return 0;}
+    unsigned int region_count) {return 0; }
  static inline int ps3_repository_write_highmem_base(unsigned int 
region_index,
-    u64 highmem_base) {return 0;}
+    u64 highmem_base) {return 0; }
  static inline int ps3_repository_write_highmem_size(unsigned int 
region_index,
-    u64 highmem_size) {return 0;}
+    u64 highmem_size) {return 0; }
  static inline int ps3_repository_write_highmem_info(unsigned int 
region_index,
-    u64 highmem_base, u64 highmem_size) {return 0;}
+    u64 highmem_base, u64 highmem_size) {return 0; }
  static inline int ps3_repository_delete_highmem_info(unsigned int 
region_index)
-    {return 0;}
+    {return 0; }
  #endif

  /* repository pme info */
