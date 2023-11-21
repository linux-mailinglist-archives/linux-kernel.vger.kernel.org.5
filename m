Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6900B7F3218
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjKUPQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjKUPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:16:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C7B83
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700579790; x=1732115790;
  h=date:from:to:cc:subject:message-id;
  bh=dkC/HVo3+6kaq4O4ZJvpfyzqsu7mHVlykMpFWFzYwAU=;
  b=e7Tl5tW32kKGdQ4FybSMcCSazLtcUA758VIjq93z99mSMS+SE1SYWxWx
   UKloOH8obejPeCEMH44K/19ccUcRdPoH2IRXHwC8lbTCa/RcRAa1lXiFg
   u8OZv3jT23GrS89gzlbrgckCK9vYMfuTOrp1hvsKHknsr204QX5QMzbyZ
   6euhHOzw8CrqWkvgFbmuIqtHLqHiLA7m2DbrhEMtci42NDn5Ylcq0gjJm
   NBoDVZ0+FZH1Ll21cJXjzlVXpt16qKiYHa5OrszoHP3iPYW5Yw5wpTtzE
   UedooWycv1TbcDUIOvJhfrN9JBubgyYjjCw1zGrLh4EJqr6wY96Pb5LlM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5054742"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="5054742"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:16:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="8116640"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Nov 2023 07:16:28 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5SUD-0007ww-1Z;
        Tue, 21 Nov 2023 15:16:25 +0000
Date:   Tue, 21 Nov 2023 23:15:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 bbb968696d0f3442ab823598def3b756cf4735c6
Message-ID: <202311212326.IcGnHqCR-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
branch HEAD: bbb968696d0f3442ab823598def3b756cf4735c6  perf/x86/intel/cstate: Add Grand Ridge support

elapsed time: 6040m

configs tested: 250
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20231118   gcc  
arc                   randconfig-001-20231121   gcc  
arc                   randconfig-002-20231118   gcc  
arc                   randconfig-002-20231121   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231118   gcc  
arm                   randconfig-001-20231121   gcc  
arm                   randconfig-002-20231118   gcc  
arm                   randconfig-002-20231121   gcc  
arm                   randconfig-003-20231118   gcc  
arm                   randconfig-003-20231121   gcc  
arm                   randconfig-004-20231118   gcc  
arm                   randconfig-004-20231121   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231118   gcc  
arm64                 randconfig-001-20231121   gcc  
arm64                 randconfig-002-20231118   gcc  
arm64                 randconfig-002-20231121   gcc  
arm64                 randconfig-003-20231118   gcc  
arm64                 randconfig-003-20231121   gcc  
arm64                 randconfig-004-20231118   gcc  
arm64                 randconfig-004-20231121   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231118   gcc  
csky                  randconfig-001-20231121   gcc  
csky                  randconfig-002-20231118   gcc  
csky                  randconfig-002-20231121   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231118   clang
hexagon               randconfig-001-20231121   clang
hexagon               randconfig-002-20231118   clang
hexagon               randconfig-002-20231121   clang
i386                             allmodconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231117   gcc  
i386         buildonly-randconfig-001-20231121   gcc  
i386         buildonly-randconfig-002-20231117   gcc  
i386         buildonly-randconfig-002-20231121   gcc  
i386         buildonly-randconfig-003-20231117   gcc  
i386         buildonly-randconfig-003-20231121   gcc  
i386         buildonly-randconfig-004-20231117   gcc  
i386         buildonly-randconfig-004-20231121   gcc  
i386         buildonly-randconfig-005-20231117   gcc  
i386         buildonly-randconfig-005-20231121   gcc  
i386         buildonly-randconfig-006-20231117   gcc  
i386         buildonly-randconfig-006-20231121   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231117   gcc  
i386                  randconfig-001-20231121   gcc  
i386                  randconfig-002-20231117   gcc  
i386                  randconfig-002-20231121   gcc  
i386                  randconfig-003-20231117   gcc  
i386                  randconfig-003-20231121   gcc  
i386                  randconfig-004-20231117   gcc  
i386                  randconfig-004-20231121   gcc  
i386                  randconfig-005-20231117   gcc  
i386                  randconfig-005-20231121   gcc  
i386                  randconfig-006-20231117   gcc  
i386                  randconfig-006-20231121   gcc  
i386                  randconfig-011-20231117   gcc  
i386                  randconfig-011-20231121   clang
i386                  randconfig-012-20231117   gcc  
i386                  randconfig-012-20231121   clang
i386                  randconfig-013-20231117   gcc  
i386                  randconfig-013-20231121   clang
i386                  randconfig-014-20231117   gcc  
i386                  randconfig-014-20231121   clang
i386                  randconfig-015-20231117   gcc  
i386                  randconfig-015-20231121   clang
i386                  randconfig-016-20231117   gcc  
i386                  randconfig-016-20231121   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231118   gcc  
loongarch             randconfig-001-20231121   gcc  
loongarch             randconfig-002-20231118   gcc  
loongarch             randconfig-002-20231121   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231118   gcc  
nios2                 randconfig-001-20231121   gcc  
nios2                 randconfig-002-20231118   gcc  
nios2                 randconfig-002-20231121   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231118   gcc  
parisc                randconfig-001-20231121   gcc  
parisc                randconfig-002-20231118   gcc  
parisc                randconfig-002-20231121   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231118   gcc  
powerpc               randconfig-001-20231121   gcc  
powerpc               randconfig-002-20231118   gcc  
powerpc               randconfig-002-20231121   gcc  
powerpc               randconfig-003-20231118   gcc  
powerpc               randconfig-003-20231121   gcc  
powerpc64             randconfig-001-20231118   gcc  
powerpc64             randconfig-001-20231121   gcc  
powerpc64             randconfig-002-20231118   gcc  
powerpc64             randconfig-002-20231121   gcc  
powerpc64             randconfig-003-20231118   gcc  
powerpc64             randconfig-003-20231121   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231118   gcc  
riscv                 randconfig-001-20231121   gcc  
riscv                 randconfig-002-20231118   gcc  
riscv                 randconfig-002-20231121   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231118   gcc  
s390                  randconfig-001-20231121   clang
s390                  randconfig-002-20231118   gcc  
s390                  randconfig-002-20231121   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231118   gcc  
sh                    randconfig-001-20231121   gcc  
sh                    randconfig-002-20231118   gcc  
sh                    randconfig-002-20231121   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231118   gcc  
sparc64               randconfig-001-20231121   gcc  
sparc64               randconfig-002-20231118   gcc  
sparc64               randconfig-002-20231121   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231118   gcc  
um                    randconfig-001-20231121   gcc  
um                    randconfig-002-20231118   gcc  
um                    randconfig-002-20231121   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231117   gcc  
x86_64       buildonly-randconfig-001-20231121   gcc  
x86_64       buildonly-randconfig-002-20231117   gcc  
x86_64       buildonly-randconfig-002-20231121   gcc  
x86_64       buildonly-randconfig-003-20231117   gcc  
x86_64       buildonly-randconfig-003-20231121   gcc  
x86_64       buildonly-randconfig-004-20231117   gcc  
x86_64       buildonly-randconfig-004-20231121   gcc  
x86_64       buildonly-randconfig-005-20231117   gcc  
x86_64       buildonly-randconfig-005-20231121   gcc  
x86_64       buildonly-randconfig-006-20231117   gcc  
x86_64       buildonly-randconfig-006-20231121   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231117   gcc  
x86_64                randconfig-001-20231121   clang
x86_64                randconfig-002-20231117   gcc  
x86_64                randconfig-002-20231121   clang
x86_64                randconfig-003-20231117   gcc  
x86_64                randconfig-003-20231121   clang
x86_64                randconfig-004-20231117   gcc  
x86_64                randconfig-004-20231121   clang
x86_64                randconfig-005-20231117   gcc  
x86_64                randconfig-005-20231121   clang
x86_64                randconfig-006-20231117   gcc  
x86_64                randconfig-006-20231121   clang
x86_64                randconfig-011-20231117   gcc  
x86_64                randconfig-011-20231121   gcc  
x86_64                randconfig-012-20231117   gcc  
x86_64                randconfig-012-20231121   gcc  
x86_64                randconfig-013-20231117   gcc  
x86_64                randconfig-013-20231121   gcc  
x86_64                randconfig-014-20231117   gcc  
x86_64                randconfig-014-20231121   gcc  
x86_64                randconfig-015-20231117   gcc  
x86_64                randconfig-015-20231121   gcc  
x86_64                randconfig-016-20231117   gcc  
x86_64                randconfig-016-20231121   gcc  
x86_64                randconfig-071-20231117   gcc  
x86_64                randconfig-071-20231121   gcc  
x86_64                randconfig-072-20231117   gcc  
x86_64                randconfig-072-20231121   gcc  
x86_64                randconfig-073-20231117   gcc  
x86_64                randconfig-073-20231121   gcc  
x86_64                randconfig-074-20231117   gcc  
x86_64                randconfig-074-20231121   gcc  
x86_64                randconfig-075-20231117   gcc  
x86_64                randconfig-075-20231121   gcc  
x86_64                randconfig-076-20231117   gcc  
x86_64                randconfig-076-20231121   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231118   gcc  
xtensa                randconfig-001-20231121   gcc  
xtensa                randconfig-002-20231118   gcc  
xtensa                randconfig-002-20231121   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
