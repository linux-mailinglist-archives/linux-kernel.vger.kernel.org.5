Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289075DA2E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjGVFTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGVFSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:18:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA9C469C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 22:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690003108; x=1721539108;
  h=date:from:to:cc:subject:message-id;
  bh=vwLYiK/vHdDQX/l+2Ni8necRVsfqKKpQxdz5VcdTKro=;
  b=I3gXIgzSDa5SpwVTUL6xO5tLMjCOYg256Zihjp5veEFG3tVDAnEriYaX
   y8A3lVFuQ4LVLvhal0/lmOQv5InzmalbQJSM7HkvGkOGjW571bbRyvmG5
   II1IzZ1qzl0AXlYYsGgfMj0RA2bC3Al8fM3Fa3LFh99/7Rw94F6kwoFFT
   k7tFgTxNhDMt3TxnEYpzfoT2kORyAdaOMhiXN9JX/jlffk7EF3aWujX+R
   YlxXp4SsHRFFmfAqypJyJAufvU+S11jafbsTekTwHoUGlzsP0O6uUAWc6
   SIJCi6Jl8EG0J0PSbQlIL1iKByxQ4AZ3gbE1379XNSQNDsdiNNw2YnC53
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="364625901"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="364625901"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 22:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="719073282"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="719073282"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 22:17:38 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qN4zq-0007zv-0c;
        Sat, 22 Jul 2023 05:17:38 +0000
Date:   Sat, 22 Jul 2023 13:16:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 c3629dd7e67d6ec5705d33b0de0d142c972fe573
Message-ID: <202307221341.FKbIdDBa-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: c3629dd7e67d6ec5705d33b0de0d142c972fe573  x86/mce: Prevent duplicate error records

elapsed time: 721m

configs tested: 73
configs skipped: 92

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                randconfig-r013-20230720   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230720   gcc  
arm                  randconfig-r014-20230720   gcc  
arm                  randconfig-r025-20230720   gcc  
arm                  randconfig-r046-20230721   clang
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230721   clang
hexagon              randconfig-r045-20230721   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230721   clang
i386                 randconfig-i002-20230721   clang
i386                 randconfig-i003-20230721   clang
i386                 randconfig-i004-20230721   clang
i386                 randconfig-i005-20230721   clang
i386                 randconfig-i006-20230721   clang
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230720   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230720   gcc  
openrisc             randconfig-r011-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230720   gcc  
s390                 randconfig-r005-20230720   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r006-20230720   gcc  
sh                   randconfig-r016-20230720   gcc  
sparc                            allyesconfig   gcc  
sparc                randconfig-r024-20230720   gcc  
sparc64              randconfig-r026-20230720   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r015-20230720   gcc  
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
