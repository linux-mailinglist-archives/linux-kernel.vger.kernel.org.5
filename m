Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538797D56AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjJXPiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjJXPh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:37:58 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE7FBA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:37:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698161874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v9uv3Jcd4oOy0sU4EDVHX6hPTQsYlHbkl7jOhlyTyDo=;
        b=mR9+IMKgzZcjaOK5QmqxIDEfemgCb5GgNfU4ooHyl7NiIyHweYBG1w3x5SXOHTKtubMvO0
        3V61A0WTzCE51zGyJKbfVaIy6pFxMhSUSzhxWIIVVIMZJE8Eea47dOMCHaRGmkxqXhqPkE
        uiUs/9QDNv0j1nqMV+Weum0Jba1ADKI=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 1/1] Documentation: ubsan: drop "the" from article title
Date:   Tue, 24 Oct 2023 17:37:50 +0200
Message-Id: <5fb11a4743eea9d9232a5284dea0716589088fec.1698161845.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Drop "the" from the title of the documentation article for UBSAN,
as it is redundant.

Also add SPDX-License-Identifier for ubsan.rst.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/ubsan.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/ubsan.rst b/Documentation/dev-tools/ubsan.rst
index 1be6618e232d..2de7c63415da 100644
--- a/Documentation/dev-tools/ubsan.rst
+++ b/Documentation/dev-tools/ubsan.rst
@@ -1,5 +1,7 @@
-The Undefined Behavior Sanitizer - UBSAN
-========================================
+.. SPDX-License-Identifier: GPL-2.0
+
+Undefined Behavior Sanitizer - UBSAN
+====================================
 
 UBSAN is a runtime undefined behaviour checker.
 
-- 
2.25.1

