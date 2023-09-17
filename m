Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3977A3A2B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbjIQT7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbjIQT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:58:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E012F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694980724; x=1726516724;
  h=date:from:to:cc:subject:message-id;
  bh=EFOB2QFx+S80qEWrlJYlGid8bJCBTtzgefQ1dPdxhhA=;
  b=gX6fwlvBzno8BcIanCYgaXmx3Jcp8Kam3XaoK0nT9y7+KpS0zEvJjc3D
   wIPsSzRHEsCsJVIcymKPE68OPpwZlNw7IC3Q2zvIHBFHGdPBfjHIFt2mA
   Kcec3sPdy5VBPIEzR2HxHr3SRVBw+JiJ+V7fB2ajKjEIs5u/38XLOqNfg
   Ds48pynPVSihY/GE+ac7tFQGIo7b1Y6x7Fou67ncs4RtF9kvjp/jpKnLI
   oTbNjt50ta2YL7ZfolGqZ5BsWAR6oEpc1BrN6EFZdB6DWovMh7q8if4UX
   ZiX8HW8mqXmMujX+UzBshK8N7GJCH0+1JK2H7QHVOdwTVT0FrJTtaDqrV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="383344874"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="383344874"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 12:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="1076367241"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="1076367241"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2023 12:58:42 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhxui-0005Qa-0S;
        Sun, 17 Sep 2023 19:58:40 +0000
Date:   Mon, 18 Sep 2023 03:58:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 75b2f7e4c9e0fd750a5a27ca9736d1daa7a3762a
Message-ID: <202309180321.tr4VmRCJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 75b2f7e4c9e0fd750a5a27ca9736d1daa7a3762a  x86/purgatory: Remove LTO flags

elapsed time: 722m

configs tested: 161
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230917   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20230917   gcc  
arm                        spear6xx_defconfig   gcc  
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
i386         buildonly-randconfig-001-20230917   gcc  
i386         buildonly-randconfig-002-20230917   gcc  
i386         buildonly-randconfig-003-20230917   gcc  
i386         buildonly-randconfig-004-20230917   gcc  
i386         buildonly-randconfig-005-20230917   gcc  
i386         buildonly-randconfig-006-20230917   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230917   gcc  
i386                  randconfig-002-20230917   gcc  
i386                  randconfig-003-20230917   gcc  
i386                  randconfig-004-20230917   gcc  
i386                  randconfig-005-20230917   gcc  
i386                  randconfig-006-20230917   gcc  
i386                  randconfig-011-20230917   gcc  
i386                  randconfig-012-20230917   gcc  
i386                  randconfig-013-20230917   gcc  
i386                  randconfig-014-20230917   gcc  
i386                  randconfig-015-20230917   gcc  
i386                  randconfig-016-20230917   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230917   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                            gpr_defconfig   gcc  
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
powerpc                     ep8248e_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                     powernv_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20230917   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230917   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230917   gcc  
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
x86_64       buildonly-randconfig-001-20230917   gcc  
x86_64       buildonly-randconfig-002-20230917   gcc  
x86_64       buildonly-randconfig-003-20230917   gcc  
x86_64       buildonly-randconfig-004-20230917   gcc  
x86_64       buildonly-randconfig-005-20230917   gcc  
x86_64       buildonly-randconfig-006-20230917   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230917   gcc  
x86_64                randconfig-002-20230917   gcc  
x86_64                randconfig-003-20230917   gcc  
x86_64                randconfig-004-20230917   gcc  
x86_64                randconfig-005-20230917   gcc  
x86_64                randconfig-006-20230917   gcc  
x86_64                randconfig-011-20230917   gcc  
x86_64                randconfig-012-20230917   gcc  
x86_64                randconfig-013-20230917   gcc  
x86_64                randconfig-014-20230917   gcc  
x86_64                randconfig-015-20230917   gcc  
x86_64                randconfig-016-20230917   gcc  
x86_64                randconfig-071-20230917   gcc  
x86_64                randconfig-072-20230917   gcc  
x86_64                randconfig-073-20230917   gcc  
x86_64                randconfig-074-20230917   gcc  
x86_64                randconfig-075-20230917   gcc  
x86_64                randconfig-076-20230917   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
