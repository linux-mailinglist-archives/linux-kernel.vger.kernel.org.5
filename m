Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA77DACBF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ2ODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2ODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 10:03:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0EB7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698588192; x=1730124192;
  h=date:from:to:cc:subject:message-id;
  bh=PI2AP+69xiv2rDC52TFgz5cfm3UZslNArjUkspQbRUQ=;
  b=XoAxxxY1jmN72YDo6Or2ycJdmahyGxt/RGWwglaj2/SQmExsYZyKGddm
   g9O0MwzGS5EegKA1iwyh4nmEs2XWlJ6s8kKY6nKziZeZ0hmZk9E28dVAO
   7NNTDGY+QrdwzxZaVp3pds56L0iT1Iv/iJjLlK1siBFIgIsjulhocIuLW
   Ttl4761ZYOkBLGDoGYAt9qamoM1HEkfUD1lAlmQUSBX29LgILY0GJXBfS
   gp2401rdxfR6GKXE+KYWGqPZZpYMq1gjjPpXT11kMwmSuVN5NZkOWw91K
   y2O18yjNRbKI3yVBFjI0sNB+xVq6wHbtaFVpr88JngVSnz5rAkfuE3iA0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="419067410"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="419067410"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 07:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="933555358"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="933555358"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2023 07:03:10 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qx6Ng-000CcV-1H;
        Sun, 29 Oct 2023 14:03:08 +0000
Date:   Sun, 29 Oct 2023 22:02:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1187c0b3a6c2ecb3b36c0f236b1206e10033eea6
Message-ID: <202310292217.uOXNVfr8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1187c0b3a6c2ecb3b36c0f236b1206e10033eea6  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1552m

configs tested: 151
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
arc                   randconfig-001-20231028   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231028   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20231028   gcc  
i386         buildonly-randconfig-002-20231028   gcc  
i386         buildonly-randconfig-003-20231028   gcc  
i386         buildonly-randconfig-004-20231028   gcc  
i386         buildonly-randconfig-005-20231028   gcc  
i386         buildonly-randconfig-006-20231028   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231028   gcc  
i386                  randconfig-002-20231028   gcc  
i386                  randconfig-003-20231028   gcc  
i386                  randconfig-004-20231028   gcc  
i386                  randconfig-005-20231028   gcc  
i386                  randconfig-006-20231028   gcc  
i386                  randconfig-011-20231028   gcc  
i386                  randconfig-012-20231028   gcc  
i386                  randconfig-013-20231028   gcc  
i386                  randconfig-014-20231028   gcc  
i386                  randconfig-015-20231028   gcc  
i386                  randconfig-016-20231028   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231028   gcc  
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
mips                         bigsur_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                        maltaup_defconfig   clang
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
powerpc                   bluestone_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc                     tqm8541_defconfig   gcc  
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
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                             shx3_defconfig   gcc  
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
x86_64                randconfig-001-20231028   gcc  
x86_64                randconfig-002-20231028   gcc  
x86_64                randconfig-003-20231028   gcc  
x86_64                randconfig-004-20231028   gcc  
x86_64                randconfig-005-20231028   gcc  
x86_64                randconfig-006-20231028   gcc  
x86_64                randconfig-011-20231028   gcc  
x86_64                randconfig-012-20231028   gcc  
x86_64                randconfig-013-20231028   gcc  
x86_64                randconfig-014-20231028   gcc  
x86_64                randconfig-015-20231028   gcc  
x86_64                randconfig-016-20231028   gcc  
x86_64                randconfig-071-20231028   gcc  
x86_64                randconfig-072-20231028   gcc  
x86_64                randconfig-073-20231028   gcc  
x86_64                randconfig-074-20231028   gcc  
x86_64                randconfig-075-20231028   gcc  
x86_64                randconfig-076-20231028   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
