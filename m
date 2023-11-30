Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB45D7FEE62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjK3L7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjK3L7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:59:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0984
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701345550; x=1732881550;
  h=date:from:to:cc:subject:message-id;
  bh=I0tjpylONZTrHrZ4cXFxPqijxi/gZrFJH88j488/1ZM=;
  b=Z6XURQymtKZ1USBn3qral+9P6uovDX/HBe3iVtpMK2n0vqmhmpwKqEUW
   TZvt+X2WTDYdaITXIuDYLqXB/WT6FB/uE6LeFPNwwWSzlOkWjntV/f8Gq
   BNa8DqTDR7OdotC9+sz29hwE7naY4UFAwgtunk0/EHziDpaV11VuwONZc
   3T83az9JZaE7r8ROXPekki1ggCAD07s09Qu6EE7yOafGN1rdjLf+jtcsB
   fKLH9Tz+xhmmz9C22EW83cwDURYN5da/anlS3AvSONf1lhgUhDPr+X4/b
   V3QN/dgWi33NCVf4lNt8/Le0ofBCuq8SJzDrcnt8vGbkzf7oSyaK+Mijc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392178131"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392178131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798262780"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798262780"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Nov 2023 03:59:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8fhB-0001oY-0e;
        Thu, 30 Nov 2023 11:59:05 +0000
Date:   Thu, 30 Nov 2023 19:58:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 47b744ea5e3cf855087951a74ba9f89180fa1ba5
Message-ID: <202311301958.nlwd0ydU-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 47b744ea5e3cf855087951a74ba9f89180fa1ba5  x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types

elapsed time: 1470m

configs tested: 258
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20231129   gcc  
arc                   randconfig-001-20231130   gcc  
arc                   randconfig-002-20231129   gcc  
arc                   randconfig-002-20231130   gcc  
arm                               allnoconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                   randconfig-001-20231129   gcc  
arm                   randconfig-001-20231130   gcc  
arm                   randconfig-002-20231129   gcc  
arm                   randconfig-002-20231130   gcc  
arm                   randconfig-003-20231129   gcc  
arm                   randconfig-003-20231130   gcc  
arm                   randconfig-004-20231129   gcc  
arm                   randconfig-004-20231130   gcc  
arm                        realview_defconfig   gcc  
arm                       spear13xx_defconfig   clang
arm                           stm32_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231129   gcc  
arm64                 randconfig-001-20231130   gcc  
arm64                 randconfig-002-20231129   gcc  
arm64                 randconfig-002-20231130   gcc  
arm64                 randconfig-003-20231129   gcc  
arm64                 randconfig-003-20231130   gcc  
arm64                 randconfig-004-20231129   gcc  
arm64                 randconfig-004-20231130   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231129   gcc  
csky                  randconfig-001-20231130   gcc  
csky                  randconfig-002-20231129   gcc  
csky                  randconfig-002-20231130   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231129   clang
i386                  randconfig-011-20231130   clang
i386                  randconfig-012-20231129   clang
i386                  randconfig-012-20231130   clang
i386                  randconfig-013-20231129   clang
i386                  randconfig-013-20231130   clang
i386                  randconfig-014-20231129   clang
i386                  randconfig-014-20231130   clang
i386                  randconfig-015-20231129   clang
i386                  randconfig-015-20231130   clang
i386                  randconfig-016-20231129   clang
i386                  randconfig-016-20231130   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231129   gcc  
loongarch             randconfig-001-20231130   gcc  
loongarch             randconfig-002-20231129   gcc  
loongarch             randconfig-002-20231130   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                      loongson3_defconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                           rs90_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231129   gcc  
nios2                 randconfig-001-20231130   gcc  
nios2                 randconfig-002-20231129   gcc  
nios2                 randconfig-002-20231130   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20231129   gcc  
parisc                randconfig-001-20231130   gcc  
parisc                randconfig-002-20231129   gcc  
parisc                randconfig-002-20231130   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                   motionpro_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231129   gcc  
powerpc               randconfig-001-20231130   gcc  
powerpc               randconfig-002-20231129   gcc  
powerpc               randconfig-002-20231130   gcc  
powerpc               randconfig-003-20231129   gcc  
powerpc               randconfig-003-20231130   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20231129   gcc  
powerpc64             randconfig-001-20231130   gcc  
powerpc64             randconfig-002-20231129   gcc  
powerpc64             randconfig-002-20231130   gcc  
powerpc64             randconfig-003-20231129   gcc  
powerpc64             randconfig-003-20231130   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231129   gcc  
riscv                 randconfig-001-20231130   gcc  
riscv                 randconfig-002-20231129   gcc  
riscv                 randconfig-002-20231130   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20231129   gcc  
sh                    randconfig-001-20231130   gcc  
sh                    randconfig-002-20231129   gcc  
sh                    randconfig-002-20231130   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231129   gcc  
sparc64               randconfig-001-20231130   gcc  
sparc64               randconfig-002-20231129   gcc  
sparc64               randconfig-002-20231130   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231129   gcc  
um                    randconfig-001-20231130   gcc  
um                    randconfig-002-20231129   gcc  
um                    randconfig-002-20231130   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231129   gcc  
x86_64       buildonly-randconfig-001-20231130   gcc  
x86_64       buildonly-randconfig-002-20231129   gcc  
x86_64       buildonly-randconfig-002-20231130   gcc  
x86_64       buildonly-randconfig-003-20231129   gcc  
x86_64       buildonly-randconfig-003-20231130   gcc  
x86_64       buildonly-randconfig-004-20231129   gcc  
x86_64       buildonly-randconfig-004-20231130   gcc  
x86_64       buildonly-randconfig-005-20231129   gcc  
x86_64       buildonly-randconfig-005-20231130   gcc  
x86_64       buildonly-randconfig-006-20231129   gcc  
x86_64       buildonly-randconfig-006-20231130   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231129   gcc  
x86_64                randconfig-011-20231130   gcc  
x86_64                randconfig-012-20231129   gcc  
x86_64                randconfig-012-20231130   gcc  
x86_64                randconfig-013-20231129   gcc  
x86_64                randconfig-013-20231130   gcc  
x86_64                randconfig-014-20231129   gcc  
x86_64                randconfig-014-20231130   gcc  
x86_64                randconfig-015-20231129   gcc  
x86_64                randconfig-015-20231130   gcc  
x86_64                randconfig-016-20231129   gcc  
x86_64                randconfig-016-20231130   gcc  
x86_64                randconfig-071-20231129   gcc  
x86_64                randconfig-071-20231130   gcc  
x86_64                randconfig-072-20231129   gcc  
x86_64                randconfig-072-20231130   gcc  
x86_64                randconfig-073-20231129   gcc  
x86_64                randconfig-073-20231130   gcc  
x86_64                randconfig-074-20231129   gcc  
x86_64                randconfig-074-20231130   gcc  
x86_64                randconfig-075-20231129   gcc  
x86_64                randconfig-075-20231130   gcc  
x86_64                randconfig-076-20231129   gcc  
x86_64                randconfig-076-20231130   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20231129   gcc  
xtensa                randconfig-001-20231130   gcc  
xtensa                randconfig-002-20231129   gcc  
xtensa                randconfig-002-20231130   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
