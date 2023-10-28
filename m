Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23C7DA5C5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjJ1IRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1IRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:17:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6FEAB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698481036; x=1730017036;
  h=date:from:to:cc:subject:message-id;
  bh=43Mu7krT2Mwst9yKqLOkVTWgwHdEyd716azADUUait8=;
  b=cIQLJjaK1UuYEiqe2rioCLGPzdwVIw9gwtumTtUWOhMbqjelvUmB0dA3
   6rfiYv4E9vdFCAbYSy1aCL3/o7uob0eIxY6mLCFgVC38HPIyg4gIEMZuq
   chk9nx3B6VwEYg3yqROIGdOhysoAP1QlrkX2naTTuevQj6divpEqwvDUZ
   ENESAcsGYYfHshAobCkH1hNyWacfjSzqaOtncgG6sCQFlL+POy86nf1yo
   +IQzm64xn+ujg4pNkhPMWAtHhwgW0qMDWHHNKqUsm9RWjF/jVQwgQqJXX
   rTgQmTPwefi/f4D/trxNXFBwoKagwvTaKzznoSLgvFZmZGCzgwvWNHGLW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="390749115"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="390749115"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 01:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="763458341"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="763458341"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Oct 2023 01:17:14 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qweVM-000BaK-2R;
        Sat, 28 Oct 2023 08:17:12 +0000
Date:   Sat, 28 Oct 2023 16:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 33744916196b4ed7a50f6f47af7c3ad46b730ce6
Message-ID: <202310281625.91piKyBh-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 33744916196b4ed7a50f6f47af7c3ad46b730ce6  perf/x86/intel: Support branch counters logging

elapsed time: 1090m

configs tested: 197
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
arc                        nsim_700_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20231027   gcc  
arc                   randconfig-001-20231028   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20231027   gcc  
arm                   randconfig-001-20231028   gcc  
arm                         vf610m4_defconfig   gcc  
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
i386         buildonly-randconfig-001-20231027   gcc  
i386         buildonly-randconfig-001-20231028   gcc  
i386         buildonly-randconfig-002-20231027   gcc  
i386         buildonly-randconfig-002-20231028   gcc  
i386         buildonly-randconfig-003-20231027   gcc  
i386         buildonly-randconfig-003-20231028   gcc  
i386         buildonly-randconfig-004-20231027   gcc  
i386         buildonly-randconfig-004-20231028   gcc  
i386         buildonly-randconfig-005-20231027   gcc  
i386         buildonly-randconfig-005-20231028   gcc  
i386         buildonly-randconfig-006-20231027   gcc  
i386         buildonly-randconfig-006-20231028   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231027   gcc  
i386                  randconfig-001-20231028   gcc  
i386                  randconfig-002-20231027   gcc  
i386                  randconfig-002-20231028   gcc  
i386                  randconfig-003-20231027   gcc  
i386                  randconfig-003-20231028   gcc  
i386                  randconfig-004-20231027   gcc  
i386                  randconfig-004-20231028   gcc  
i386                  randconfig-005-20231027   gcc  
i386                  randconfig-005-20231028   gcc  
i386                  randconfig-006-20231027   gcc  
i386                  randconfig-006-20231028   gcc  
i386                  randconfig-011-20231027   gcc  
i386                  randconfig-011-20231028   gcc  
i386                  randconfig-012-20231027   gcc  
i386                  randconfig-012-20231028   gcc  
i386                  randconfig-013-20231027   gcc  
i386                  randconfig-013-20231028   gcc  
i386                  randconfig-014-20231027   gcc  
i386                  randconfig-014-20231028   gcc  
i386                  randconfig-015-20231027   gcc  
i386                  randconfig-015-20231028   gcc  
i386                  randconfig-016-20231027   gcc  
i386                  randconfig-016-20231028   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231027   gcc  
loongarch             randconfig-001-20231028   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
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
openrisc                    or1ksim_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc64                           defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231028   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231028   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231028   gcc  
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
x86_64       buildonly-randconfig-001-20231028   gcc  
x86_64       buildonly-randconfig-002-20231028   gcc  
x86_64       buildonly-randconfig-003-20231028   gcc  
x86_64       buildonly-randconfig-004-20231028   gcc  
x86_64       buildonly-randconfig-005-20231028   gcc  
x86_64       buildonly-randconfig-006-20231028   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231027   gcc  
x86_64                randconfig-001-20231028   gcc  
x86_64                randconfig-002-20231027   gcc  
x86_64                randconfig-002-20231028   gcc  
x86_64                randconfig-003-20231027   gcc  
x86_64                randconfig-003-20231028   gcc  
x86_64                randconfig-004-20231027   gcc  
x86_64                randconfig-004-20231028   gcc  
x86_64                randconfig-005-20231027   gcc  
x86_64                randconfig-005-20231028   gcc  
x86_64                randconfig-006-20231027   gcc  
x86_64                randconfig-006-20231028   gcc  
x86_64                randconfig-011-20231027   gcc  
x86_64                randconfig-011-20231028   gcc  
x86_64                randconfig-012-20231027   gcc  
x86_64                randconfig-012-20231028   gcc  
x86_64                randconfig-013-20231027   gcc  
x86_64                randconfig-013-20231028   gcc  
x86_64                randconfig-014-20231027   gcc  
x86_64                randconfig-014-20231028   gcc  
x86_64                randconfig-015-20231027   gcc  
x86_64                randconfig-015-20231028   gcc  
x86_64                randconfig-016-20231027   gcc  
x86_64                randconfig-016-20231028   gcc  
x86_64                randconfig-071-20231027   gcc  
x86_64                randconfig-071-20231028   gcc  
x86_64                randconfig-072-20231027   gcc  
x86_64                randconfig-072-20231028   gcc  
x86_64                randconfig-073-20231027   gcc  
x86_64                randconfig-073-20231028   gcc  
x86_64                randconfig-074-20231027   gcc  
x86_64                randconfig-074-20231028   gcc  
x86_64                randconfig-075-20231027   gcc  
x86_64                randconfig-075-20231028   gcc  
x86_64                randconfig-076-20231027   gcc  
x86_64                randconfig-076-20231028   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
