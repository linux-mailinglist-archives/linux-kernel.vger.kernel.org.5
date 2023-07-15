Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F05754996
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGOPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:09:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BC2D55
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689433742; x=1720969742;
  h=date:from:to:cc:subject:message-id;
  bh=1K8AlO/K1YCO08GDoV7M9FUxMT+pTpH87dlF0uA+3i0=;
  b=aw5CYhJX/kRn4LAAA21rIuZELix4vUs1OOzbCQX/K4/Z3ukmcDB8gbqY
   wQvmcHmohTkOesKRFvevv1pPuYL2m4caGq5Fa5+d5dy+E7rB5VRKSXJNF
   2+LVf5slfxUEadt8GT9gjvLrPR3aaMNnK6f/nafdDyByRJ81UeAurB5J/
   9BJjwNvXxACiClgVDeV+70Vcn2o8FRUVRqUFGqtALGaNme6AjsoJ6Ui7R
   cm8UWP4xB2M76HkMFkjYFR+IIer3xfZJ99M1LnXTxkACUmOGBW5OxLAXo
   iq6yfVxzElXeLDPGMfvH/vQDgqlSAiP7ELbl9hUrlAc7eETr/jTVcOxCh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="396481964"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="396481964"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 08:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="757895631"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="757895631"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2023 08:09:00 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKgtH-0008Cx-1c;
        Sat, 15 Jul 2023 15:08:59 +0000
Date:   Sat, 15 Jul 2023 23:08:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 ddf5d3eda2df19d84a6c729d54604393823a94cd
Message-ID: <202307152332.lKIrBCLx-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: ddf5d3eda2df19d84a6c729d54604393823a94cd  Merge branch 'csd-lock.2023.07.14b' into HEAD

elapsed time: 852m

configs tested: 149
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230715   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230715   gcc  
arc                  randconfig-r043-20230715   gcc  
arc                           tb10x_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                          pxa168_defconfig   clang
arm                  randconfig-r046-20230715   clang
arm                           sama5_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230715   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r001-20230715   clang
hexagon              randconfig-r041-20230715   clang
hexagon              randconfig-r045-20230715   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230715   clang
i386         buildonly-randconfig-r005-20230715   clang
i386         buildonly-randconfig-r006-20230715   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230715   clang
i386                 randconfig-i002-20230715   clang
i386                 randconfig-i003-20230715   clang
i386                 randconfig-i004-20230715   clang
i386                 randconfig-i005-20230715   clang
i386                 randconfig-i006-20230715   clang
i386                 randconfig-i011-20230715   gcc  
i386                 randconfig-i012-20230715   gcc  
i386                 randconfig-i013-20230715   gcc  
i386                 randconfig-i014-20230715   gcc  
i386                 randconfig-i015-20230715   gcc  
i386                 randconfig-i016-20230715   gcc  
i386                 randconfig-r012-20230715   gcc  
i386                 randconfig-r016-20230715   gcc  
i386                 randconfig-r022-20230715   gcc  
i386                 randconfig-r024-20230715   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                           ip27_defconfig   clang
mips                 randconfig-r013-20230715   clang
nios2                               defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230715   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc              randconfig-r002-20230715   clang
powerpc              randconfig-r011-20230715   gcc  
powerpc              randconfig-r031-20230715   clang
powerpc              randconfig-r033-20230715   clang
powerpc              randconfig-r034-20230715   clang
powerpc                     tqm5200_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230715   gcc  
riscv                randconfig-r042-20230715   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230715   gcc  
s390                 randconfig-r044-20230715   gcc  
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230715   gcc  
sparc                randconfig-r014-20230715   gcc  
sparc                randconfig-r023-20230715   gcc  
sparc                randconfig-r036-20230715   gcc  
sparc                       sparc64_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r021-20230715   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230715   clang
x86_64       buildonly-randconfig-r002-20230715   clang
x86_64       buildonly-randconfig-r003-20230715   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230715   gcc  
x86_64               randconfig-x002-20230715   gcc  
x86_64               randconfig-x003-20230715   gcc  
x86_64               randconfig-x004-20230715   gcc  
x86_64               randconfig-x005-20230715   gcc  
x86_64               randconfig-x006-20230715   gcc  
x86_64               randconfig-x011-20230715   clang
x86_64               randconfig-x012-20230715   clang
x86_64               randconfig-x013-20230715   clang
x86_64               randconfig-x014-20230715   clang
x86_64               randconfig-x015-20230715   clang
x86_64               randconfig-x016-20230715   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
