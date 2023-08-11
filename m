Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B937784A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjHKAp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjHKAp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:45:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCF26AB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691714726; x=1723250726;
  h=date:from:to:cc:subject:message-id;
  bh=SV5atIRFre8FkrmKyyxa+QSgU6MleoWbdkzI1m9xt2s=;
  b=YpaoZqXyh27LocJ/nqRkbjk/iTRGvbPhSp2F7q6jJRDxhkKBKap+Uy5g
   xlLqyL7PJW7twrJ+R7whTM6/M+TYgCbcS8mlMTyPNAvdE9CraXN1zv+zw
   L0Io8NgLnYo1Z2w+S179NtIcUsMLIPcNHrf8aSAmvvgawl8kbjq06MXvl
   zG4us2ffIX9B3p0ieJ96XuIj3YbGy6+w+HK7QYK3a2ZHYjp2q6SBmfFeH
   SQkGWm/cr37hn8D6ZqjMJUHy0JcjZnF6qc5MsnX3zndWvDW9GdfSyyJBH
   2+GgYDvO4mOGtjCSkXucVYrIjF1hzxwdt8pojAMsaB3zC7AwmgUXXeq5h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351167307"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="351167307"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 17:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="761997884"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="761997884"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2023 17:45:25 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUGHM-0007NA-0R;
        Fri, 11 Aug 2023 00:45:24 +0000
Date:   Fri, 11 Aug 2023 08:45:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 c4d07c371283cb0453c8ce187551e4d064cc407e
Message-ID: <202308110800.w4BuJa00-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: c4d07c371283cb0453c8ce187551e4d064cc407e  EDAC/amd64: Add support for AMD family 1Ah models 00h-1Fh and 40h-4Fh

elapsed time: 725m

configs tested: 106
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230810   gcc  
arc                  randconfig-r043-20230810   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230810   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r033-20230810   gcc  
hexagon              randconfig-r041-20230810   clang
hexagon              randconfig-r045-20230810   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230810   gcc  
i386         buildonly-randconfig-r005-20230810   gcc  
i386         buildonly-randconfig-r006-20230810   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230810   gcc  
i386                 randconfig-i002-20230810   gcc  
i386                 randconfig-i003-20230810   gcc  
i386                 randconfig-i004-20230810   gcc  
i386                 randconfig-i005-20230810   gcc  
i386                 randconfig-i006-20230810   gcc  
i386                 randconfig-i011-20230810   clang
i386                 randconfig-i012-20230810   clang
i386                 randconfig-i013-20230810   clang
i386                 randconfig-i014-20230810   clang
i386                 randconfig-i015-20230810   clang
i386                 randconfig-i016-20230810   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230810   gcc  
microblaze           randconfig-r011-20230810   gcc  
microblaze           randconfig-r016-20230810   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230810   clang
mips                 randconfig-r035-20230810   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r021-20230810   gcc  
openrisc             randconfig-r026-20230810   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230810   gcc  
parisc               randconfig-r023-20230810   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230810   clang
riscv                randconfig-r025-20230810   clang
riscv                randconfig-r036-20230810   gcc  
riscv                randconfig-r042-20230810   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230810   clang
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r004-20230810   gcc  
sparc64              randconfig-r006-20230810   gcc  
sparc64              randconfig-r012-20230810   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230810   clang
um                   randconfig-r005-20230810   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230810   gcc  
x86_64       buildonly-randconfig-r002-20230810   gcc  
x86_64       buildonly-randconfig-r003-20230810   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r031-20230810   gcc  
x86_64               randconfig-x001-20230810   clang
x86_64               randconfig-x002-20230810   clang
x86_64               randconfig-x003-20230810   clang
x86_64               randconfig-x004-20230810   clang
x86_64               randconfig-x005-20230810   clang
x86_64               randconfig-x006-20230810   clang
x86_64               randconfig-x011-20230810   gcc  
x86_64               randconfig-x012-20230810   gcc  
x86_64               randconfig-x013-20230810   gcc  
x86_64               randconfig-x014-20230810   gcc  
x86_64               randconfig-x015-20230810   gcc  
x86_64               randconfig-x016-20230810   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230810   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
