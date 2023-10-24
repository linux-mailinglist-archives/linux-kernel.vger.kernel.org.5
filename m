Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11917D46BE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 06:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjJXEut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 00:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJXEur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 00:50:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA60F9;
        Mon, 23 Oct 2023 21:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698123044; x=1729659044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aIOzE6bNLPVOIYcQH23o8JO1UJmPW/YoaBdxr8nBjXo=;
  b=OXnlxgnNoRPFipwK4vI9AKG8tQWpfuS4Q5pE5Uc772UY503Tb4WQaCFF
   zOk6/ZPDsym56/d0LBbqQXIW/wYLSTUPxXdClpygWn4UXyQkDcvgR8FIL
   /39o8xQ9ZQIs5KQXPxsw4zjJXNMTSCSJilB9ABpFveOPXtDaHMqzSMau6
   CnkmOExd0PDA309Hho7pqmLoe1Vyx5RtA2chzK4JxoKpFsmSyJi79wQIE
   g8e2bAqocXLprkXJfPTw0WiSvEEv+1gCL3j6rUeen21xCW6vxEHyL3rc/
   QVsqiArg5OkR36x/xLgkgodLzxV2xisF78e5Os2OKLf8LEUe+D3hcIVws
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="377363925"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="377363925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 21:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089728862"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="1089728862"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2023 21:50:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D5BB394; Tue, 24 Oct 2023 07:50:39 +0300 (EEST)
Date:   Tue, 24 Oct 2023 07:50:39 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] thunderbolt: Fix one kernel-doc comment
Message-ID: <20231024045039.GC3208943@black.fi.intel.com>
References: <20231024004330.100898-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024004330.100898-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 08:43:30AM +0800, Yang Li wrote:
> Fix a spelling errors in kernel doc comment, silence the warning:
> 
> drivers/thunderbolt/tb.c:760: warning: expecting prototype for tb_maximum_banwidth(). Prototype was for tb_maximum_bandwidth() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7048
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to thunderbolt.git/next, thanks!
