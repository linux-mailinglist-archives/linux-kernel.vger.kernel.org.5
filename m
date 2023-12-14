Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029F812BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443460AbjLNJj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjLNJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:39:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D0B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702546773; x=1734082773;
  h=date:from:to:cc:subject:message-id;
  bh=DC5SVfG1sC3LkF/RuMaDOAwZMvLP1eW6nxOclUl0msY=;
  b=JODssRkfsiTUTiv6KL3RmKSSTk1Tvd1mcUW24R8RdnaMxulQ/TABL8l9
   f5QLRGl/bKPrKF40mbyLFiA5rk64UUfZnjOYsV8mSkzs22kqnKtwl0lFs
   gZbAkHFuEhULEQtNhpXBOvFv+oUTDocQquD8V1i2PpKsDDfS7AAU2Sxxh
   YOyPvWYH1qempGUTooc2X6j3b69+bTo0+PdtR0eIPlvcGrYFLG6mCOQiq
   K1bFWCV9vPiXOgqtpCLv4ynV22cbdmr9iWoRd5VePp1fvgewF2ZZ9K/LU
   Cc2P6FLfEu6lpGVWdbNxqlLXrQ33yUM0WxCuP+BdpupypGRvXfkOcfEpv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394842214"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="394842214"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021448527"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1021448527"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2023 01:39:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDiBm-000LrH-0f;
        Thu, 14 Dec 2023 09:39:30 +0000
Date:   Thu, 14 Dec 2023 17:39:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 30579c8baa5b4bd986420a984dad2940f1ff65d3
Message-ID: <202312141706.Hxb58TNl-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 30579c8baa5b4bd986420a984dad2940f1ff65d3  x86/sev: Do the C-bit verification only on the BSP

elapsed time: 778m

configs tested: 144
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231214   gcc  
arc                   randconfig-002-20231214   gcc  
arm                               allnoconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20231214   gcc  
arm                   randconfig-002-20231214   gcc  
arm                   randconfig-003-20231214   gcc  
arm                   randconfig-004-20231214   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231214   gcc  
arm64                 randconfig-002-20231214   gcc  
arm64                 randconfig-003-20231214   gcc  
arm64                 randconfig-004-20231214   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231214   gcc  
csky                  randconfig-002-20231214   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231214   gcc  
i386         buildonly-randconfig-002-20231214   gcc  
i386         buildonly-randconfig-003-20231214   gcc  
i386         buildonly-randconfig-004-20231214   gcc  
i386         buildonly-randconfig-005-20231214   gcc  
i386         buildonly-randconfig-006-20231214   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231214   gcc  
i386                  randconfig-002-20231214   gcc  
i386                  randconfig-003-20231214   gcc  
i386                  randconfig-004-20231214   gcc  
i386                  randconfig-005-20231214   gcc  
i386                  randconfig-006-20231214   gcc  
i386                  randconfig-011-20231214   clang
i386                  randconfig-012-20231214   clang
i386                  randconfig-013-20231214   clang
i386                  randconfig-014-20231214   clang
i386                  randconfig-015-20231214   clang
i386                  randconfig-016-20231214   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231214   gcc  
loongarch             randconfig-002-20231214   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231214   gcc  
nios2                 randconfig-002-20231214   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231214   gcc  
parisc                randconfig-002-20231214   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231214   gcc  
powerpc               randconfig-002-20231214   gcc  
powerpc               randconfig-003-20231214   gcc  
powerpc64             randconfig-001-20231214   gcc  
powerpc64             randconfig-002-20231214   gcc  
powerpc64             randconfig-003-20231214   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231214   gcc  
riscv                 randconfig-002-20231214   gcc  
riscv                          rv32_defconfig   clang
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231214   gcc  
sh                    randconfig-002-20231214   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231214   gcc  
sparc64               randconfig-002-20231214   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231214   gcc  
um                    randconfig-002-20231214   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231214   gcc  
x86_64       buildonly-randconfig-002-20231214   gcc  
x86_64       buildonly-randconfig-003-20231214   gcc  
x86_64       buildonly-randconfig-004-20231214   gcc  
x86_64       buildonly-randconfig-005-20231214   gcc  
x86_64       buildonly-randconfig-006-20231214   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231214   gcc  
x86_64                randconfig-012-20231214   gcc  
x86_64                randconfig-013-20231214   gcc  
x86_64                randconfig-014-20231214   gcc  
x86_64                randconfig-015-20231214   gcc  
x86_64                randconfig-016-20231214   gcc  
x86_64                randconfig-071-20231214   gcc  
x86_64                randconfig-072-20231214   gcc  
x86_64                randconfig-073-20231214   gcc  
x86_64                randconfig-074-20231214   gcc  
x86_64                randconfig-075-20231214   gcc  
x86_64                randconfig-076-20231214   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231214   gcc  
xtensa                randconfig-002-20231214   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
