Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C357B77B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjJDGSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjJDGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:18:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACDFA6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696400314; x=1727936314;
  h=date:from:to:cc:subject:message-id;
  bh=n6f6w2GU1I74cbWGKmE1UVFSf6NeNDHiDeK3SGzB4T0=;
  b=LPsbReFr6lFXmncV1KjckwPhqk5qruv+LY6eEH0DWeODplbUIB43J+Iy
   36UUgIpYVZ09ww4PlTQd6iFguchR7rBoIrNc6CH754mIS0cJn6KZe8zy0
   K1E9og3f5FIwu63odW+QmC9/6Il2KJgREYFlhzutW/agZaO+fDcJXgRcs
   +mjIVKHUv9M/0TO2jQejQ/paVyhyUKB4b1w/3H2U9nsbvmuAGQhUA97qS
   gp52zhlLZKONRosqjqGcG2w0sriWNIF7wWx3xU/bJblLft6SDQxKW/FtZ
   hDClLWJWx5GaONYoetJtc8I0QpNSVHtaWXe1Gpg7ZSl9yUA6uk63djc2s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385892899"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="385892899"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 23:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="754730142"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="754730142"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2023 23:18:32 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnvDK-000Cyf-1E;
        Wed, 04 Oct 2023 06:18:30 +0000
Date:   Wed, 04 Oct 2023 14:18:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 2a565258b3f4bbdc7a3c09cd02082cb286a7bffc
Message-ID: <202310041416.ri86IrbO-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 2a565258b3f4bbdc7a3c09cd02082cb286a7bffc  x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs

elapsed time: 1228m

configs tested: 138
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
arc                   randconfig-001-20231003   gcc  
arc                   randconfig-001-20231004   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                   randconfig-001-20231003   gcc  
arm                   randconfig-001-20231004   gcc  
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
i386         buildonly-randconfig-001-20231003   gcc  
i386         buildonly-randconfig-001-20231004   gcc  
i386         buildonly-randconfig-002-20231003   gcc  
i386         buildonly-randconfig-002-20231004   gcc  
i386         buildonly-randconfig-003-20231003   gcc  
i386         buildonly-randconfig-003-20231004   gcc  
i386         buildonly-randconfig-004-20231003   gcc  
i386         buildonly-randconfig-004-20231004   gcc  
i386         buildonly-randconfig-005-20231003   gcc  
i386         buildonly-randconfig-005-20231004   gcc  
i386         buildonly-randconfig-006-20231003   gcc  
i386         buildonly-randconfig-006-20231004   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231003   gcc  
i386                  randconfig-001-20231004   gcc  
i386                  randconfig-002-20231003   gcc  
i386                  randconfig-002-20231004   gcc  
i386                  randconfig-003-20231003   gcc  
i386                  randconfig-003-20231004   gcc  
i386                  randconfig-004-20231003   gcc  
i386                  randconfig-004-20231004   gcc  
i386                  randconfig-005-20231003   gcc  
i386                  randconfig-005-20231004   gcc  
i386                  randconfig-006-20231003   gcc  
i386                  randconfig-006-20231004   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231003   gcc  
loongarch             randconfig-001-20231004   gcc  
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
powerpc                 mpc834x_itx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231003   gcc  
x86_64                randconfig-001-20231004   gcc  
x86_64                randconfig-002-20231003   gcc  
x86_64                randconfig-002-20231004   gcc  
x86_64                randconfig-003-20231003   gcc  
x86_64                randconfig-003-20231004   gcc  
x86_64                randconfig-004-20231003   gcc  
x86_64                randconfig-004-20231004   gcc  
x86_64                randconfig-005-20231003   gcc  
x86_64                randconfig-005-20231004   gcc  
x86_64                randconfig-006-20231003   gcc  
x86_64                randconfig-006-20231004   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
