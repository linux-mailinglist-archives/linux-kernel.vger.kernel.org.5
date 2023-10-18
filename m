Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7FB7CD67F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbjJRIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjJRIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:30:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70B510A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:30:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8113CC433C8;
        Wed, 18 Oct 2023 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697617803;
        bh=nqd1Er2SVD+f195ykGCKAmchFeMhVD66ZKH07we/Kcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7BpwiKr8QzZujWMuylf53Sw8/W22mAKdznRU5d24luzHlwsM7DrUCjOl2LFV2QPQ
         r4RAI/w421Yv8wF7jNU8N8SdkEw+4AdWSGgyuyDeCald3EskG3YS3bwBvOxrnVh8Mb
         vLrnQcsS1fOrCP0AtjTT88FRVUifnLmxd90CliwI=
Date:   Wed, 18 Oct 2023 10:30:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023101835-trapdoor-unicycle-788a@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018081941.475277-3-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB

For dual-licensed code, I need a LOT of documentation as to why this
must be dual-licensed, AND a signed-off-by from your corporate lawyer
agreeing to it so they convey an understanding of just how complex and
messy this will get over time and what you are agreeing to do here.

thanks,

greg k-h
