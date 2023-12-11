Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10980CA37
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjLKMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjLKMt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:49:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B697C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702299005; x=1733835005;
  h=date:from:to:cc:subject:message-id;
  bh=+4ow4LALsHp5rRbMW7QcTrFZzDkqWhVUrmmWbQS34eU=;
  b=RO58zfqSTYiPsjYINYgL1zZLaB0KMRncDF8xJB7lV50ay0LS9kWPluEZ
   ibF/82rBnkjnD8J+r+7N2FBFZ/bLDFLblDy9k/MYkK2JGDrGf8ByisGh/
   oIZslRYWHNjR+YgcN9SnYrGTw1IUuixlCE9z3u2AJJDjXdFUpG0+eXdez
   W3vcZnkZb/6VxJW6txez1h/vRz6ZCkZeTOhlxpaC7OZrnPiaEA3tyTRV3
   1DHpoYhcht7jlAk/daL7jJO/aqZixar3zcbLG9y4u9KSwGLGkCWq5Sp2d
   t+djd+TcKThTiVNooeltdd/ECFqJqXrwWYUkfhv+dBtSo+GuH7uBM9/mS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1760817"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1760817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="916832213"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="916832213"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2023 04:50:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCfjV-000I28-1H;
        Mon, 11 Dec 2023 12:50:01 +0000
Date:   Mon, 11 Dec 2023 20:49:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/merge] BUILD SUCCESS
 39c4930c8b6885eadebe02968a845dd6c7b2ac31
Message-ID: <202312112027.13JJRnV4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge
branch HEAD: 39c4930c8b6885eadebe02968a845dd6c7b2ac31  Merge branch 'irq/core' into core/merge, to help integration testing

elapsed time: 1447m

configs tested: 187
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
arc                     nsimosci_hs_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231211   gcc  
arc                   randconfig-002-20231211   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231211   gcc  
csky                  randconfig-002-20231211   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231210   gcc  
i386         buildonly-randconfig-002-20231210   gcc  
i386         buildonly-randconfig-003-20231210   gcc  
i386         buildonly-randconfig-004-20231210   gcc  
i386         buildonly-randconfig-005-20231210   gcc  
i386         buildonly-randconfig-006-20231210   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231210   gcc  
i386                  randconfig-002-20231210   gcc  
i386                  randconfig-003-20231210   gcc  
i386                  randconfig-004-20231210   gcc  
i386                  randconfig-005-20231210   gcc  
i386                  randconfig-006-20231210   gcc  
i386                  randconfig-011-20231210   clang
i386                  randconfig-011-20231211   gcc  
i386                  randconfig-012-20231210   clang
i386                  randconfig-012-20231211   gcc  
i386                  randconfig-013-20231210   clang
i386                  randconfig-013-20231211   gcc  
i386                  randconfig-014-20231210   clang
i386                  randconfig-014-20231211   gcc  
i386                  randconfig-015-20231210   clang
i386                  randconfig-015-20231211   gcc  
i386                  randconfig-016-20231210   clang
i386                  randconfig-016-20231211   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231211   gcc  
loongarch             randconfig-002-20231211   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           ip28_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231211   gcc  
nios2                 randconfig-002-20231211   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231211   gcc  
parisc                randconfig-002-20231211   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231211   gcc  
s390                  randconfig-002-20231211   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20231211   gcc  
sh                    randconfig-002-20231211   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231211   gcc  
sparc64               randconfig-002-20231211   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231211   clang
x86_64       buildonly-randconfig-002-20231211   clang
x86_64       buildonly-randconfig-003-20231211   clang
x86_64       buildonly-randconfig-004-20231211   clang
x86_64       buildonly-randconfig-005-20231211   clang
x86_64       buildonly-randconfig-006-20231211   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231211   clang
x86_64                randconfig-012-20231211   clang
x86_64                randconfig-013-20231211   clang
x86_64                randconfig-014-20231211   clang
x86_64                randconfig-015-20231211   clang
x86_64                randconfig-016-20231211   clang
x86_64                randconfig-071-20231211   clang
x86_64                randconfig-072-20231211   clang
x86_64                randconfig-073-20231211   clang
x86_64                randconfig-074-20231211   clang
x86_64                randconfig-075-20231211   clang
x86_64                randconfig-076-20231211   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231211   gcc  
xtensa                randconfig-002-20231211   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
