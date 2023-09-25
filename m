Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4B7ACEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjIYDoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYDn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:43:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F26AC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695613432; x=1727149432;
  h=date:from:to:cc:subject:message-id;
  bh=RW4hX1vCr3H8zptLWPKEzeHGjPvpXEljzV03j2NS0oM=;
  b=YKjtsAlJjj7mDP3TtUQvHfEJZuxI9bBZSMher5pzBbKNyJ4raU6OZPgq
   pm23Cn+cCNYXSRWP24VuWfW0foYTm42mwIqP3tODcfrxe/CWr+Um4QnHd
   PzbTMGZSaCNb4teBnifgq47e62kvkepundhLHquRu1NDU3QCeO76hzDG5
   lST1Uhb8+DNgsgdoEZcn5wWt2IZA20SiYk1NDHBnKHCo2F/hqty868NRg
   w11zy79FSczgJE+SV3fHoyjBkdpFFNntkA1lYt+hGgorV7fMQgpGu53ui
   B60dfR52MonItUiPT87H1lB9gXTWO6kA3Q7ZWqGi/pIVC1T0895b/Y4n4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445261811"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445261811"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 20:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="921838670"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="921838670"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Sep 2023 20:43:50 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkcVg-00019R-0y;
        Mon, 25 Sep 2023 03:43:48 +0000
Date:   Mon, 25 Sep 2023 11:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 94adf495e733d3b7e8b826c452ba12e995eef7c7
Message-ID: <202309251144.ACOq6kn7-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 94adf495e733d3b7e8b826c452ba12e995eef7c7  x86/kgdb: Fix a kerneldoc warning when build with W=1

elapsed time: 1110m

configs tested: 124
configs skipped: 113

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                   randconfig-001-20230925   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230924   gcc  
i386         buildonly-randconfig-002-20230924   gcc  
i386         buildonly-randconfig-003-20230924   gcc  
i386         buildonly-randconfig-004-20230924   gcc  
i386         buildonly-randconfig-005-20230924   gcc  
i386         buildonly-randconfig-006-20230924   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230924   gcc  
i386                  randconfig-001-20230925   gcc  
i386                  randconfig-002-20230924   gcc  
i386                  randconfig-002-20230925   gcc  
i386                  randconfig-003-20230924   gcc  
i386                  randconfig-003-20230925   gcc  
i386                  randconfig-004-20230924   gcc  
i386                  randconfig-004-20230925   gcc  
i386                  randconfig-005-20230924   gcc  
i386                  randconfig-005-20230925   gcc  
i386                  randconfig-006-20230924   gcc  
i386                  randconfig-006-20230925   gcc  
i386                  randconfig-011-20230924   gcc  
i386                  randconfig-011-20230925   gcc  
i386                  randconfig-012-20230924   gcc  
i386                  randconfig-012-20230925   gcc  
i386                  randconfig-013-20230924   gcc  
i386                  randconfig-013-20230925   gcc  
i386                  randconfig-014-20230924   gcc  
i386                  randconfig-014-20230925   gcc  
i386                  randconfig-015-20230924   gcc  
i386                  randconfig-015-20230925   gcc  
i386                  randconfig-016-20230924   gcc  
i386                  randconfig-016-20230925   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sparc                 randconfig-001-20230925   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230924   gcc  
x86_64       buildonly-randconfig-001-20230925   gcc  
x86_64       buildonly-randconfig-002-20230924   gcc  
x86_64       buildonly-randconfig-002-20230925   gcc  
x86_64       buildonly-randconfig-003-20230924   gcc  
x86_64       buildonly-randconfig-003-20230925   gcc  
x86_64       buildonly-randconfig-004-20230924   gcc  
x86_64       buildonly-randconfig-004-20230925   gcc  
x86_64       buildonly-randconfig-005-20230924   gcc  
x86_64       buildonly-randconfig-005-20230925   gcc  
x86_64       buildonly-randconfig-006-20230924   gcc  
x86_64       buildonly-randconfig-006-20230925   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230924   gcc  
x86_64                randconfig-001-20230925   gcc  
x86_64                randconfig-002-20230924   gcc  
x86_64                randconfig-002-20230925   gcc  
x86_64                randconfig-003-20230924   gcc  
x86_64                randconfig-003-20230925   gcc  
x86_64                randconfig-004-20230924   gcc  
x86_64                randconfig-004-20230925   gcc  
x86_64                randconfig-005-20230924   gcc  
x86_64                randconfig-005-20230925   gcc  
x86_64                randconfig-006-20230924   gcc  
x86_64                randconfig-006-20230925   gcc  
x86_64                randconfig-011-20230924   gcc  
x86_64                randconfig-012-20230924   gcc  
x86_64                randconfig-013-20230924   gcc  
x86_64                randconfig-014-20230924   gcc  
x86_64                randconfig-015-20230924   gcc  
x86_64                randconfig-016-20230924   gcc  
x86_64                randconfig-071-20230924   gcc  
x86_64                randconfig-071-20230925   gcc  
x86_64                randconfig-072-20230924   gcc  
x86_64                randconfig-072-20230925   gcc  
x86_64                randconfig-073-20230924   gcc  
x86_64                randconfig-073-20230925   gcc  
x86_64                randconfig-074-20230924   gcc  
x86_64                randconfig-074-20230925   gcc  
x86_64                randconfig-075-20230924   gcc  
x86_64                randconfig-075-20230925   gcc  
x86_64                randconfig-076-20230924   gcc  
x86_64                randconfig-076-20230925   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
