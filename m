Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0670D7A11E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjINXiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjINXh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:37:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255962707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694734675; x=1726270675;
  h=date:from:to:cc:subject:message-id;
  bh=UaF2Q7gPvWlMxpAkNZik4YThMPMTK/6rOTT4iGf9MNo=;
  b=CUputnL7syGqlaPX2ItGN/8jdeqeLfgOMxXau33xL+XZWUM5DJhl97YO
   +a3Bzv4zs5ncn0nicPUsPxe6ovrp4RbnckPi6P38oWCODEWmTOzNeymRI
   sj50i7fIwL674QieCxpHCet2F51OmSQLxZem7C8UvQ+wADWHj0pkFv3MR
   cwOHaOu9KDCGn1wn1+KZfFFwXpNfRaH3dc9JSziCiEzBlOtL5jwZJWgvg
   8ne9t+mAnyyfRQFwhgXho3E3DvBAmzy471JwSS1Csx85tQMgfjuLTt5yu
   BXTg6uMnswzTQ1z/CHIFOJI+QjtltDI7ZOIWHMffsbRIKWgyAmA5YNgCM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381831977"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="381831977"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 16:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="774085834"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="774085834"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2023 16:37:53 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgvuB-0002B5-13;
        Thu, 14 Sep 2023 23:37:51 +0000
Date:   Fri, 15 Sep 2023 07:36:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 a11e097504ac1889b35b6858f495565838325f88
Message-ID: <202309150749.n5X3huFT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
branch HEAD: a11e097504ac1889b35b6858f495565838325f88  x86: Make IA32_EMULATION boot time configurable

elapsed time: 735m

configs tested: 187
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230914   gcc  
arc                   randconfig-001-20230915   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                   randconfig-001-20230914   gcc  
arm                   randconfig-001-20230915   gcc  
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
i386         buildonly-randconfig-006-20230914   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230914   gcc  
i386                  randconfig-001-20230915   gcc  
i386                  randconfig-002-20230914   gcc  
i386                  randconfig-002-20230915   gcc  
i386                  randconfig-003-20230914   gcc  
i386                  randconfig-003-20230915   gcc  
i386                  randconfig-004-20230914   gcc  
i386                  randconfig-004-20230915   gcc  
i386                  randconfig-005-20230914   gcc  
i386                  randconfig-005-20230915   gcc  
i386                  randconfig-006-20230914   gcc  
i386                  randconfig-006-20230915   gcc  
i386                  randconfig-011-20230914   gcc  
i386                  randconfig-011-20230915   gcc  
i386                  randconfig-012-20230914   gcc  
i386                  randconfig-012-20230915   gcc  
i386                  randconfig-013-20230914   gcc  
i386                  randconfig-013-20230915   gcc  
i386                  randconfig-014-20230914   gcc  
i386                  randconfig-014-20230915   gcc  
i386                  randconfig-015-20230914   gcc  
i386                  randconfig-015-20230915   gcc  
i386                  randconfig-016-20230914   gcc  
i386                  randconfig-016-20230915   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230914   gcc  
loongarch             randconfig-001-20230915   gcc  
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
mips                          malta_defconfig   clang
mips                        omega2p_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
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
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230914   gcc  
riscv                 randconfig-001-20230915   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230914   gcc  
s390                  randconfig-001-20230915   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230914   gcc  
sparc                 randconfig-001-20230915   gcc  
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
x86_64       buildonly-randconfig-001-20230914   gcc  
x86_64       buildonly-randconfig-001-20230915   gcc  
x86_64       buildonly-randconfig-002-20230914   gcc  
x86_64       buildonly-randconfig-002-20230915   gcc  
x86_64       buildonly-randconfig-003-20230914   gcc  
x86_64       buildonly-randconfig-003-20230915   gcc  
x86_64       buildonly-randconfig-004-20230914   gcc  
x86_64       buildonly-randconfig-004-20230915   gcc  
x86_64       buildonly-randconfig-005-20230914   gcc  
x86_64       buildonly-randconfig-005-20230915   gcc  
x86_64       buildonly-randconfig-006-20230914   gcc  
x86_64       buildonly-randconfig-006-20230915   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230914   gcc  
x86_64                randconfig-001-20230915   gcc  
x86_64                randconfig-002-20230914   gcc  
x86_64                randconfig-002-20230915   gcc  
x86_64                randconfig-003-20230914   gcc  
x86_64                randconfig-003-20230915   gcc  
x86_64                randconfig-004-20230914   gcc  
x86_64                randconfig-004-20230915   gcc  
x86_64                randconfig-005-20230914   gcc  
x86_64                randconfig-005-20230915   gcc  
x86_64                randconfig-006-20230914   gcc  
x86_64                randconfig-006-20230915   gcc  
x86_64                randconfig-011-20230914   gcc  
x86_64                randconfig-011-20230915   gcc  
x86_64                randconfig-012-20230914   gcc  
x86_64                randconfig-012-20230915   gcc  
x86_64                randconfig-013-20230914   gcc  
x86_64                randconfig-013-20230915   gcc  
x86_64                randconfig-014-20230914   gcc  
x86_64                randconfig-014-20230915   gcc  
x86_64                randconfig-015-20230914   gcc  
x86_64                randconfig-015-20230915   gcc  
x86_64                randconfig-016-20230914   gcc  
x86_64                randconfig-016-20230915   gcc  
x86_64                randconfig-071-20230914   gcc  
x86_64                randconfig-071-20230915   gcc  
x86_64                randconfig-072-20230914   gcc  
x86_64                randconfig-072-20230915   gcc  
x86_64                randconfig-073-20230914   gcc  
x86_64                randconfig-073-20230915   gcc  
x86_64                randconfig-074-20230914   gcc  
x86_64                randconfig-074-20230915   gcc  
x86_64                randconfig-075-20230914   gcc  
x86_64                randconfig-075-20230915   gcc  
x86_64                randconfig-076-20230914   gcc  
x86_64                randconfig-076-20230915   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
