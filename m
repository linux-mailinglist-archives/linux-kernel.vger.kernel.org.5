Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98779D305
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjILN6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjILN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:58:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7594710CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:58:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF466C433C7;
        Tue, 12 Sep 2023 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694527115;
        bh=Qxb5OeTFeZ+ZsKrEJy9GrxtMSRsKIsYqXQ1sY/E0zrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3S/9wa8C+0PNOA2/qZ6y8P62t+7OJkIGaIYJTx/KDIE/HMy2QtLW+baUXfgnub2b
         ImFP3M+BWIIIX7eWi9GAN4MSBszKVnBd0Fg8pGqBpG+xPdY+BBEuMc3i6wq22rRD2s
         fFrLHdI9vY79hnUIkbZyNxBbbN0twCDo/STjX8Dg=
Date:   Tue, 12 Sep 2023 15:58:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: vt6655: Type encoding info dropped from
 array name "byVT3253B0_"
Message-ID: <2023091210-wok-laziness-b64e@gregkh>
References: <ZP8Iu+Hh8YD+VhYH@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP8Iu+Hh8YD+VhYH@ubuntu.myguest.virtualbox.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 06:01:55PM +0530, Pavan Bobba wrote:
> Array names starting with "byVT3253B0_" updated like below:
> 
> a.type encoding info dropped from names
> b.camelcase names replaced by snakecase
> 
> Issue found by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
> 
>  v1 -> v2: Name of the tool added in the body of explanation,
>            which found this issue
> 
>  v2 -> v3: subject modified to more specific detail
> 
>  v3 -> v4: changelog modified as per patch submission guidelines
> 

I see 2 v4 patches on the mailing list, sent on different days.  Which
one is correct?

I'll drop both and wait for a v5.

thanks,

greg k-h
