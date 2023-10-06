Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4027BB9D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjJFNyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJFNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:54:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 997DE95;
        Fri,  6 Oct 2023 06:54:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BF54C15;
        Fri,  6 Oct 2023 06:54:50 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.94.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D11B83F641;
        Fri,  6 Oct 2023 06:54:09 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     lukasz.luba@arm.com, daniel.lezcano@linaro.org,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com
Subject: [PATCH] thermal: Add myself as thermal reviewer in MAINTAINERS
Date:   Fri,  6 Oct 2023 14:54:34 +0100
Message-Id: <20231006135434.3602921-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Become designated reviewer and help thermal subsystem in development
process.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi Rafael,

This should apply on top of your patch removing the previous reviewer.

Regards,
Lukasz


 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63186c63cba6..70087a08d720 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21357,6 +21357,7 @@ THERMAL
 M:	Rafael J. Wysocki <rafael@kernel.org>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 R:	Zhang Rui <rui.zhang@intel.com>
+R:	Lukasz Luba <lukasz.luba@arm.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pm/list/
-- 
2.25.1

