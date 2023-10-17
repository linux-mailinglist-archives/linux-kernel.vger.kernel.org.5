Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905E37CBA61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjJQFxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjJQFxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:53:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ED0F3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:53:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1A4C433C7;
        Tue, 17 Oct 2023 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697521997;
        bh=wvervu08O2tB/wlrgscAj5HHqJoy64a2u9WnJdsQOFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQTTaE9yO3KV+mdxcLE30eAfRNTaWZ5ElqHxXZbGUVIasU6Zw0gZM5jTFKdTt4xBW
         ybQKX17tDDtSD2a18ORTdat92dlUlSXEEzywQS/12eT4FhCxF1Y6aiuxijqIHvhx/n
         4Osfa162GVTb/XzTTio4x+hUSp7FOzw4K7DDNvNglqjJ3dM7QcQN0ym9oRtEdYcJax
         snyXBLq+TBdWj1MDNw1rmEKxOhJrIsBUd/C4M2HSq7ZYu5WGbvCNHslpcU4OzbVc9G
         u4myW1NvKzTmSTfGK3n0w6/nLI/OFnf0bB6FJpCJDrUy9cyoEBkPLnQEnBGVft2na7
         daAWzzxc5e9Kw==
Date:   Tue, 17 Oct 2023 07:53:13 +0200
From:   Simon Horman <horms@kernel.org>
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     m.chetan.kumar@intel.com, linuxwwan@intel.com,
        loic.poulain@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: wwan: iosm: Fixed multiple typos in
 multiple files
Message-ID: <20231017055313.GD1751252@kernel.org>
References: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 05:14:07PM +0500, Muhammad Muzammil wrote:
> iosm_ipc_chnl_cfg.h: Fixed typo
> iosm_ipc_imem_ops.h: Fixed typo
> iosm_ipc_mux.h: Fixed typo
> iosm_ipc_pm.h: Fixed typo
> iosm_ipc_port.h: Fixed typo
> iosm_ipc_trace.h: Fixed typo
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

Thanks Muhammad,

Please consider targeting Networking patches to either
'net' for bug fixes or 'net-next' for other patches.

	Subject: [PATCH net-next] ...

Looking at the git log the 'drivers: ' part of the prefix should be
dropped.

	Subject: [PATCH net-next] net: iosm: ...

And lastly, if you do spin a v2 of this patch, you might
consider also fixing the misspelling of 'defering' in iosm_ipc_imem_ops.h.

The above notwithstanding, these typo corrections look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
