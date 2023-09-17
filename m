Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F957A3A24
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbjIQT73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbjIQT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:58:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB48B103
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694980723; x=1726516723;
  h=date:from:to:cc:subject:message-id;
  bh=0UBvZQk8W2sqVOMdunb/++Vx2wG67+eML/zERZC/ZKs=;
  b=jIIbyc7FghZjEZbZnS7xz8iylHtxtwGsbcMSHn3+CRmpDLIpSEVKJ94J
   sHE3r3asf3NJU+Nf7Emat2rtMUl1jbkL5DWDYpNI+pg+O4jimbUx/tsDm
   IR8ud81whVrzAZs4RVoXmdjVn/UDvPAAC433N88TxteoXgnDpqwqQBaM4
   Ex1waCuB4SSnoxseWNkSNd73KWMNbD0YzSGYC4fOd3fYla4mC43rBNjEP
   JWKMP8AzhoNSCZ+rClJp/udnAH13uuUt3B5UPduOzd9NJLweY+cQe0Kpp
   OAgkgwLbkANa18vy2PaWM6KQSFav4njfbZL1FbJPU8vuobcWhOZ2bX2xf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="383344871"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="383344871"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 12:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="1076367240"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="1076367240"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2023 12:58:42 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhxui-0005Qi-0e;
        Sun, 17 Sep 2023 19:58:40 +0000
Date:   Mon, 18 Sep 2023 03:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 ec2f16f180ae65b7c7179b4bb71af5fb2650f036
Message-ID: <202309180312.L0TpppvQ-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: ec2f16f180ae65b7c7179b4bb71af5fb2650f036  x86/platform/uv: Rework NMI "action" modparam handling

elapsed time: 722m

configs tested: 52
configs skipped: 111

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230917   gcc  
i386         buildonly-randconfig-002-20230917   gcc  
i386         buildonly-randconfig-003-20230917   gcc  
i386         buildonly-randconfig-004-20230917   gcc  
i386         buildonly-randconfig-005-20230917   gcc  
i386         buildonly-randconfig-006-20230917   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230917   gcc  
i386                  randconfig-002-20230917   gcc  
i386                  randconfig-003-20230917   gcc  
i386                  randconfig-004-20230917   gcc  
i386                  randconfig-005-20230917   gcc  
i386                  randconfig-006-20230917   gcc  
i386                  randconfig-011-20230917   gcc  
i386                  randconfig-012-20230917   gcc  
i386                  randconfig-013-20230917   gcc  
i386                  randconfig-014-20230917   gcc  
i386                  randconfig-015-20230917   gcc  
i386                  randconfig-016-20230917   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230917   gcc  
x86_64       buildonly-randconfig-002-20230917   gcc  
x86_64       buildonly-randconfig-003-20230917   gcc  
x86_64       buildonly-randconfig-004-20230917   gcc  
x86_64       buildonly-randconfig-005-20230917   gcc  
x86_64       buildonly-randconfig-006-20230917   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230917   gcc  
x86_64                randconfig-002-20230917   gcc  
x86_64                randconfig-003-20230917   gcc  
x86_64                randconfig-004-20230917   gcc  
x86_64                randconfig-005-20230917   gcc  
x86_64                randconfig-006-20230917   gcc  
x86_64                randconfig-011-20230917   gcc  
x86_64                randconfig-012-20230917   gcc  
x86_64                randconfig-013-20230917   gcc  
x86_64                randconfig-014-20230917   gcc  
x86_64                randconfig-015-20230917   gcc  
x86_64                randconfig-016-20230917   gcc  
x86_64                randconfig-071-20230917   gcc  
x86_64                randconfig-072-20230917   gcc  
x86_64                randconfig-073-20230917   gcc  
x86_64                randconfig-074-20230917   gcc  
x86_64                randconfig-075-20230917   gcc  
x86_64                randconfig-076-20230917   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
