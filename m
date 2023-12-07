Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC2A80951E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444055AbjLGWOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjLGWO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:14:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61C10DE;
        Thu,  7 Dec 2023 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701987276; x=1733523276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3jDYHZdLhclZjNlkAWZI8B4j0AN+0ZaZjsj4QnwFCNE=;
  b=Bm6+rFLpdqydvVLwrPYJM2DOVwjdsH3vyA/9Zmbio8XFbo6DgiAhvmEd
   VuJyETQwtKQK76yAdQUG+Niqau+O4qyOcMxLQ15Fnw6xMespf0yvZ17/3
   eiXWGDj6gSxbv5F42b4hkwZG9R01d9Y93yx3c9C/fY0Lq+peU0PmdDPEI
   hD7sNdWzIB7bptUykeHX+p0o2NlKJ4HW99yWQkteKeW9rYYdPqBVl5dYo
   u3k8hqsvtzLaJC77cKpZBcaEwzV9+kzFcr3MUEzISxwBLD5Ep0fRRLL7M
   Pmv2YTRs/d7wFBSE5su9s7u7mCP4zC4rQnUlbN3k/VGN9GPb1I3EsBzF+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1197560"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1197560"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842365244"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="842365244"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2023 14:14:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 07707284; Fri,  8 Dec 2023 00:14:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/2] spi: pxa2xx: Update documentation
Date:   Fri,  8 Dec 2023 00:13:38 +0200
Message-ID: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of documentation updates.

Andy Shevchenko (2):
  spi: pxa2xx: Use inclusive language
  spi: pxa2xx: Update DMA mapping and using logic in the documentation

 Documentation/spi/pxa2xx.rst | 59 +++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

