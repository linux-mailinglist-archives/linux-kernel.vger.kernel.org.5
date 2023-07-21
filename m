Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7A75C159
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGUIUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGUIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:20:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D710E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689927641; x=1721463641;
  h=date:from:to:cc:subject:message-id;
  bh=mFwYASA6hlAF10YknlYjBH7LhXP5U6zhYXGrbXPFYzs=;
  b=mvhr3KgL/Q4QBcAiGGbtLQU7vQVQWCtOq4MlO4GitpsH7hwoPpem7eVo
   JNHreZWlTB5ZueZQ99uL8mqUpBC9pjgAxft5ImgrEM9JFtgIcXlC6q6bh
   vvnWtRcXo2r7ze77mFRpRQgOv+tuzWM4FUbeD6iOoiu+/Z0ft6gadJxg8
   1AFHnXf/gx+oiomYOreh+9tFmsGOc1LVanSk0MOAesbux6+/5Ugj/LuLG
   niHtDqTL9GjFI9AI3aOjMtbwO3KFugYWrwzG1Vm5122icC6PtJQbCUaEH
   mkYxCX5eMN0SBpWwdelW/kgCi+GPVT4681SzagpXU+3pguGUMxQEccZ5E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351851457"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="351851457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 01:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="674967424"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="674967424"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2023 01:20:39 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMlNP-00074G-0g;
        Fri, 21 Jul 2023 08:20:39 +0000
Date:   Fri, 21 Jul 2023 16:20:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8f4995b370a57e7ad92c0f66664d171b23234337
Message-ID: <202307211618.pA8jyPUD-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8f4995b370a57e7ad92c0f66664d171b23234337  Merge branch into tip/master: 'sched/eevdf'

elapsed time: 1444m

configs tested: 118
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230720   gcc  
alpha                randconfig-r011-20230720   gcc  
alpha                randconfig-r034-20230720   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230720   gcc  
arc                  randconfig-r043-20230720   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                  randconfig-r013-20230720   gcc  
arm                  randconfig-r046-20230720   gcc  
arm                           u8500_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230720   clang
csky                                defconfig   gcc  
hexagon              randconfig-r045-20230720   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i006-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
i386                 randconfig-r004-20230720   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230720   gcc  
microblaze           randconfig-r012-20230720   gcc  
microblaze           randconfig-r023-20230720   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                 randconfig-r005-20230720   clang
mips                 randconfig-r011-20230720   gcc  
mips                 randconfig-r026-20230720   gcc  
mips                          rb532_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230720   gcc  
openrisc             randconfig-r013-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230720   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r016-20230720   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r024-20230720   clang
s390                 randconfig-r044-20230720   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                   randconfig-r025-20230720   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230720   gcc  
sparc                randconfig-r014-20230720   gcc  
sparc                randconfig-r015-20230720   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230720   gcc  
x86_64       buildonly-randconfig-r002-20230720   gcc  
x86_64       buildonly-randconfig-r003-20230720   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230720   clang
x86_64               randconfig-x002-20230720   clang
x86_64               randconfig-x003-20230720   clang
x86_64               randconfig-x004-20230720   clang
x86_64               randconfig-x005-20230720   clang
x86_64               randconfig-x006-20230720   clang
x86_64               randconfig-x011-20230720   gcc  
x86_64               randconfig-x012-20230720   gcc  
x86_64               randconfig-x013-20230720   gcc  
x86_64               randconfig-x014-20230720   gcc  
x86_64               randconfig-x015-20230720   gcc  
x86_64               randconfig-x016-20230720   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230720   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
