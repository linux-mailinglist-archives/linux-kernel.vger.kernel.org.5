Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91017D1BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjJUImH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:42:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FD1A8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697877720; x=1729413720;
  h=date:from:to:cc:subject:message-id;
  bh=bbyFwiRd8DCmjQe/WrWEHmaRz8lZFbpTotVPNbgLEm8=;
  b=QiiAdBT6rute2bnqACkOaFc3y5eH1PCCO0VLuq5RMdaMRWonfAhRpOAn
   dxuVrAYje+25n9F24UDnJBLj9tQmKIlvuR6eDhFFWhFIURghYkOapkNx0
   RcDOioqQIGxPKj4zwNb7Ql4ThZJhNGWJuKxFS3Q5diN89WiLpxDqcQy3o
   CLVnuJJP9J4Q/v7n5p3+l21Nm6sEaeOY4TKRw7toQf+N4ZuyE8oueQVpe
   ACh0A78TiUrLQZ6sayZnURMVD6yhq6zK87rQL8He+ywYYLZXN6U12WNdw
   5LYLChUD7QZCntnNYV82Kl9jZ8QqMcOXzDENHWt9FRaLOfHgRTL2O/lXq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="371688376"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="371688376"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 01:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="751160906"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="751160906"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2023 01:41:58 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qu7YS-0004eE-1x;
        Sat, 21 Oct 2023 08:41:56 +0000
Date:   Sat, 21 Oct 2023 16:41:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 32671e3799ca2e4590773fd0e63aaa4229e50c06
Message-ID: <202310211645.hJSsajly-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 32671e3799ca2e4590773fd0e63aaa4229e50c06  perf: Disallow mis-matched inherited group reads

elapsed time: 2880m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231020   gcc  
arc                   randconfig-001-20231021   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20231021   gcc  
arm64                            alldefconfig   gcc  
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
i386         buildonly-randconfig-001-20231021   gcc  
i386         buildonly-randconfig-002-20231021   gcc  
i386         buildonly-randconfig-003-20231021   gcc  
i386         buildonly-randconfig-004-20231021   gcc  
i386         buildonly-randconfig-005-20231021   gcc  
i386         buildonly-randconfig-006-20231021   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231021   gcc  
i386                  randconfig-002-20231021   gcc  
i386                  randconfig-003-20231021   gcc  
i386                  randconfig-004-20231021   gcc  
i386                  randconfig-005-20231021   gcc  
i386                  randconfig-006-20231021   gcc  
i386                  randconfig-011-20231020   gcc  
i386                  randconfig-011-20231021   gcc  
i386                  randconfig-012-20231020   gcc  
i386                  randconfig-012-20231021   gcc  
i386                  randconfig-013-20231020   gcc  
i386                  randconfig-013-20231021   gcc  
i386                  randconfig-014-20231020   gcc  
i386                  randconfig-014-20231021   gcc  
i386                  randconfig-015-20231020   gcc  
i386                  randconfig-015-20231021   gcc  
i386                  randconfig-016-20231020   gcc  
i386                  randconfig-016-20231021   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231020   gcc  
loongarch             randconfig-001-20231021   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
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
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231020   gcc  
riscv                 randconfig-001-20231021   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231020   gcc  
s390                  randconfig-001-20231021   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231020   gcc  
sparc                 randconfig-001-20231021   gcc  
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
x86_64       buildonly-randconfig-001-20231020   gcc  
x86_64       buildonly-randconfig-001-20231021   gcc  
x86_64       buildonly-randconfig-002-20231020   gcc  
x86_64       buildonly-randconfig-002-20231021   gcc  
x86_64       buildonly-randconfig-003-20231020   gcc  
x86_64       buildonly-randconfig-003-20231021   gcc  
x86_64       buildonly-randconfig-004-20231020   gcc  
x86_64       buildonly-randconfig-004-20231021   gcc  
x86_64       buildonly-randconfig-005-20231020   gcc  
x86_64       buildonly-randconfig-005-20231021   gcc  
x86_64       buildonly-randconfig-006-20231020   gcc  
x86_64       buildonly-randconfig-006-20231021   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231021   gcc  
x86_64                randconfig-002-20231021   gcc  
x86_64                randconfig-003-20231021   gcc  
x86_64                randconfig-004-20231021   gcc  
x86_64                randconfig-005-20231021   gcc  
x86_64                randconfig-006-20231021   gcc  
x86_64                randconfig-011-20231021   gcc  
x86_64                randconfig-012-20231021   gcc  
x86_64                randconfig-013-20231021   gcc  
x86_64                randconfig-014-20231021   gcc  
x86_64                randconfig-015-20231021   gcc  
x86_64                randconfig-016-20231021   gcc  
x86_64                randconfig-071-20231021   gcc  
x86_64                randconfig-072-20231021   gcc  
x86_64                randconfig-073-20231021   gcc  
x86_64                randconfig-074-20231021   gcc  
x86_64                randconfig-075-20231021   gcc  
x86_64                randconfig-076-20231021   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
