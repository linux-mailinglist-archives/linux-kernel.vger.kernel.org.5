Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CED7D7CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjJZGCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjJZGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:02:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D7192
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698300147; x=1729836147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RpV5tiEQXcsp7xAk6InD/tYd82u0eWzjxZbIhp2hf+M=;
  b=mFybrtMYLe7bjpB9l7NsZNd7scE78E1JTADadsNxHMOQCX3I8T2iUN8J
   kvFKGZVKNv4BJ+LwnznCy4ll6Ggma0nul2oC2U8fwc7Q2Pq0k/NLz9FZi
   HiTuyh39cJeTg73CiYZw7bBUvA5V7hzU16u8fVLgZbUOevovjASzLLr6Q
   N9QHLZhdBUajFGrF5fdtxCzNyJOPuhoxN7t9FA+JR8dQRDvgm8zVR8Jfo
   VN2dw3VRP3wLY9m8MRQM2DSQKe+rngP/Gd65sIUatnAE72D0eeFyFBZmi
   DA2vwCemXqY/07e4/dZfGE3cwFyfjYeAFFk7FG/tSqHJ9hTwVAzWXnOhB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9023482"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9023482"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 23:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708948563"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="708948563"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 23:02:24 -0700
Date:   Thu, 26 Oct 2023 08:02:22 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] accel/ivpu: Delete the TODO file
Message-ID: <20231026060222.GA1024364@linux.intel.com>
References: <ZTAucrOT69/tQK2o@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTAucrOT69/tQK2o@runicha.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:43:54AM +0530, Deepak R Varma wrote:
> The work items listed in the TODO file of this driver file are either
> completed or dropped. The file is no more significant according
> to the maintainers. Hence removing it from the sources.
> 
> Suggested-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
Applied to drm-misc-next

Thanks
Stanislaw

> ---
>  drivers/accel/ivpu/TODO | 11 -----------
>  1 file changed, 11 deletions(-)
>  delete mode 100644 drivers/accel/ivpu/TODO
> 
> diff --git a/drivers/accel/ivpu/TODO b/drivers/accel/ivpu/TODO
> deleted file mode 100644
> index 9077217ae10f..000000000000
> --- a/drivers/accel/ivpu/TODO
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -- Move to threaded_irqs to mitigate potential infinite loop in ivpu_ipc_irq_handler()
> -- Implement support for BLOB IDs
> -- Add debugfs support to improve debugging and testing
> -- Add tracing events for performance debugging
> -- Implement HW based scheduling support
> -- Use syncobjs for submit/sync
> -- Refactor IPC protocol to improve message latency
> -- Implement BO cache and MADVISE IOCTL
> -- Add support for user allocated buffers using prime import and dma-buf heaps
> -- Refactor struct ivpu_bo to use struct drm_gem_shmem_object
> -- Add driver/device documentation
> --
> 2.39.2
> 
> 
> 
