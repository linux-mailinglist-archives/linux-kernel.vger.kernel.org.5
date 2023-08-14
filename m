Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46F77B0C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjHNFbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjHNFbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:31:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5025E6A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691991105; x=1723527105;
  h=date:from:to:cc:subject:message-id;
  bh=Ep77R0h93kVU9i+coMRkJ6GcY3IJKzoL6Q8u+oD1Z4Q=;
  b=OYBddyZ92f2qbjJ4w/5lWP9PD8yFFKf1uLBQQjGf/4HXRK2igJpp+A7E
   8FsgfKewKDl0SCKZZIOeKJ1HcONbHogjU+fhXMANmbaT14shKhE77j7YD
   zKoV28GqKLFL/13q0VNL2rnni1EOD0wuPys1ZP7JpZ0z+M9jAYWuyj1pf
   082Gjeg1KD5Aw6mqRKM9gLiQUAnyNsCQOG8GIaa2Fnoxwy05wn6CKnDjJ
   dSKdorkZwTpCmtTEKPutcrNf3dGlbZfFPlidCtPctU8EPKFC0RJSOwfz1
   Q73HyCZOYzEVR2UDamzrWAIbfVpCTQcmF+WFUXHVctqAWEIddbeaMVuug
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="356928660"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="356928660"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 22:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="1063933501"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="1063933501"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2023 22:31:43 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVQB4-0009NY-2P;
        Mon, 14 Aug 2023 05:31:42 +0000
Date:   Mon, 14 Aug 2023 13:31:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 d2700f406713d04573803b9fe8a0fb02c015df39
Message-ID: <202308141317.l7ZPTuuI-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: d2700f406713d04573803b9fe8a0fb02c015df39  x86/microcode/intel: Remove pointless mutex

elapsed time: 725m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230814   gcc  
arc                  randconfig-r043-20230814   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230814   clang
arm                  randconfig-r031-20230814   clang
arm                  randconfig-r032-20230814   clang
arm                  randconfig-r046-20230814   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230814   gcc  
arm64                randconfig-r014-20230814   clang
arm64                randconfig-r026-20230814   clang
arm64                randconfig-r035-20230814   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r004-20230814   clang
hexagon              randconfig-r041-20230814   clang
hexagon              randconfig-r045-20230814   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230814   gcc  
i386         buildonly-randconfig-r005-20230814   gcc  
i386         buildonly-randconfig-r006-20230814   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230814   gcc  
i386                 randconfig-i002-20230814   gcc  
i386                 randconfig-i003-20230814   gcc  
i386                 randconfig-i004-20230814   gcc  
i386                 randconfig-i005-20230814   gcc  
i386                 randconfig-i006-20230814   gcc  
i386                 randconfig-i011-20230814   clang
i386                 randconfig-i012-20230814   clang
i386                 randconfig-i013-20230814   clang
i386                 randconfig-i014-20230814   clang
i386                 randconfig-i015-20230814   clang
i386                 randconfig-i016-20230814   clang
i386                 randconfig-r024-20230814   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230814   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230814   gcc  
m68k                 randconfig-r025-20230814   gcc  
microblaze           randconfig-r015-20230814   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230814   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r003-20230814   gcc  
openrisc             randconfig-r034-20230814   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230814   clang
riscv                randconfig-r013-20230814   clang
riscv                randconfig-r042-20230814   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230814   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r036-20230814   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230814   gcc  
x86_64       buildonly-randconfig-r002-20230814   gcc  
x86_64       buildonly-randconfig-r003-20230814   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r023-20230814   clang
x86_64               randconfig-x001-20230814   clang
x86_64               randconfig-x002-20230814   clang
x86_64               randconfig-x003-20230814   clang
x86_64               randconfig-x004-20230814   clang
x86_64               randconfig-x005-20230814   clang
x86_64               randconfig-x006-20230814   clang
x86_64               randconfig-x011-20230814   gcc  
x86_64               randconfig-x012-20230814   gcc  
x86_64               randconfig-x013-20230814   gcc  
x86_64               randconfig-x014-20230814   gcc  
x86_64               randconfig-x015-20230814   gcc  
x86_64               randconfig-x016-20230814   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230814   gcc  
xtensa               randconfig-r033-20230814   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
