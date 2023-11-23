Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295427F587E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjKWGnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:43:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A81BAD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700721797; x=1732257797;
  h=date:from:to:cc:subject:message-id;
  bh=sUqkWfaN7UML91ltz8z1dq3cYwJKIkfhTZbmXO1yCPM=;
  b=No7kkYar24LvIaZNiDI4wGAPzLlOBA6CtRbeYy8RkKqg+btZyVpOo7jp
   gbEX5efxVAMwXTdkmvZPUOftsvWr89OCWFxTbo9dehbw4/7Si6sUR+r51
   5BYC1WMhAV/tDQ2/2HYRz2CJtOAm9+1PWItKsZjDdcIacAM9F4I68TZYa
   DlFrjeP4u0HOj2Bf8gsC7BDcHrgjFtrAvjOomH80IdQK5KTplh7KMyPb7
   JDdaE7jjjvFWY4lkM+MxSpV/60+B+K4oRoCkfdBhE/7pB+oZ5R4Uj0epT
   bFXp+aetIhSk7bkfWS5wmu7ZFwm4rnjMWCU8YlB7vRXxaer781M1ypnIG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382608183"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="382608183"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:43:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="911077202"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="911077202"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2023 22:43:15 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r63Qe-0001Ih-2V;
        Thu, 23 Nov 2023 06:43:12 +0000
Date:   Thu, 23 Nov 2023 14:43:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 6175b407756b22e7fdc771181b7d832ebdedef5c
Message-ID: <202311231407.bb6G3Dgd-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 6175b407756b22e7fdc771181b7d832ebdedef5c  x86/mce/inject: Clear test status value

elapsed time: 736m

configs tested: 32
configs skipped: 137

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231123   gcc  
x86_64       buildonly-randconfig-002-20231123   gcc  
x86_64       buildonly-randconfig-003-20231123   gcc  
x86_64       buildonly-randconfig-004-20231123   gcc  
x86_64       buildonly-randconfig-005-20231123   gcc  
x86_64       buildonly-randconfig-006-20231123   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231123   clang
x86_64                randconfig-002-20231123   clang
x86_64                randconfig-003-20231123   clang
x86_64                randconfig-004-20231123   clang
x86_64                randconfig-005-20231123   clang
x86_64                randconfig-006-20231123   clang
x86_64                randconfig-011-20231123   gcc  
x86_64                randconfig-012-20231123   gcc  
x86_64                randconfig-013-20231123   gcc  
x86_64                randconfig-014-20231123   gcc  
x86_64                randconfig-015-20231123   gcc  
x86_64                randconfig-016-20231123   gcc  
x86_64                randconfig-071-20231123   gcc  
x86_64                randconfig-072-20231123   gcc  
x86_64                randconfig-073-20231123   gcc  
x86_64                randconfig-074-20231123   gcc  
x86_64                randconfig-075-20231123   gcc  
x86_64                randconfig-076-20231123   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
