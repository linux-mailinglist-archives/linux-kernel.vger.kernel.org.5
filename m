Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E590C79E231
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbjIMIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjIMIdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:33:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3F8E73
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:33:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E02C433C7;
        Wed, 13 Sep 2023 08:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694594007;
        bh=rPnckKz1MYdU330yUqXYFeZi3oxOU3A8T8nVPMp+cqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jWV5kJiwtYCiyIJS3ly/pdMPInls1PpYW5bXT0tN2eCNBjowv/OPFIh/qTocAyw/s
         M2uVSJULIW8QuLRmYMGYjdh0voDo5WygtEXbR6WrSF3bvtyq86LpADxXvDhaM1bd7s
         2nJnbcd8wkvgTi6pIWIS9HREEwQ0k8iynw5tHqGo=
Date:   Wed, 13 Sep 2023 10:33:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vme_user: Fix block comments where '*' on
 each line should be aligned
Message-ID: <2023091339-mountain-asleep-9439@gregkh>
References: <20230909184818.699987-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909184818.699987-1-bergh.jonathan@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 08:48:18PM +0200, Jonathan Bergh wrote:
> Fixed checkpatch warnings where lines with '*' in block comments should
> be aligned and were not as well as incorrect tab spacings at the start of
> comment lines.
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_tsi148.h | 140 +++++++++++++-------------
>  1 file changed, 70 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
> index dbdf5dabaf90..9748b7897527 100644
> --- a/drivers/staging/vme_user/vme_tsi148.h
> +++ b/drivers/staging/vme_user/vme_tsi148.h
> @@ -251,28 +251,28 @@ static const int TSI148_LCSR_VIACK[8] = { 0, TSI148_LCSR_VIACK1,
>   */
>  #define TSI148_LCSR_VMEFL	0x250
>  
> -	/*
> -	 * VME exception.
> -	 * offset  260
> +/*
> + * VME exception.
> + * offset  0x260

This change is not documented :(

Also I have two 2/2 patches, yet they are both different :(

Please fix this up and send a whole new series, properly versioned,
as-is, I have no idea what to do here.

thanks,

greg k-h
