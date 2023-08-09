Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4191776B34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjHIVpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjHIVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:45:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC15C1702
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691617547; x=1723153547;
  h=date:from:to:cc:subject:message-id;
  bh=MefQFRFEiCEHrNh/1g24wRm/IK6xh2ldc734UBsJUHc=;
  b=ca1Z5KYpdggIgYXsjvsoHe9o3RklZatDANHphBv8apRFLq1TWPjc4HBE
   WpiQKuDAN68DJ036X4SzvGGHsvYEVMq6H7Qs0jm33JRpfNs2Sej347E4S
   sUduNB2b3Ekbf/cCFgXUEEp6NMh4Kibk1Qj4GfPHGQkH6+8owM4lamg1h
   73lylGnHHl9EBcIjXiMR9uYAd8b9JifZL/GNkTsqv+s43PwleHbPbgH7i
   GuZQ3SJ9/SK2fDURV9YCfKizBCaf6MEE68Ke0OorOV6k0AlJJwFLIzdCs
   eRLJlDIFLRQKVonC1LeRrefDS/rJW6DzSGndG2D9nZe/VIHtY7w69SPFM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="350817103"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="350817103"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 14:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="1062649518"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="1062649518"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2023 14:45:46 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTqzx-0006Qm-1j;
        Wed, 09 Aug 2023 21:45:45 +0000
Date:   Thu, 10 Aug 2023 05:44:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 04ce3638e18fbbedc4ac84a5f46736800c144a17
Message-ID: <202308100548.FmJ4GZld-lkp@intel.com>
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
branch HEAD: 04ce3638e18fbbedc4ac84a5f46736800c144a17  Merge branch into tip/master: 'x86/microcode'

elapsed time: 731m

configs tested: 39
configs skipped: 93

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230809   gcc  
i386         buildonly-randconfig-r005-20230809   gcc  
i386         buildonly-randconfig-r006-20230809   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230809   gcc  
i386                 randconfig-i002-20230809   gcc  
i386                 randconfig-i003-20230809   gcc  
i386                 randconfig-i004-20230809   gcc  
i386                 randconfig-i005-20230809   gcc  
i386                 randconfig-i006-20230809   gcc  
i386                 randconfig-i011-20230809   clang
i386                 randconfig-i012-20230809   clang
i386                 randconfig-i013-20230809   clang
i386                 randconfig-i014-20230809   clang
i386                 randconfig-i015-20230809   clang
i386                 randconfig-i016-20230809   clang
i386                 randconfig-r001-20230809   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230809   gcc  
x86_64       buildonly-randconfig-r002-20230809   gcc  
x86_64       buildonly-randconfig-r003-20230809   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230809   clang
x86_64               randconfig-x002-20230809   clang
x86_64               randconfig-x003-20230809   clang
x86_64               randconfig-x004-20230809   clang
x86_64               randconfig-x005-20230809   clang
x86_64               randconfig-x006-20230809   clang
x86_64               randconfig-x011-20230809   gcc  
x86_64               randconfig-x012-20230809   gcc  
x86_64               randconfig-x013-20230809   gcc  
x86_64               randconfig-x014-20230809   gcc  
x86_64               randconfig-x015-20230809   gcc  
x86_64               randconfig-x016-20230809   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
