Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219857CDD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjJRN2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjJRN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:28:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1DFB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:28:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36355C433C8;
        Wed, 18 Oct 2023 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697635712;
        bh=jgCv0a1mlOuqJCd6p2vD9dhvth5LauxDgfbxCVtY3fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgW50rreyLuaykwNNcQrZpzkgzR7rqaEEwlKWHgfNT5bEf0pvw49DWbOzAGCdKcOD
         rryTMIvdMc7iKjIZCMtxozz71x2WzzbVG8rUJODaSCQYXpcu2AQCUa4kHRKah7foAx
         l8scmNu4hXL3QD29Hqcg+j0eJdO53+9foM506PtM=
Date:   Wed, 18 Oct 2023 15:28:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>, netdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumaran.4353@gmail.com
Subject: Re: [PATCH 0/2] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <2023101856-visa-unlimited-a365@gregkh>
References: <cover.1697568757.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697568757.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:03:57PM -0700, Nandha Kumar Singaram wrote:
> This patchset performs code cleanup in qlge driver as per
> linux coding style and may be applied in any sequence.
> 
> Nandha Kumar Singaram (2):
>   staging: qlge: Replace the occurrences of (1<<x) by BIT(x)
>   staging: qlge: Replace the occurrences of (1<<x) by BIT(x)

You have two different patches doing different things yet they have the
same identical subject lines.  That's not ok, sorry, please make unique
subject lines as obviously you are doing different things.

thanks,

greg k-h
