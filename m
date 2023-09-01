Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA178FB02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348849AbjIAJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjIAJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:38:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B508210D5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693561114; x=1725097114;
  h=date:from:to:cc:subject:message-id;
  bh=pR8v0aIyOj7TZNyJmUKMnReItRZs4+qrFFBvbZYctwE=;
  b=DhucxiFMtxuhzU53nXOiWNogrVjslXqda79dqoEWiohWuHeQigYveCL8
   J/605bhFWdesubWW3AVWIxdgHQKfBI/4pHKUcQ044C9ylPTKVD6+iUqZk
   m9Yj0fwV0lVAltnuOGPbcQUhLRA2bMFyktvjSwDVvSjy/NT5zTwQgZnQ/
   5iMmKZP2GySuJENEo1wLuHQnBQ1Tio3A8TGYBhZjW0wCf2HabQbiwWrZb
   AmVehVbq/l/KgAuDVPDwDrn5BC1L8Xy3UR20eZCgCyiZd2Es1eDu4IErj
   yzRGZ9FHB+Od9qXu/8xAavrfD9FcrGGomxYDhjjHXs4XG0sagyt4gVgha
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440160288"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="440160288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 02:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739865982"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="739865982"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2023 02:38:33 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qc0bn-00019J-0V;
        Fri, 01 Sep 2023 09:38:31 +0000
Date:   Fri, 01 Sep 2023 17:37:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 cc852156ee7cbd4c83dfd64e9b800f7932f867d0
Message-ID: <202309011740.d2sww4V3-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: cc852156ee7cbd4c83dfd64e9b800f7932f867d0  powerpc: Fix pud_mkwrite() definition after pte_mkwrite() API changes

elapsed time: 724m

configs tested: 3
configs skipped: 181

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
