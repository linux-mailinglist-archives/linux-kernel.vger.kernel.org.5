Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB97A29E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbjIOV6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjIOV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:57:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9906193
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694815054; x=1726351054;
  h=date:from:to:cc:subject:message-id;
  bh=z3lefPWbUN2Qf5w1LvRKwGlp4TnckHqJnoBxZ2PaOmU=;
  b=Krfyw0pxjmKnjUoJQOzSdQ7Jvte9ea8mf6gc+s4YoeNEP8LSeNqm/nxW
   QWVhu4gDbaGuEgHryIBAyE5D3bNGkyq12aimxw2PeiBqklWgXk1Gh5vWI
   AP/hyjIoQX6jGCUXV/XJE/LM5Yr+YbH92KQAzpV8Kwi2rkxg1J+ItGBcD
   vMye3Z6yx1pSPgBia/ueDfMO84N2attqJdtT9Oelwccbpzqq3N4ECIXlR
   IjEhBBw0DzFXlR9vdJd7XjJ/LB89JanZQRnZinNX8UxdWY7oGO4BpKfXO
   VCU1a5pN60ZNHsSfpuAqo76ao81VbYlwcgNKBnQ8WdQkIxTuctOdI8+Et
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383184173"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="383184173"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 14:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745151279"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="745151279"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Sep 2023 14:57:33 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhGod-0003Vw-0g;
        Fri, 15 Sep 2023 21:57:31 +0000
Date:   Sat, 16 Sep 2023 05:56:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 cccd32816506cbac3a4c65d9dff51b3125ef1a03
Message-ID: <202309160538.yVGTsCD8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: cccd32816506cbac3a4c65d9dff51b3125ef1a03  panic: Reenable preemption in WARN slowpath

elapsed time: 728m

configs tested: 150
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
arc                   randconfig-001-20230915   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20230915   gcc  
arm                        vexpress_defconfig   clang
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
i386         buildonly-randconfig-001-20230915   gcc  
i386         buildonly-randconfig-002-20230915   gcc  
i386         buildonly-randconfig-003-20230915   gcc  
i386         buildonly-randconfig-004-20230915   gcc  
i386         buildonly-randconfig-005-20230915   gcc  
i386         buildonly-randconfig-006-20230915   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230915   gcc  
i386                  randconfig-002-20230915   gcc  
i386                  randconfig-003-20230915   gcc  
i386                  randconfig-004-20230915   gcc  
i386                  randconfig-005-20230915   gcc  
i386                  randconfig-006-20230915   gcc  
i386                  randconfig-011-20230915   gcc  
i386                  randconfig-012-20230915   gcc  
i386                  randconfig-013-20230915   gcc  
i386                  randconfig-014-20230915   gcc  
i386                  randconfig-015-20230915   gcc  
i386                  randconfig-016-20230915   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230915   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                      loongson3_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            alldefconfig   gcc  
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
riscv                 randconfig-001-20230915   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230915   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20230915   gcc  
x86_64       buildonly-randconfig-002-20230915   gcc  
x86_64       buildonly-randconfig-003-20230915   gcc  
x86_64       buildonly-randconfig-004-20230915   gcc  
x86_64       buildonly-randconfig-005-20230915   gcc  
x86_64       buildonly-randconfig-006-20230915   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230915   gcc  
x86_64                randconfig-002-20230915   gcc  
x86_64                randconfig-003-20230915   gcc  
x86_64                randconfig-004-20230915   gcc  
x86_64                randconfig-005-20230915   gcc  
x86_64                randconfig-006-20230915   gcc  
x86_64                randconfig-011-20230915   gcc  
x86_64                randconfig-012-20230915   gcc  
x86_64                randconfig-013-20230915   gcc  
x86_64                randconfig-014-20230915   gcc  
x86_64                randconfig-015-20230915   gcc  
x86_64                randconfig-016-20230915   gcc  
x86_64                randconfig-071-20230915   gcc  
x86_64                randconfig-072-20230915   gcc  
x86_64                randconfig-073-20230915   gcc  
x86_64                randconfig-074-20230915   gcc  
x86_64                randconfig-075-20230915   gcc  
x86_64                randconfig-076-20230915   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
