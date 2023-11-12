Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6967E8F53
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjKLJ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:26:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967230C2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699781193; x=1731317193;
  h=date:from:to:cc:subject:message-id;
  bh=7ip7r1Xz/0j2WMjX26R4lZ9YCYbsKeWUDe0AvHyd0jU=;
  b=PKD07wyG4RStk2FwLxFR4npj+HhU4Y0thrvQuzHe43TgEpmoo9+QJkuJ
   q/QJIOQsTdB8HBRTwkcgKdWNDtT/3hX0fNakw5sG3xownxHjiVs9m7Dyz
   ngkCau09i2lw49URRA1FQFgWKc7Hdvf2bvkpGJsszatMTnqL7JHQ4YeQT
   zWS2+l4QxsrYa/tOa3mAkMQ3rerwNeRlF/m3U9KkGxCOYmF+xXi/izGTo
   ZXzibbjfJJESZB8kga7gfqXioIsVDbSjtrseG04lmMpnCj9L73aIe46ao
   vok0b43ZHcstMu0THfj/1M2eZV1qtFunuxFHVm1/LAOV5jsq7KIMiC63H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="393188531"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="393188531"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 01:26:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="937509997"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="937509997"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2023 01:26:31 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r26jd-000B2k-1G;
        Sun, 12 Nov 2023 09:26:29 +0000
Date:   Sun, 12 Nov 2023 17:25:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8cc7549bd8c82a741b9f514f24bc2e0a710b5342
Message-ID: <202311121742.M0okKjCg-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8cc7549bd8c82a741b9f514f24bc2e0a710b5342  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1468m

configs tested: 205
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231111   gcc  
arc                   randconfig-002-20231111   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231111   gcc  
arm                   randconfig-002-20231111   gcc  
arm                   randconfig-003-20231111   gcc  
arm                   randconfig-004-20231111   gcc  
arm                          sp7021_defconfig   clang
arm                         vf610m4_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231111   gcc  
arm64                 randconfig-002-20231111   gcc  
arm64                 randconfig-003-20231111   gcc  
arm64                 randconfig-004-20231111   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231111   gcc  
csky                  randconfig-002-20231111   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231111   gcc  
i386         buildonly-randconfig-002-20231111   gcc  
i386         buildonly-randconfig-003-20231111   gcc  
i386         buildonly-randconfig-004-20231111   gcc  
i386         buildonly-randconfig-005-20231111   gcc  
i386         buildonly-randconfig-006-20231111   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231111   gcc  
i386                  randconfig-002-20231111   gcc  
i386                  randconfig-003-20231111   gcc  
i386                  randconfig-004-20231111   gcc  
i386                  randconfig-005-20231111   gcc  
i386                  randconfig-006-20231111   gcc  
i386                  randconfig-011-20231111   gcc  
i386                  randconfig-012-20231111   gcc  
i386                  randconfig-013-20231111   gcc  
i386                  randconfig-014-20231111   gcc  
i386                  randconfig-015-20231111   gcc  
i386                  randconfig-016-20231111   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231111   gcc  
loongarch             randconfig-002-20231111   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231111   gcc  
nios2                 randconfig-002-20231111   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231111   gcc  
parisc                randconfig-002-20231111   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231111   gcc  
powerpc               randconfig-002-20231111   gcc  
powerpc               randconfig-003-20231111   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8555_defconfig   gcc  
powerpc64             randconfig-001-20231111   gcc  
powerpc64             randconfig-002-20231111   gcc  
powerpc64             randconfig-003-20231111   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231111   gcc  
riscv                 randconfig-002-20231111   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231111   gcc  
s390                  randconfig-002-20231111   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231111   gcc  
sh                    randconfig-002-20231111   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231111   gcc  
sparc                 randconfig-002-20231111   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231111   gcc  
sparc64               randconfig-002-20231111   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231111   gcc  
um                    randconfig-002-20231111   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231111   gcc  
x86_64       buildonly-randconfig-002-20231111   gcc  
x86_64       buildonly-randconfig-003-20231111   gcc  
x86_64       buildonly-randconfig-004-20231111   gcc  
x86_64       buildonly-randconfig-005-20231111   gcc  
x86_64       buildonly-randconfig-006-20231111   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231111   gcc  
x86_64                randconfig-002-20231111   gcc  
x86_64                randconfig-003-20231111   gcc  
x86_64                randconfig-004-20231111   gcc  
x86_64                randconfig-005-20231111   gcc  
x86_64                randconfig-006-20231111   gcc  
x86_64                randconfig-011-20231111   gcc  
x86_64                randconfig-012-20231111   gcc  
x86_64                randconfig-013-20231111   gcc  
x86_64                randconfig-014-20231111   gcc  
x86_64                randconfig-015-20231111   gcc  
x86_64                randconfig-016-20231111   gcc  
x86_64                randconfig-071-20231111   gcc  
x86_64                randconfig-072-20231111   gcc  
x86_64                randconfig-073-20231111   gcc  
x86_64                randconfig-074-20231111   gcc  
x86_64                randconfig-075-20231111   gcc  
x86_64                randconfig-076-20231111   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20231111   gcc  
xtensa                randconfig-002-20231111   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
