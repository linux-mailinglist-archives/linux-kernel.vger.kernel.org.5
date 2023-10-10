Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1366B7BFAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJJMCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjJJMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:02:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA681A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696939262; x=1728475262;
  h=date:from:to:cc:subject:message-id;
  bh=0X0YyvKj1DLxiFZ2dZ8UNUJLd5beuJziKRdiFFjvyaw=;
  b=ELEVRXsucpwh7E5ROOHY7O7IHaSG7fdawjoVJDHvsrHzAUkl2FVgMHlc
   RxzEQrGoC+QFZlF39ud5XUhcb32lwMlayjWfRTezzfxSoF9PSwagP3P4T
   Yy+LL3MKECGBzJPeLa67MlxqTFjJ2BpR6PUxXL+yJmdPvnsNok5lczluf
   Aqgr962KsH2kf+ji4pU6JuK/ft8LnLw5uJqE/cY9nGugbeVY9HYuUO5Aa
   /+EG19VdadydBiap3skVtTkVmZdnxleZ3AL6Wo5j7YByIFqKiBMdlYU+K
   7wSeeezcPc3WHLDqYMNoPFOCKQll+IbdLGXcBLm48bly3oFKjdXAwuxT/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="383252506"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="383252506"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 05:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000664890"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1000664890"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2023 05:01:00 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqBQ1-0000Mx-1t;
        Tue, 10 Oct 2023 12:00:57 +0000
Date:   Tue, 10 Oct 2023 20:00:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 9975802d3f7426abc32fd9ac0924a639d11a7c4f
Message-ID: <202310102021.tMJk8l1p-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 9975802d3f7426abc32fd9ac0924a639d11a7c4f  x86/microcode/intel: Add a minimum required revision for late loading

elapsed time: 1301m

configs tested: 163
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
arc                   randconfig-001-20231009   gcc  
arc                   randconfig-001-20231010   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231009   gcc  
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
i386         buildonly-randconfig-001-20231009   gcc  
i386         buildonly-randconfig-002-20231009   gcc  
i386         buildonly-randconfig-003-20231009   gcc  
i386         buildonly-randconfig-004-20231009   gcc  
i386         buildonly-randconfig-005-20231009   gcc  
i386         buildonly-randconfig-006-20231009   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231010   gcc  
i386                  randconfig-002-20231010   gcc  
i386                  randconfig-003-20231010   gcc  
i386                  randconfig-004-20231010   gcc  
i386                  randconfig-005-20231010   gcc  
i386                  randconfig-006-20231010   gcc  
i386                  randconfig-011-20231009   gcc  
i386                  randconfig-012-20231009   gcc  
i386                  randconfig-013-20231009   gcc  
i386                  randconfig-014-20231009   gcc  
i386                  randconfig-015-20231009   gcc  
i386                  randconfig-016-20231009   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231009   gcc  
loongarch             randconfig-001-20231010   gcc  
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
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231009   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231009   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231010   gcc  
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
x86_64       buildonly-randconfig-001-20231009   gcc  
x86_64       buildonly-randconfig-001-20231010   gcc  
x86_64       buildonly-randconfig-002-20231009   gcc  
x86_64       buildonly-randconfig-002-20231010   gcc  
x86_64       buildonly-randconfig-003-20231009   gcc  
x86_64       buildonly-randconfig-003-20231010   gcc  
x86_64       buildonly-randconfig-004-20231009   gcc  
x86_64       buildonly-randconfig-004-20231010   gcc  
x86_64       buildonly-randconfig-005-20231009   gcc  
x86_64       buildonly-randconfig-005-20231010   gcc  
x86_64       buildonly-randconfig-006-20231009   gcc  
x86_64       buildonly-randconfig-006-20231010   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231009   gcc  
x86_64                randconfig-001-20231010   gcc  
x86_64                randconfig-002-20231009   gcc  
x86_64                randconfig-002-20231010   gcc  
x86_64                randconfig-003-20231009   gcc  
x86_64                randconfig-003-20231010   gcc  
x86_64                randconfig-004-20231009   gcc  
x86_64                randconfig-004-20231010   gcc  
x86_64                randconfig-005-20231009   gcc  
x86_64                randconfig-005-20231010   gcc  
x86_64                randconfig-006-20231009   gcc  
x86_64                randconfig-006-20231010   gcc  
x86_64                randconfig-011-20231009   gcc  
x86_64                randconfig-011-20231010   gcc  
x86_64                randconfig-012-20231009   gcc  
x86_64                randconfig-012-20231010   gcc  
x86_64                randconfig-013-20231009   gcc  
x86_64                randconfig-013-20231010   gcc  
x86_64                randconfig-014-20231009   gcc  
x86_64                randconfig-014-20231010   gcc  
x86_64                randconfig-015-20231009   gcc  
x86_64                randconfig-015-20231010   gcc  
x86_64                randconfig-016-20231009   gcc  
x86_64                randconfig-016-20231010   gcc  
x86_64                randconfig-071-20231009   gcc  
x86_64                randconfig-071-20231010   gcc  
x86_64                randconfig-072-20231009   gcc  
x86_64                randconfig-072-20231010   gcc  
x86_64                randconfig-073-20231009   gcc  
x86_64                randconfig-073-20231010   gcc  
x86_64                randconfig-074-20231009   gcc  
x86_64                randconfig-074-20231010   gcc  
x86_64                randconfig-075-20231009   gcc  
x86_64                randconfig-075-20231010   gcc  
x86_64                randconfig-076-20231009   gcc  
x86_64                randconfig-076-20231010   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
