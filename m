Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0076894C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 01:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjG3Xsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 19:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG3Xst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 19:48:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA9F10C1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690760928; x=1722296928;
  h=date:from:to:cc:subject:message-id;
  bh=yeZFBpa5qECCIffI037Tf0cHoqLcqd6jW2G1zTuoTis=;
  b=Lj9gkKH4Id+GFwaq9uKrxhx9LSXVFwSBt5F5RxsYoIY8JDN+TBjYOnKo
   AdhI/nsN78PVgnLeatQeGqh8RrvltAOQ8yOTxjSdPVKaBdBncqLVT1cE7
   ZVTqL1nJ7U5VYeFzW4N7M2Jb4Q8iOWx9yXtiDQRfEGISCXe/azHgnf/zU
   fXzeIwKAV0nNXdZpFICxfkDbhzTJW4EfH6BPOkD7EYof4updt5XmJkmcV
   M1M2iUXa+k+B86wMuNxyCmGvR+0QNjXE4fkHjOunLQqT2GIfM9FreRO0S
   fO9R1AYqqOdq4ZoK1KzYjMydVx5YdLkOshHAQR0xC/a6uxc2h+3kU/1sq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="368896288"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="368896288"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 16:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678125919"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="678125919"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2023 16:48:46 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQG9W-0004pb-0S;
        Sun, 30 Jul 2023 23:48:46 +0000
Date:   Mon, 31 Jul 2023 07:48:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a48c5d5d98224135415f2bd0f764ae2ddafbe7c9
Message-ID: <202307310743.lopeRvcI-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a48c5d5d98224135415f2bd0f764ae2ddafbe7c9  Merge branch into tip/master: 'x86/mm'

elapsed time: 724m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230730   gcc  
alpha                randconfig-r034-20230730   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230730   gcc  
arc                  randconfig-r043-20230730   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r016-20230730   clang
arm                  randconfig-r046-20230730   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230730   clang
csky                                defconfig   gcc  
hexagon              randconfig-r011-20230730   clang
hexagon              randconfig-r036-20230730   clang
hexagon              randconfig-r041-20230730   clang
hexagon              randconfig-r045-20230730   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230730   clang
i386         buildonly-randconfig-r005-20230730   clang
i386         buildonly-randconfig-r006-20230730   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230730   clang
i386                 randconfig-i002-20230730   clang
i386                 randconfig-i003-20230730   clang
i386                 randconfig-i004-20230730   clang
i386                 randconfig-i005-20230730   clang
i386                 randconfig-i006-20230730   clang
i386                 randconfig-i011-20230730   gcc  
i386                 randconfig-i012-20230730   gcc  
i386                 randconfig-i013-20230730   gcc  
i386                 randconfig-i014-20230730   gcc  
i386                 randconfig-i015-20230730   gcc  
i386                 randconfig-i016-20230730   gcc  
i386                 randconfig-r024-20230730   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230730   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230730   clang
mips                 randconfig-r025-20230730   clang
mips                 randconfig-r032-20230730   gcc  
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230730   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230730   gcc  
powerpc              randconfig-r022-20230730   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230730   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230730   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230730   gcc  
sh                   randconfig-r035-20230730   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230730   gcc  
sparc                randconfig-r021-20230730   gcc  
sparc64              randconfig-r001-20230730   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230730   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230730   clang
x86_64       buildonly-randconfig-r002-20230730   clang
x86_64       buildonly-randconfig-r003-20230730   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r023-20230730   gcc  
x86_64               randconfig-x001-20230730   gcc  
x86_64               randconfig-x002-20230730   gcc  
x86_64               randconfig-x003-20230730   gcc  
x86_64               randconfig-x004-20230730   gcc  
x86_64               randconfig-x005-20230730   gcc  
x86_64               randconfig-x006-20230730   gcc  
x86_64               randconfig-x011-20230730   clang
x86_64               randconfig-x012-20230730   clang
x86_64               randconfig-x013-20230730   clang
x86_64               randconfig-x014-20230730   clang
x86_64               randconfig-x015-20230730   clang
x86_64               randconfig-x016-20230730   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
