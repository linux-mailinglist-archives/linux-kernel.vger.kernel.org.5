Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2010F7936DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjIFIIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjIFIIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:08:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823710F9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693987683; x=1725523683;
  h=date:from:to:cc:subject:message-id;
  bh=Zqedky2Isz8BNlVXwrLuF7Rmxzs5xIT47/i/P4O5uGs=;
  b=Khcs3Gh30wmdo4HinS8ubU7Bwv9o4dDTRZ4xgDrz9C88AE0H+ewbtQmz
   hqqjZKNfHBhuuVh3ROdVmPnRZEBqKe/FRdumfO8QRNoPHNSMcP3gAelC3
   4Vlj2AbZTNddhXC5TgJYuke24g3Qb3Oh73WWtH9vJGz8s72ZM1yEqB06r
   TLhekqwTYI8aQN9SFAg6wwKAw7TjENoUrkZxbQJXRFVm08nJuFLvEd2eS
   glWzXm7g8G5JIG1uVz6AmfAEuJ7F0gF/rvblRZ6hnNW9iBoyhsZsOMvVt
   Y8fMIHz/mkUoMlA+aBInvQW0OM58lO1s5tj6R8VxFdY+ry/ayQi2i4W8s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="362029938"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="362029938"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 01:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831558097"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="831558097"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2023 01:07:21 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdnZ7-0002Zm-0Y;
        Wed, 06 Sep 2023 08:07:17 +0000
Date:   Wed, 06 Sep 2023 16:06:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 6f7f984fa85b305799076a1bcec941b9377587de
Message-ID: <202309061635.RAyLa5hX-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 6f7f984fa85b305799076a1bcec941b9377587de  perf/x86/uncore: Correct the number of CHAs on EMR

elapsed time: 727m

configs tested: 52
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230906   gcc  
i386         buildonly-randconfig-002-20230906   gcc  
i386         buildonly-randconfig-003-20230906   gcc  
i386         buildonly-randconfig-004-20230906   gcc  
i386         buildonly-randconfig-005-20230906   gcc  
i386         buildonly-randconfig-006-20230906   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230906   gcc  
i386                  randconfig-002-20230906   gcc  
i386                  randconfig-003-20230906   gcc  
i386                  randconfig-004-20230906   gcc  
i386                  randconfig-005-20230906   gcc  
i386                  randconfig-006-20230906   gcc  
i386                  randconfig-011-20230906   clang
i386                  randconfig-012-20230906   clang
i386                  randconfig-013-20230906   clang
i386                  randconfig-014-20230906   clang
i386                  randconfig-015-20230906   clang
i386                  randconfig-016-20230906   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230906   gcc  
x86_64       buildonly-randconfig-002-20230906   gcc  
x86_64       buildonly-randconfig-003-20230906   gcc  
x86_64       buildonly-randconfig-004-20230906   gcc  
x86_64       buildonly-randconfig-005-20230906   gcc  
x86_64       buildonly-randconfig-006-20230906   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230906   clang
x86_64                randconfig-002-20230906   clang
x86_64                randconfig-003-20230906   clang
x86_64                randconfig-004-20230906   clang
x86_64                randconfig-005-20230906   clang
x86_64                randconfig-006-20230906   clang
x86_64                randconfig-011-20230906   gcc  
x86_64                randconfig-012-20230906   gcc  
x86_64                randconfig-013-20230906   gcc  
x86_64                randconfig-014-20230906   gcc  
x86_64                randconfig-015-20230906   gcc  
x86_64                randconfig-016-20230906   gcc  
x86_64                randconfig-071-20230906   gcc  
x86_64                randconfig-072-20230906   gcc  
x86_64                randconfig-073-20230906   gcc  
x86_64                randconfig-074-20230906   gcc  
x86_64                randconfig-075-20230906   gcc  
x86_64                randconfig-076-20230906   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
