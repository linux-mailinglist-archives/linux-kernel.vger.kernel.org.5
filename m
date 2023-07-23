Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C493975E04C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 09:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGWHhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 03:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWHhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 03:37:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2036E10FD;
        Sun, 23 Jul 2023 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690097826; x=1721633826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yOACp0ZvFmOn9ZDK237ln2wXZ58ULNm3KlJxD9UsGb4=;
  b=Lm95ZE+Tfh4cpaso9qtv26ECm7VITbeZZ2y18ONeKfG4xf9gxpFFxXRq
   l4ci4gUY+FBHNjayXt28zZjic7BBsKiSHevtXXpNHPUpuE3q++VvLVlZo
   IpfmIjN806zVT2nx+7Fe+Rz9fK3VFXRrVp7FZpPbhLdYIAj/yvh52pfFW
   NZLQcPkSCytIhEHke2/uOZ4oYZoDyZcxScKd478o34x1D/bCQe8CKy1Wx
   ZIP8WAV53hkGZmJ1QpZd/WQx3NHNa+gDV2fJ//8hFvQrXJ5sbZHm5qawM
   A5vye1Ugy7su82SNb63lHUIOBBh0psv+n78lgeOISdPxKVvhDhWeJMW/S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="370858872"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="370858872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 00:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="754959351"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="754959351"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2023 00:37:03 -0700
Date:   Sun, 23 Jul 2023 15:35:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v10 0/4] fpga: add initial KUnit tests for the subsystem
Message-ID: <ZLzYNY2pC6+qbuz+@yilunxu-OptiPlex-7050>
References: <20230718130304.87048-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718130304.87048-1-marpagan@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-18 at 15:03:00 +0200, Marco Pagani wrote:
> This patch set introduces an initial set of KUnit test suites for the
> core components of the FPGA subsystem.

Applied this series.

Thanks,
Yilun
