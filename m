Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505377D4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbjHOU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbjHOU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:56:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE0BE3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692132999; x=1723668999;
  h=date:from:to:cc:subject:message-id;
  bh=HXxNgzDDknPsipapBP/Q+5C8swsZNv2IMf7AngJVuI8=;
  b=C/xtFQVd0TCbghJTSYbzNJXqlXSXXLulXhCddei0SIlFHYPJs+u624CZ
   Dh+/hsUR+Tb1WK8NRCXViEHWB/rC/+STZST8fxu1sNnbRu6qpW9bu2W10
   5hLVC0gOO1EQTW6ZqsEs9HImk2B54HEk2IfQ+bhmMv301OBX8FMk1WAxz
   lvIGHICK+b+cxXEg+ZU1d8DUId4uj4Xgs9M67OlEhdr19S/iD0nZosh5X
   c0GCwk32Jh8xU5LpwTZ/znMQFUyl4oNi3kzMEHOnz5FllKvQO+JoMiHy6
   QWKJHJwxWXPtrKWdwNCxv7Z9hKHrKxR0YbGoA33AdKcI2RuJaEdLjKbYn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="369847413"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="369847413"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 13:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="710871348"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="710871348"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2023 13:56:10 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW15F-0001Dn-1h;
        Tue, 15 Aug 2023 20:56:09 +0000
Date:   Wed, 16 Aug 2023 04:55:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 fe684acfdbda5916be9c0e6f9f3978f341499e14
Message-ID: <202308160419.jBPhf1A7-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: fe684acfdbda5916be9c0e6f9f3978f341499e14  Merge branch into tip/master: 'x86/misc'

elapsed time: 721m

configs tested: 100
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230815   gcc  
alpha                randconfig-r025-20230815   gcc  
alpha                randconfig-r026-20230815   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230815   gcc  
arc                  randconfig-r043-20230815   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230815   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230815   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230815   gcc  
csky                 randconfig-r021-20230815   gcc  
csky                 randconfig-r032-20230816   gcc  
hexagon              randconfig-r002-20230815   clang
hexagon              randconfig-r041-20230815   clang
hexagon              randconfig-r045-20230815   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230815   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i011-20230815   gcc  
i386                 randconfig-i012-20230815   gcc  
i386                 randconfig-i013-20230815   gcc  
i386                 randconfig-i014-20230815   gcc  
i386                 randconfig-i015-20230815   gcc  
i386                 randconfig-i016-20230815   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230815   gcc  
loongarch            randconfig-r035-20230815   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230815   gcc  
m68k                 randconfig-r032-20230815   gcc  
microblaze           randconfig-r036-20230815   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230815   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230815   gcc  
nios2                randconfig-r031-20230816   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r015-20230815   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230815   clang
riscv                randconfig-r042-20230815   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230815   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230815   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230815   gcc  
sparc                randconfig-r024-20230815   gcc  
sparc                randconfig-r026-20230815   gcc  
sparc64              randconfig-r004-20230815   gcc  
sparc64              randconfig-r035-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230815   gcc  
x86_64               randconfig-x002-20230815   gcc  
x86_64               randconfig-x003-20230815   gcc  
x86_64               randconfig-x004-20230815   gcc  
x86_64               randconfig-x005-20230815   gcc  
x86_64               randconfig-x006-20230815   gcc  
x86_64               randconfig-x011-20230815   clang
x86_64               randconfig-x012-20230815   clang
x86_64               randconfig-x013-20230815   clang
x86_64               randconfig-x014-20230815   clang
x86_64               randconfig-x015-20230815   clang
x86_64               randconfig-x016-20230815   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r033-20230815   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
