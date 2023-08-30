Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD678E0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjH3Ud3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjH3Ud1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:33:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8707859F9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693427574; x=1724963574;
  h=date:from:to:cc:subject:message-id;
  bh=p/bP51GAV4S1IFoaZaMFZJn3wdmkm/1KpQrqhe/49qc=;
  b=bLOTSQ+gEbj8HTypQDmLdCJe+BZuY3bzPrefoW1ek0+9Iv4vOI8V0tVn
   u292X9nUJ1ah+6Owfn+R2HJNyBXIzZDHaZe/ysEhY/IFogDV39LEx/OAL
   /2qJ2ufSc++ECjj118RoO9T0Vxxl7nujl73J6pLURe+op18H2+YK6ZHlZ
   1HIuvqwuVHJFqa45dEKBjQnQFyqP3/+RCohcomc/qfoagWIFyzLAfb/AG
   xblv/y9DrJ6L3kas3lMd8zCMqmqxjUxm3Krkf2d+rlNOoZwhWpOooPjIh
   7G2iqvW6hdiLKEoEUDBaz5pdXGJ9RdUIDE29J3jFW9h5HBkHDjO63j4Ro
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439693935"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="439693935"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 13:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="739213780"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="739213780"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2023 13:31:45 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbRqq-000ACH-1o;
        Wed, 30 Aug 2023 20:31:44 +0000
Date:   Thu, 31 Aug 2023 04:25:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e8f13e061d75ed0eeaaf599532a6b197f195d5f3
Message-ID: <202308310445.3uHIMLMd-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e8f13e061d75ed0eeaaf599532a6b197f195d5f3  x86/audit: Fix -Wmissing-variable-declarations warning for ia32_xyz_class

elapsed time: 726m

configs tested: 52
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230830   clang
i386         buildonly-randconfig-002-20230830   clang
i386         buildonly-randconfig-003-20230830   clang
i386         buildonly-randconfig-004-20230830   clang
i386         buildonly-randconfig-005-20230830   clang
i386         buildonly-randconfig-006-20230830   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230830   clang
i386                  randconfig-002-20230830   clang
i386                  randconfig-003-20230830   clang
i386                  randconfig-004-20230830   clang
i386                  randconfig-005-20230830   clang
i386                  randconfig-006-20230830   clang
i386                  randconfig-011-20230830   gcc  
i386                  randconfig-012-20230830   gcc  
i386                  randconfig-013-20230830   gcc  
i386                  randconfig-014-20230830   gcc  
i386                  randconfig-015-20230830   gcc  
i386                  randconfig-016-20230830   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230830   clang
x86_64       buildonly-randconfig-002-20230830   clang
x86_64       buildonly-randconfig-003-20230830   clang
x86_64       buildonly-randconfig-004-20230830   clang
x86_64       buildonly-randconfig-005-20230830   clang
x86_64       buildonly-randconfig-006-20230830   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230830   gcc  
x86_64                randconfig-002-20230830   gcc  
x86_64                randconfig-003-20230830   gcc  
x86_64                randconfig-004-20230830   gcc  
x86_64                randconfig-005-20230830   gcc  
x86_64                randconfig-006-20230830   gcc  
x86_64                randconfig-011-20230830   clang
x86_64                randconfig-012-20230830   clang
x86_64                randconfig-013-20230830   clang
x86_64                randconfig-014-20230830   clang
x86_64                randconfig-015-20230830   clang
x86_64                randconfig-016-20230830   clang
x86_64                randconfig-071-20230830   clang
x86_64                randconfig-072-20230830   clang
x86_64                randconfig-073-20230830   clang
x86_64                randconfig-074-20230830   clang
x86_64                randconfig-075-20230830   clang
x86_64                randconfig-076-20230830   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
