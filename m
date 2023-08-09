Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437767756D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHIKJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjHIKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:09:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6003210D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691575774; x=1723111774;
  h=date:from:to:cc:subject:message-id;
  bh=rACa8DSwYOt/HzIlrk6AKTktz1J0jFVtV3Fc3lqHxb8=;
  b=cLtfkN7f/FH9JMGjfEtyqaYoRkdVdurStWn2Gvx1PTKf0Ndu+wvJYCAu
   H0UQSm92R1CW6HyoNnCzY0J1EWIO2oaxntrXo+7tRAU4b1sx0AUVGHCs2
   ci4sy5al2DwDSafLzQTK1iaUSoGqlZKx+CqvuVZq7KxbB8v+WP9JmJXZD
   V2OTQof6aSWapvjFEAGs6rF4rkzgrvFZo2wm21mmgltYQY8FP3Rx0dZsw
   lY/Y/9OhxdAfPX/8ICTuARM+9bCRyMEunRNeFcy6dwPp8ORFjHXulmeVX
   8alF2jzkdqowPi3D+RGaGZnohxplD0V3xS1W8UN/xyMTG9eu6cVESMCcj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373863621"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="373863621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="797115509"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="797115509"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2023 03:09:28 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTg88-000600-08;
        Wed, 09 Aug 2023 10:09:28 +0000
Date:   Wed, 09 Aug 2023 18:09:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7324f74d39531262b8e362f228b46512e6bee632
Message-ID: <202308091825.lcWS1py2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7324f74d39531262b8e362f228b46512e6bee632  x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h

elapsed time: 727m

configs tested: 36
configs skipped: 94

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230808   clang
i386         buildonly-randconfig-r005-20230808   clang
i386         buildonly-randconfig-r006-20230808   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230808   clang
i386                 randconfig-i002-20230808   clang
i386                 randconfig-i003-20230808   clang
i386                 randconfig-i004-20230808   clang
i386                 randconfig-i005-20230808   clang
i386                 randconfig-i006-20230808   clang
i386                 randconfig-i011-20230808   gcc  
i386                 randconfig-i012-20230808   gcc  
i386                 randconfig-i013-20230808   gcc  
i386                 randconfig-i014-20230808   gcc  
i386                 randconfig-i015-20230808   gcc  
i386                 randconfig-i016-20230808   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230808   clang
x86_64       buildonly-randconfig-r002-20230808   clang
x86_64       buildonly-randconfig-r003-20230808   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230809   clang
x86_64               randconfig-x003-20230809   clang
x86_64               randconfig-x004-20230809   clang
x86_64               randconfig-x006-20230809   clang
x86_64               randconfig-x011-20230808   clang
x86_64               randconfig-x012-20230808   clang
x86_64               randconfig-x013-20230808   clang
x86_64               randconfig-x014-20230808   clang
x86_64               randconfig-x015-20230808   clang
x86_64               randconfig-x016-20230808   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
