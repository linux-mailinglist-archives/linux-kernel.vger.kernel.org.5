Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B7978992B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjHZVFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHZVFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:05:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C247E54
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693083913; x=1724619913;
  h=date:from:to:cc:subject:message-id;
  bh=GGyh7sxu0IzcA0Xl1ddjsFNJPZEv5g9o8Bvm1Dn57MA=;
  b=Fcd3epg2WRQJNuYiZTAuAapfpkrg9S4zRbvb23pAPl7c48DRS/znmIhh
   9T29AQthMUlz7Ab0pTuA9jpuXIV3m/BTUz3X0k0JP+fHLh9Y536C6jH1U
   UXmcjn1h1k62Mp+K947Vbn1pWooHbdYjgd0fN5zxjMRe4dqBriq4xgij5
   NYQhsmnr0SAS4KijmgPG3MRN+Fxpj93FpvnN6PUhYMOzLiYpXkGnFWeSf
   c80kA5NvUT4Z2cW2yL9+di4R43VNR2UQrwcTToqm+VCb998FBbfRwtNRW
   sJUhZTXuMD0v8/yxLIE+oR7cu32eXsedzuvyWn7AbT1SehJLb+Gv8jD5P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="372299223"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="372299223"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 14:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="827916820"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="827916820"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2023 14:05:11 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qa0T1-00055G-0o;
        Sat, 26 Aug 2023 21:05:11 +0000
Date:   Sun, 27 Aug 2023 05:03:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 2f88c8e802c8b128a155976631f4eb2ce4f3c805
Message-ID: <202308270540.o5Q8mma3-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 2f88c8e802c8b128a155976631f4eb2ce4f3c805  sched/eevdf/doc: Modify the documented knob to base_slice_ns as well

elapsed time: 2926m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230825   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230825   gcc  
arc                  randconfig-r023-20230825   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230825   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r035-20230825   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230825   gcc  
hexagon               randconfig-001-20230825   clang
hexagon               randconfig-002-20230825   clang
i386         buildonly-randconfig-001-20230825   clang
i386         buildonly-randconfig-002-20230825   clang
i386         buildonly-randconfig-003-20230825   clang
i386         buildonly-randconfig-004-20230825   clang
i386         buildonly-randconfig-005-20230825   clang
i386         buildonly-randconfig-006-20230825   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20230825   clang
i386                  randconfig-002-20230825   clang
i386                  randconfig-004-20230825   clang
i386                  randconfig-005-20230825   clang
i386                  randconfig-006-20230825   clang
i386                  randconfig-011-20230825   gcc  
i386                  randconfig-012-20230825   gcc  
i386                  randconfig-013-20230825   gcc  
i386                  randconfig-014-20230825   gcc  
i386                  randconfig-015-20230825   gcc  
i386                  randconfig-016-20230825   gcc  
i386                 randconfig-r004-20230825   clang
i386                 randconfig-r006-20230825   clang
i386                 randconfig-r016-20230825   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230825   gcc  
loongarch            randconfig-r012-20230825   gcc  
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
mips                 randconfig-r001-20230825   gcc  
mips                 randconfig-r002-20230825   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r025-20230825   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230825   gcc  
parisc               randconfig-r024-20230825   gcc  
parisc               randconfig-r033-20230825   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r034-20230825   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230825   clang
riscv                randconfig-r032-20230825   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230825   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r003-20230825   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230825   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r005-20230825   gcc  
sparc64              randconfig-r015-20230825   gcc  
sparc64              randconfig-r026-20230825   gcc  
sparc64              randconfig-r031-20230825   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230825   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230825   clang
x86_64       buildonly-randconfig-002-20230825   clang
x86_64       buildonly-randconfig-003-20230825   clang
x86_64       buildonly-randconfig-004-20230825   clang
x86_64       buildonly-randconfig-005-20230825   clang
x86_64       buildonly-randconfig-006-20230825   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230825   gcc  
x86_64                randconfig-002-20230825   gcc  
x86_64                randconfig-003-20230825   gcc  
x86_64                randconfig-004-20230825   gcc  
x86_64                randconfig-005-20230825   gcc  
x86_64                randconfig-006-20230825   gcc  
x86_64                randconfig-011-20230825   clang
x86_64                randconfig-012-20230825   clang
x86_64                randconfig-013-20230825   clang
x86_64                randconfig-014-20230825   clang
x86_64                randconfig-015-20230825   clang
x86_64                randconfig-016-20230825   clang
x86_64                randconfig-071-20230825   clang
x86_64                randconfig-072-20230825   clang
x86_64                randconfig-073-20230825   clang
x86_64                randconfig-074-20230825   clang
x86_64                randconfig-075-20230825   clang
x86_64                randconfig-076-20230825   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r022-20230825   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
