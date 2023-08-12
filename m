Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A39779EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjHLKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHLKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:20:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA2EBF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691835613; x=1723371613;
  h=date:from:to:cc:subject:message-id;
  bh=Qo9BP0sstfV1aUu+NV2hK+g5OP/nNgCp4JwXP5FGXts=;
  b=SLPHmJ2PmHu+7X2ZhhYlHvaENGv1vrWmt0UmxU6gq2X+q77FkXGozxiM
   BN8pSzxNbig+Wg2Ek7b5ABcn270lS5n5r+r7NZIdbcAuKc8EnL2Wd7yHz
   Y1y3ugfmEIizVfpwOpUT76aOwFiFMGNjSchqz/FndUg4sdlanDd2KPDoE
   0gSVXxklAaRmnU67Qqfv8DFJTtxXB0j45rS7obTOUvoRQh+jMhBAd/tkc
   xJeMnNf4Z1Kb6dJZNYpJSzS7jCwqIpwJ9zoJLIeH3Q68lBIKUyx52VdR2
   2EiVV5xYRDxCNE3LHPTJZPc11tHNFm2VAV3XwWJe/sNyTAdagHdz4HUfA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375527685"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="375527685"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 03:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063547199"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="1063547199"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2023 03:20:11 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUlj8-0008Ue-2c;
        Sat, 12 Aug 2023 10:20:10 +0000
Date:   Sat, 12 Aug 2023 18:19:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 6eb9c007bc37b302834cc6af57001f5242ea7dca
Message-ID: <202308121856.8kfVgAyY-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: 6eb9c007bc37b302834cc6af57001f5242ea7dca  Merge branch 'x86/core' into x86/merge, to ease integration testing

elapsed time: 1380m

configs tested: 128
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230811   gcc  
alpha                randconfig-r012-20230811   gcc  
alpha                randconfig-r025-20230811   gcc  
alpha                randconfig-r035-20230811   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r043-20230811   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r046-20230811   clang
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230811   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r034-20230811   clang
hexagon              randconfig-r041-20230811   clang
hexagon              randconfig-r045-20230811   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230811   clang
i386         buildonly-randconfig-r005-20230811   clang
i386         buildonly-randconfig-r006-20230811   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230811   clang
i386                 randconfig-i002-20230811   clang
i386                 randconfig-i003-20230811   clang
i386                 randconfig-i004-20230811   clang
i386                 randconfig-i005-20230811   clang
i386                 randconfig-i006-20230811   clang
i386                 randconfig-i011-20230811   gcc  
i386                 randconfig-i012-20230811   gcc  
i386                 randconfig-i013-20230811   gcc  
i386                 randconfig-i014-20230811   gcc  
i386                 randconfig-i015-20230811   gcc  
i386                 randconfig-i016-20230811   gcc  
i386                 randconfig-r022-20230811   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                 randconfig-r003-20230811   gcc  
m68k                 randconfig-r015-20230811   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r014-20230811   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                  cavium_octeon_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r004-20230811   gcc  
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r023-20230811   gcc  
openrisc             randconfig-r026-20230811   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r005-20230811   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230811   clang
riscv                randconfig-r042-20230811   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230811   gcc  
s390                 randconfig-r016-20230811   gcc  
s390                 randconfig-r021-20230811   gcc  
s390                 randconfig-r044-20230811   gcc  
sh                               allmodconfig   gcc  
sh                            migor_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r031-20230811   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230811   clang
x86_64       buildonly-randconfig-r002-20230811   clang
x86_64       buildonly-randconfig-r003-20230811   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r006-20230811   clang
x86_64               randconfig-r036-20230811   clang
x86_64               randconfig-x001-20230811   gcc  
x86_64               randconfig-x002-20230811   gcc  
x86_64               randconfig-x003-20230811   gcc  
x86_64               randconfig-x004-20230811   gcc  
x86_64               randconfig-x005-20230811   gcc  
x86_64               randconfig-x006-20230811   gcc  
x86_64               randconfig-x011-20230811   clang
x86_64               randconfig-x012-20230811   clang
x86_64               randconfig-x013-20230811   clang
x86_64               randconfig-x014-20230811   clang
x86_64               randconfig-x015-20230811   clang
x86_64               randconfig-x016-20230811   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
