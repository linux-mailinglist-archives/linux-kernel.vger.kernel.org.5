Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838777A46F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbjIRK3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbjIRK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:29:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD1FB;
        Mon, 18 Sep 2023 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695032954; x=1726568954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VogUQOlQ1/rQT0jeoXg6NNdcVrTqd4y2vbp2G55+j5Y=;
  b=I5A+6Pio4PF80HjcMLvzpnFlP/OKyxbsX+270TD3i2dz+nu/l4OYg5up
   0ykgMEX5mF+kTv0Q9pM7zUp+30QREZR+fabwBI9lN02FgAoe94/PFRC3x
   6OKWLyBLLJlnp35WW5Eg/JgHnDWr+U51ln2LZDRgjlnFAnygTADiP+7Zx
   pcKDfvijqUmcpCbf5GPqksNgmQ2sIBlcjuMJPK/jDWjGS0TI0Gj3KwB6J
   SiD6BxWmyOn6KfE4K4EYaJzzslJkzxvJUCuMNxPcaYK/0+/9Ak3RCNlMK
   y3onCM37hJobx2RATMb15ZC6QQ9QULcuzlq6fOiPvBAQRVm5lIVxSy77U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="359035876"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359035876"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="811305488"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811305488"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:29:11 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/1] MAINTAINERS: Add myself into x86 platform driver
Date:   Mon, 18 Sep 2023 13:29:00 +0300
Message-Id: <20230918102901.17669-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Hans has been asking for another person to help as the maintainer of
the x86 platform driver because Mark has not been able to find time to
do that. I got asked for the task and have been reviewing the relevant
patches for a while now but this series makes it more official by
adding the MAINTAINERS entries to the relevant places.

The current plan is I jump in mid v6.6-rc cycle (tentatively rc3) to
handle patches beyond just reviews. I'll be using review-ilpo as my
staging branch to keep things similar as they have been.

Ilpo Järvinen (1):
  MAINTAINERS: Add myself into x86 platform driver maintainers

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.30.2

