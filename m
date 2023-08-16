Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6827477EB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346393AbjHPVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbjHPVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:11:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D716128
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692220316; x=1723756316;
  h=date:from:to:cc:subject:message-id;
  bh=XDQM3Ixlo5gdgmjRaqnQ4fPyYxf3pshfgY9XxLjmgW4=;
  b=HjSnr+9eaNndov8qQs7lU0PtikUffpshOwF/5jZOGXv+2JiojJEeBx6d
   xlbQSh9QB+PJJNY7h1KPohjx/c1I67l8/zPhMHEhIQY0zcSCP0DYYoTv3
   XY6sBLCAaokXCZj6ADV44liiYscvdCEzAYZKt2sr08ZpRNR/aVmOz8GL0
   nsE2qU8pc2lF5jTGYl/fmvMT34EtxWK3Eu0Y3i4V7r0SmaDESNRgMU3Zw
   4YEOeiYXxoRO7pgAwnIMGBBIhpZTFG/zSPiHmu3bv7OgkAFvo74irgCjj
   1woI6GtvCqwvTe2EwnwiFwkP3Z4TJV/gpvWsPNPRmnMBFA1SRffske3mb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376377025"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="376377025"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 14:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804379960"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="804379960"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2023 14:11:54 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWNo2-0000Zb-0C;
        Wed, 16 Aug 2023 21:11:54 +0000
Date:   Thu, 17 Aug 2023 05:11:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3cb61f6101a365c7e7d6457a2e80c062cf88fceb
Message-ID: <202308170512.JqBI80lK-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 3cb61f6101a365c7e7d6457a2e80c062cf88fceb  Merge x86/sev into tip/master

elapsed time: 763m

configs tested: 120
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230816   gcc  
arc                  randconfig-r005-20230816   gcc  
arc                  randconfig-r035-20230817   gcc  
arc                  randconfig-r043-20230817   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230816   gcc  
arm64                randconfig-r012-20230816   clang
arm64                randconfig-r025-20230816   clang
arm64                randconfig-r034-20230816   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230817   gcc  
csky                 randconfig-r036-20230817   gcc  
hexagon              randconfig-r001-20230817   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230817   clang
i386         buildonly-randconfig-r005-20230817   clang
i386         buildonly-randconfig-r006-20230816   gcc  
i386         buildonly-randconfig-r006-20230817   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230816   gcc  
i386                 randconfig-i002-20230816   gcc  
i386                 randconfig-i003-20230816   gcc  
i386                 randconfig-i004-20230816   gcc  
i386                 randconfig-i005-20230816   gcc  
i386                 randconfig-i006-20230816   gcc  
i386                 randconfig-i011-20230817   gcc  
i386                 randconfig-i012-20230817   gcc  
i386                 randconfig-i013-20230817   gcc  
i386                 randconfig-i014-20230817   gcc  
i386                 randconfig-i015-20230817   gcc  
i386                 randconfig-i016-20230816   clang
i386                 randconfig-i016-20230817   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230816   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r032-20230816   gcc  
microblaze           randconfig-r004-20230816   gcc  
microblaze           randconfig-r015-20230816   gcc  
microblaze           randconfig-r022-20230817   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230816   gcc  
mips                 randconfig-r026-20230816   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r033-20230817   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230816   gcc  
parisc               randconfig-r035-20230816   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc              randconfig-r026-20230817   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230817   clang
riscv                randconfig-r021-20230817   gcc  
riscv                randconfig-r042-20230817   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230816   clang
s390                 randconfig-r044-20230817   gcc  
sh                               allmodconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230816   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r013-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230816   clang
um                   randconfig-r024-20230816   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r001-20230817   clang
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230817   clang
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230817   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r006-20230817   clang
x86_64               randconfig-x001-20230816   clang
x86_64               randconfig-x001-20230817   gcc  
x86_64               randconfig-x002-20230816   clang
x86_64               randconfig-x002-20230817   gcc  
x86_64               randconfig-x003-20230816   clang
x86_64               randconfig-x003-20230817   gcc  
x86_64               randconfig-x004-20230816   clang
x86_64               randconfig-x004-20230817   gcc  
x86_64               randconfig-x005-20230816   clang
x86_64               randconfig-x005-20230817   gcc  
x86_64               randconfig-x006-20230816   clang
x86_64               randconfig-x006-20230817   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230816   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
