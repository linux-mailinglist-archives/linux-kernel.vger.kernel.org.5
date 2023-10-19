Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1427CF426
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjJSJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJSJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:37:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A48B8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697708225; x=1729244225;
  h=date:from:to:cc:subject:message-id;
  bh=8VDUix8X7UcoAcd4P1XInTXuQ7BPJSM+eqHhzib9yg4=;
  b=jyWszcKTjo0sdzLcDPry5UlRNYSLkrJGRw3IES0M9k5xFCUfp22gHruo
   BmwbmEuMC16kl2Lnlpyn82+OYCSKW2G/mwt9wpgYqTHuW4BcZ3ocQkz0S
   5F01n4t9kO6LmQOsCi+Dexw31MFVSPj46kv6SaRrVhxhhs6fw0W9uKeZd
   6hK+zhvcOv3h50woA+TJO++xFnkA+i4Oo1FRQvBsFfx0rZrcODrb8l27l
   lylV9NjVOaxpg9HlU16dxdC38RJQRoATsDSSBMfklskGbsMEyQPP1QvMX
   zBmME9jHQhy++dOGk+TR/M3bklEbyhktqRoxYncYwj6sSPMGEry7FGbC4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371275299"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="371275299"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 02:37:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733508087"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="733508087"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2023 02:37:03 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtPSf-0001vr-0q;
        Thu, 19 Oct 2023 09:37:01 +0000
Date:   Thu, 19 Oct 2023 17:36:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 41efa431244f6498833ff8ee8dde28c4924c5479
Message-ID: <202310191715.YbHVEuT2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 41efa431244f6498833ff8ee8dde28c4924c5479  PCI/MSI: Provide stubs for IMS functions

elapsed time: 2250m

configs tested: 183
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
arc                   randconfig-001-20231018   gcc  
arc                   randconfig-001-20231019   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231019   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231019   gcc  
i386         buildonly-randconfig-002-20231019   gcc  
i386         buildonly-randconfig-003-20231019   gcc  
i386         buildonly-randconfig-004-20231019   gcc  
i386         buildonly-randconfig-005-20231019   gcc  
i386         buildonly-randconfig-006-20231019   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231018   gcc  
i386                  randconfig-001-20231019   gcc  
i386                  randconfig-002-20231018   gcc  
i386                  randconfig-002-20231019   gcc  
i386                  randconfig-003-20231018   gcc  
i386                  randconfig-003-20231019   gcc  
i386                  randconfig-004-20231018   gcc  
i386                  randconfig-004-20231019   gcc  
i386                  randconfig-005-20231018   gcc  
i386                  randconfig-005-20231019   gcc  
i386                  randconfig-006-20231018   gcc  
i386                  randconfig-006-20231019   gcc  
i386                  randconfig-011-20231018   gcc  
i386                  randconfig-011-20231019   gcc  
i386                  randconfig-012-20231018   gcc  
i386                  randconfig-012-20231019   gcc  
i386                  randconfig-013-20231018   gcc  
i386                  randconfig-013-20231019   gcc  
i386                  randconfig-014-20231018   gcc  
i386                  randconfig-014-20231019   gcc  
i386                  randconfig-015-20231018   gcc  
i386                  randconfig-015-20231019   gcc  
i386                  randconfig-016-20231018   gcc  
i386                  randconfig-016-20231019   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231018   gcc  
loongarch             randconfig-001-20231019   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   microwatt_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231018   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231018   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231018   gcc  
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
x86_64       buildonly-randconfig-001-20231019   gcc  
x86_64       buildonly-randconfig-002-20231019   gcc  
x86_64       buildonly-randconfig-003-20231019   gcc  
x86_64       buildonly-randconfig-004-20231019   gcc  
x86_64       buildonly-randconfig-005-20231019   gcc  
x86_64       buildonly-randconfig-006-20231019   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231018   gcc  
x86_64                randconfig-001-20231019   gcc  
x86_64                randconfig-002-20231018   gcc  
x86_64                randconfig-002-20231019   gcc  
x86_64                randconfig-003-20231018   gcc  
x86_64                randconfig-003-20231019   gcc  
x86_64                randconfig-004-20231018   gcc  
x86_64                randconfig-004-20231019   gcc  
x86_64                randconfig-005-20231018   gcc  
x86_64                randconfig-005-20231019   gcc  
x86_64                randconfig-006-20231018   gcc  
x86_64                randconfig-006-20231019   gcc  
x86_64                randconfig-011-20231018   gcc  
x86_64                randconfig-011-20231019   gcc  
x86_64                randconfig-012-20231018   gcc  
x86_64                randconfig-012-20231019   gcc  
x86_64                randconfig-013-20231018   gcc  
x86_64                randconfig-013-20231019   gcc  
x86_64                randconfig-014-20231018   gcc  
x86_64                randconfig-014-20231019   gcc  
x86_64                randconfig-015-20231018   gcc  
x86_64                randconfig-015-20231019   gcc  
x86_64                randconfig-016-20231018   gcc  
x86_64                randconfig-016-20231019   gcc  
x86_64                randconfig-071-20231019   gcc  
x86_64                randconfig-072-20231019   gcc  
x86_64                randconfig-073-20231019   gcc  
x86_64                randconfig-074-20231019   gcc  
x86_64                randconfig-075-20231019   gcc  
x86_64                randconfig-076-20231019   gcc  
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
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
