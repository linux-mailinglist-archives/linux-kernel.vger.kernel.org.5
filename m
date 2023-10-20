Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FD77D130C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377783AbjJTPl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377733AbjJTPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:41:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E9ABBF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:41:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7B72143D;
        Fri, 20 Oct 2023 08:42:04 -0700 (PDT)
Received: from e127643.cambridge.arm.com (e127643.arm.com [10.1.26.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 12AB33F762;
        Fri, 20 Oct 2023 08:41:21 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     gregkh@linuxfoundation.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     leo.yan@linaro.org, namhyung@kernel.org,
        atrajeev@linux.vnet.ibm.com, James Clark <james.clark@arm.com>
Subject: [PATCH v2] MAINTAINERS: coresight: Add missing Coresight files
Date:   Fri, 20 Oct 2023 16:41:03 +0100
Message-Id: <20231020154103.55936-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
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

There are a few files missing from the list like test_arm_coresight.sh
and arm-coresight.txt so add the missing entries.

Signed-off-by: James Clark <james.clark@arm.com>
---

Changes since V1: 
 * Don't wildcard everything so that habanalabs/gaudi/gaudi_coresight*
   isn't included.

Link to V1: https://lore.kernel.org/lkml/20231005084001.34741-1-james.clark@arm.com/

 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..6b0e21ab7d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2068,12 +2068,16 @@ F:	Documentation/trace/coresight/*
 F:	drivers/hwtracing/coresight/*
 F:	include/dt-bindings/arm/coresight-cti-dt.h
 F:	include/linux/coresight*
+F:	include/uapi/linux/coresight*
 F:	samples/coresight/*
+F:	tools/perf/Documentation/arm-coresight.txt
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
 F:	tools/perf/arch/arm/util/pmu.c
+F:	tools/perf/tests/shell/*coresight*
 F:	tools/perf/tests/shell/coresight/*
+F:	tools/perf/tests/shell/lib/*coresight*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
-- 
2.34.1

