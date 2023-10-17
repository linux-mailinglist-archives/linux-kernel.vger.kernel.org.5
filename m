Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E0C7CB83B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjJQCHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQCHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:07:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2109B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697508442; x=1729044442;
  h=date:from:to:cc:subject:message-id;
  bh=K3MTg7g26tKqC4Nb47Bkpc61y6PWCadVKHHpY5/m6+4=;
  b=nx6fLjvoVk3w96uy15j62/SvFl4qkFTaYZqpf+VfCZ0owaZqEAT6Ymsh
   PZoZi9JZ/yW4qanoxXM37R3v2lS/nB1dlkvtPYB12jRylqITWBgITl44J
   ZdWctLRk3qFp+H/eboFOCzLqWCCV5sXclQvr7zqh1tL4zseTk/K3WpLyA
   wWqflcrVojURO9x7OcrUIYOO2cMss8Mva6FsJlXc07TxN1y7QcRiBNzyM
   kNA9kJh4cV68yl3rpTk+MvUCIQt7oK89zEVLzESKYO313tRQFVJlc/XBH
   FUWWEYNoO1zl9ep6DJOiq1HgJjezXKSNDmfQSgqo5SD3AitqHfNAL/T/i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365033809"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="365033809"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 19:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087305902"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="1087305902"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 19:07:21 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsZUM-0008q6-2q;
        Tue, 17 Oct 2023 02:07:18 +0000
Date:   Tue, 17 Oct 2023 10:06:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 1bae0cfe4a171ccc5f731426296e45beafa096b8
Message-ID: <202310171054.T2hIMBiN-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 1bae0cfe4a171ccc5f731426296e45beafa096b8  x86/mce: Cleanup mce_usable_address()

elapsed time: 739m

configs tested: 22
configs skipped: 113

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231017   gcc  
i386                  randconfig-002-20231017   gcc  
i386                  randconfig-003-20231017   gcc  
i386                  randconfig-004-20231017   gcc  
i386                  randconfig-005-20231017   gcc  
i386                  randconfig-006-20231017   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231016   gcc  
x86_64                randconfig-002-20231016   gcc  
x86_64                randconfig-003-20231016   gcc  
x86_64                randconfig-004-20231016   gcc  
x86_64                randconfig-005-20231016   gcc  
x86_64                randconfig-006-20231016   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
