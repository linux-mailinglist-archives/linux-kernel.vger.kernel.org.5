Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B0F7E935E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 00:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjKLXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 18:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 18:37:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC41BFB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 15:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699832263; x=1731368263;
  h=date:from:to:cc:subject:message-id;
  bh=TF52vms0dcM5QUvanhQ+I6TROnvAGhYf8FX+3SVtJ4c=;
  b=Q8GBH9X0KuSJTCeSc+Y+051qTRFVtKjYkiOnYBN1k3BPQb24EnJJGhFf
   +yDq1pPkeRgVjktN0iSGxZwu/VBAQRhafYYDg+j9IopO1w66VdAK4MLXs
   szI6D8WbOKY9GVHf3CIkIgC11IgtwJCwKU+M4Pa6YkfiofvMvHrp/lMi8
   Qs8Zgxv+xNlZnEp7OPx5dornZfNGh3mUFwCCPsdLCMWCl8b4ijBzZRfmQ
   CuYPvb0KBXKQTOtP31nZduH6nLgeUBk4+T+f2x9xTrs3xz5zmqJUAwxrp
   gkapJ1NIOjT7+1hPUTF1UD9S3WIDxPZmb7uNdPRHs2/cCsO9PEUc6lyqF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="393224115"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="393224115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 15:37:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="5516298"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Nov 2023 15:37:41 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2K1K-000BcS-30;
        Sun, 12 Nov 2023 23:37:38 +0000
Date:   Mon, 13 Nov 2023 07:37:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1a88df0f443a4c2512a9062668bb09351c0cda86
Message-ID: <202311130701.bzjjzTue-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1a88df0f443a4c2512a9062668bb09351c0cda86  Merge branch into tip/master: 'x86/percpu'

elapsed time: 721m

configs tested: 195
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
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231112   gcc  
arc                   randconfig-002-20231112   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231112   gcc  
arm                   randconfig-002-20231112   gcc  
arm                   randconfig-003-20231112   gcc  
arm                   randconfig-004-20231112   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231112   gcc  
arm64                 randconfig-002-20231112   gcc  
arm64                 randconfig-003-20231112   gcc  
arm64                 randconfig-004-20231112   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231112   gcc  
csky                  randconfig-002-20231112   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231112   gcc  
i386         buildonly-randconfig-002-20231112   gcc  
i386         buildonly-randconfig-003-20231112   gcc  
i386         buildonly-randconfig-004-20231112   gcc  
i386         buildonly-randconfig-005-20231112   gcc  
i386         buildonly-randconfig-006-20231112   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231112   gcc  
i386                  randconfig-002-20231112   gcc  
i386                  randconfig-003-20231112   gcc  
i386                  randconfig-004-20231112   gcc  
i386                  randconfig-005-20231112   gcc  
i386                  randconfig-006-20231112   gcc  
i386                  randconfig-011-20231112   gcc  
i386                  randconfig-012-20231112   gcc  
i386                  randconfig-013-20231112   gcc  
i386                  randconfig-014-20231112   gcc  
i386                  randconfig-015-20231112   gcc  
i386                  randconfig-016-20231112   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231112   gcc  
loongarch             randconfig-002-20231112   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231112   gcc  
nios2                 randconfig-002-20231112   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231112   gcc  
parisc                randconfig-002-20231112   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231112   gcc  
powerpc               randconfig-002-20231112   gcc  
powerpc               randconfig-003-20231112   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc64             randconfig-001-20231112   gcc  
powerpc64             randconfig-002-20231112   gcc  
powerpc64             randconfig-003-20231112   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231112   gcc  
riscv                 randconfig-002-20231112   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231112   gcc  
s390                  randconfig-002-20231112   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20231112   gcc  
sh                    randconfig-002-20231112   gcc  
sh                           se7343_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231112   gcc  
sparc                 randconfig-002-20231112   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231112   gcc  
sparc64               randconfig-002-20231112   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231112   gcc  
um                    randconfig-002-20231112   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231112   gcc  
x86_64       buildonly-randconfig-002-20231112   gcc  
x86_64       buildonly-randconfig-003-20231112   gcc  
x86_64       buildonly-randconfig-004-20231112   gcc  
x86_64       buildonly-randconfig-005-20231112   gcc  
x86_64       buildonly-randconfig-006-20231112   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231112   gcc  
x86_64                randconfig-002-20231112   gcc  
x86_64                randconfig-003-20231112   gcc  
x86_64                randconfig-004-20231112   gcc  
x86_64                randconfig-005-20231112   gcc  
x86_64                randconfig-006-20231112   gcc  
x86_64                randconfig-011-20231112   gcc  
x86_64                randconfig-012-20231112   gcc  
x86_64                randconfig-013-20231112   gcc  
x86_64                randconfig-014-20231112   gcc  
x86_64                randconfig-015-20231112   gcc  
x86_64                randconfig-016-20231112   gcc  
x86_64                randconfig-071-20231112   gcc  
x86_64                randconfig-072-20231112   gcc  
x86_64                randconfig-073-20231112   gcc  
x86_64                randconfig-074-20231112   gcc  
x86_64                randconfig-075-20231112   gcc  
x86_64                randconfig-076-20231112   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231112   gcc  
xtensa                randconfig-002-20231112   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
