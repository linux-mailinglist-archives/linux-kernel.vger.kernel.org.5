Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA8A75BDC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGUFYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGUFYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02446B4;
        Thu, 20 Jul 2023 22:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BA7561083;
        Fri, 21 Jul 2023 05:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010BC433C8;
        Fri, 21 Jul 2023 05:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689917083;
        bh=uP1GA5LBzxRoakiLor42MSUvmlqDpFH4ESIV2TvRqCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lq3Duzd2fRaNRhbeUDc8UBA5W9RVp9qjauw+jXEO1Ka5jdmuo9hM8OBSiQaUTGpwo
         6pOYwJckjq3Bvb8suy5j9tvrx+BpCzj9x6IPr6iyjlBj7wUp0mzdc0uCdgTZIu6Sty
         K5jf7ORuWEuEL9R4cik04yOvVr+0xmXit1TyxUgA=
Date:   Fri, 21 Jul 2023 07:24:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Easwar Hariharan <eahariha@linux.microsoft.com>
Cc:     stable@vger.kernel.org, easwar.hariharan@microsoft.com,
        catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
        robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 5.15 0/4] ARM64 errata for stable kernel 5.15 and above
Message-ID: <2023072113-charm-manual-de9e@gregkh>
References: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:23:30PM -0700, Easwar Hariharan wrote:
> From: Easwar Hariharan <easwar.hariharan@microsoft.com>
> 
> This series works around a few ARM64 errata. Please pick these up for
> v6.1 and v6.4 as well.

The first 3 patches here are all in 6.1.y and 6.4.y, so how can they
also be added there?

thanks,

greg k-h
