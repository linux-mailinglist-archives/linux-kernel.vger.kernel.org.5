Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF77CB7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjJQBFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjJQBFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:05:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D49B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697504721; x=1729040721;
  h=date:from:to:cc:subject:message-id;
  bh=wClMW8iNBBtu282C8//2YDPq6HNv+JfERWA2cDNMHDE=;
  b=gsE8i9YVHenuycrD6WCu30qjDPkxC3wFTVzV4p1QMvoVgCAptLZGeATr
   P/I+DcuxhD/Zmg+OtuvE4uwdWMsQtk00oUknOgzK80M/oTxskjDSSVPtt
   ecQtKr+p8lnl1kn8u5BQwYaXAoNgrsjh8N848Bo4s8M/l3n00wl+7G5Ym
   G3jCnjuDSwb+iMfzf8QNvM+7UK0iCcIPjo63EmJrKLIvqRyYA7CA42YX0
   7wEjItOfKKk5oAvOsW2pQe+2yDR6VmEKO6kj078Ue1qJbkPQ2OMl1hrxY
   GVeyqWo2sEPcln2wyHi6EIhBrIw8hxFqw+diFw2xbnkCZ1vx/usK6n/Kh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388536248"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="388536248"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 18:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846615656"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="846615656"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2023 18:05:19 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsYWL-0008oH-1I;
        Tue, 17 Oct 2023 01:05:17 +0000
Date:   Tue, 17 Oct 2023 09:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 dcc134510eefaec6dda4fe71ab824f0300ed9f9f
Message-ID: <202310170922.RC2AOh0i-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: dcc134510eefaec6dda4fe71ab824f0300ed9f9f  alpha: Fix up new futex syscall numbers

elapsed time: 728m

configs tested: 3
configs skipped: 158

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
