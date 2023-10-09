Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F076E7BD1AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 03:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbjJIBIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 21:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 21:08:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1876AAB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 18:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696813709; x=1728349709;
  h=date:from:to:cc:subject:message-id;
  bh=AvMsdhFFcbx9jrUgVXoaekccRdtaiV6kHWVHO7Vhytw=;
  b=KCJLond23hhaDpnsNmH6Yvlre8RLzE1RFmZRGvjLVOEo5TexbVojklnT
   15YHyWinlw4YAe2AMkRaifu7md6+i7ngKoSvifBcZMXutmRJdwxea2cJX
   Qd7lIG+wnPYyxaAWkJeKVu/RQ+ROsN2k1GeYnkdQPJC82hG77tDDPagMx
   sw1Vd0ci8qly2ObYK2pDbshliPQwTGAPZCLAnoGJYjVPHB5I1o1fOqhbN
   YsB6eh0Y+yIoTwOrF0ICG+jfMWmUfiGwS628Hy8DBVgBxIxDSmX+oeKWH
   UFF0oM4ThQM9JPMDDFtYzPKAVxJ5xdDzeikN7mMD60Q0+x9e+s++ET6Ho
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="374369487"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="374369487"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 18:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926598829"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="926598829"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Oct 2023 18:08:28 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpel0-0005vx-1Z;
        Mon, 09 Oct 2023 01:08:26 +0000
Date:   Mon, 09 Oct 2023 09:07:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e5f83f51a48fa65e50f029ef43c7c7db6d234c45
Message-ID: <202310090931.cRlSSfpC-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e5f83f51a48fa65e50f029ef43c7c7db6d234c45  Merge branch into tip/master: 'x86/tdx'

elapsed time: 857m

configs tested: 145
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
arc                   randconfig-001-20231008   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                   randconfig-001-20231008   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231008   gcc  
i386         buildonly-randconfig-002-20231008   gcc  
i386         buildonly-randconfig-003-20231008   gcc  
i386         buildonly-randconfig-004-20231008   gcc  
i386         buildonly-randconfig-005-20231008   gcc  
i386         buildonly-randconfig-006-20231008   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231008   gcc  
i386                  randconfig-002-20231008   gcc  
i386                  randconfig-003-20231008   gcc  
i386                  randconfig-004-20231008   gcc  
i386                  randconfig-005-20231008   gcc  
i386                  randconfig-006-20231008   gcc  
i386                  randconfig-011-20231008   gcc  
i386                  randconfig-012-20231008   gcc  
i386                  randconfig-013-20231008   gcc  
i386                  randconfig-014-20231008   gcc  
i386                  randconfig-015-20231008   gcc  
i386                  randconfig-016-20231008   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231008   gcc  
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
mips                            ar7_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
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
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231008   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231008   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231008   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231008   gcc  
x86_64       buildonly-randconfig-002-20231008   gcc  
x86_64       buildonly-randconfig-003-20231008   gcc  
x86_64       buildonly-randconfig-004-20231008   gcc  
x86_64       buildonly-randconfig-005-20231008   gcc  
x86_64       buildonly-randconfig-006-20231008   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231008   gcc  
x86_64                randconfig-002-20231008   gcc  
x86_64                randconfig-003-20231008   gcc  
x86_64                randconfig-004-20231008   gcc  
x86_64                randconfig-005-20231008   gcc  
x86_64                randconfig-006-20231008   gcc  
x86_64                randconfig-011-20231008   gcc  
x86_64                randconfig-012-20231008   gcc  
x86_64                randconfig-013-20231008   gcc  
x86_64                randconfig-014-20231008   gcc  
x86_64                randconfig-015-20231008   gcc  
x86_64                randconfig-016-20231008   gcc  
x86_64                randconfig-071-20231008   gcc  
x86_64                randconfig-072-20231008   gcc  
x86_64                randconfig-073-20231008   gcc  
x86_64                randconfig-074-20231008   gcc  
x86_64                randconfig-075-20231008   gcc  
x86_64                randconfig-076-20231008   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
