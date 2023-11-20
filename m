Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769377F1F61
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjKTVpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKTVpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:45:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89D6E3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700516716; x=1732052716;
  h=date:from:to:cc:subject:message-id;
  bh=0WaEgIJ+CklE58u2sbA6oOSyKzTrYzFajgJJJSedofE=;
  b=E6qII1kVkybAsFBBBQ6gTrdeaW4qYYP7C3gKCc6lC2GBSBcpW0x4Zlpx
   h6afHy22p8fDp7kGVySKqhCHFSRmmb4+KF2zvqAmsMitA0iIk4fH+LnWz
   3g24yfhPxvzOgkOB/yh+esa2hqMNAmpPBSezl8go/sxYQxzuugBSAENOt
   BuMT+VdXeMxRdE54kNc8tphkI/hKPokDOFgOTpDyBFNyS0LH1K4ZLnLmD
   XexdiaE/2m/3W85y6V8J+7VAtn7AzgzKaF53Y0/f0hy7bEdPZ8Wy4feeR
   in9yUzPo5pef4S48qC83iDYXTDTInyhtT6MluxrHkiT5Aqimc3T2QyyXb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382100498"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="382100498"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766439657"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="766439657"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Nov 2023 13:45:15 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5C4v-0006x7-0b;
        Mon, 20 Nov 2023 21:45:13 +0000
Date:   Tue, 21 Nov 2023 05:44:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 4e15b91c5b7919c530c27f39c7f2d392bf0a95e3
Message-ID: <202311210542.QaRNZ79u-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 4e15b91c5b7919c530c27f39c7f2d392bf0a95e3  x86/mtrr: Document missing function parameters in kernel-doc

elapsed time: 722m

configs tested: 50
configs skipped: 137

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231120   clang
i386         buildonly-randconfig-002-20231120   clang
i386         buildonly-randconfig-003-20231120   clang
i386         buildonly-randconfig-004-20231120   clang
i386         buildonly-randconfig-005-20231120   clang
i386         buildonly-randconfig-006-20231120   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231120   clang
i386                  randconfig-002-20231120   clang
i386                  randconfig-003-20231120   clang
i386                  randconfig-004-20231120   clang
i386                  randconfig-005-20231120   clang
i386                  randconfig-006-20231120   clang
i386                  randconfig-011-20231120   gcc  
i386                  randconfig-012-20231120   gcc  
i386                  randconfig-013-20231120   gcc  
i386                  randconfig-014-20231120   gcc  
i386                  randconfig-015-20231120   gcc  
i386                  randconfig-016-20231120   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231120   clang
x86_64       buildonly-randconfig-002-20231120   clang
x86_64       buildonly-randconfig-003-20231120   clang
x86_64       buildonly-randconfig-004-20231120   clang
x86_64       buildonly-randconfig-005-20231120   clang
x86_64       buildonly-randconfig-006-20231120   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231120   gcc  
x86_64                randconfig-002-20231120   gcc  
x86_64                randconfig-003-20231120   gcc  
x86_64                randconfig-004-20231120   gcc  
x86_64                randconfig-005-20231120   gcc  
x86_64                randconfig-006-20231120   gcc  
x86_64                randconfig-011-20231120   clang
x86_64                randconfig-012-20231120   clang
x86_64                randconfig-013-20231120   clang
x86_64                randconfig-014-20231120   clang
x86_64                randconfig-015-20231120   clang
x86_64                randconfig-016-20231120   clang
x86_64                randconfig-071-20231120   clang
x86_64                randconfig-072-20231120   clang
x86_64                randconfig-073-20231120   clang
x86_64                randconfig-074-20231120   clang
x86_64                randconfig-075-20231120   clang
x86_64                randconfig-076-20231120   clang
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
