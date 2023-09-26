Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1917AE79F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjIZIOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjIZIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:13:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D8F101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:13:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0309C433C9;
        Tue, 26 Sep 2023 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695716031;
        bh=tr50ODn4xLi0WPzL73tIwSx34xkSXd0njW0b++RwK7A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Kq+5t1H1RqRZ7/wfRgoMtkAfWgZfRarFun74Y/EOoE/bL1/tbdSyOvbYZbQWVtHN9
         o+3n+7m+0cr3Z2tzmMCDp5FGAAGDQPFJpTFZovNmIFDykj307HiaHew4HLkIIUXy4H
         mttE0LUr2Oi+c4RKzS6PdV1Vnlstva0pROLHRYXcZp7KWMIYWEly6ZKGOLnXL4tbzq
         lryQwjFv89mr28563UU0FssZbNdq+NGIDrGGyStsICfWDLnAAAXZlWS04KSXkTdsPQ
         zTGb8CR8D2a+822TYO7hw99/2AeF7wtiGYrdCIWEzdlRNuPZhgapdUuwU9zL/YVk4z
         Yrx5y/KwDlP/Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] accel/habanalabs: minor cosmetics update to trace file
Date:   Tue, 26 Sep 2023 11:13:38 +0300
Message-Id: <20230926081345.240927-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926081345.240927-1-ogabbay@kernel.org>
References: <20230926081345.240927-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Update copyright years
- Add missing newline at end of file

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/trace/events/habanalabs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/habanalabs.h b/include/trace/events/habanalabs.h
index 0d3667399d01..cf85753a33b1 100644
--- a/include/trace/events/habanalabs.h
+++ b/include/trace/events/habanalabs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2022-2023 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -209,3 +209,4 @@ DEFINE_EVENT(habanalabs_reg_access_template, habanalabs_elbi_write,
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
+
-- 
2.34.1

