Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3C7BF9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjJJL21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:28:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E194;
        Tue, 10 Oct 2023 04:28:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948EEC43391;
        Tue, 10 Oct 2023 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696937304;
        bh=5bnGt4lMhl5rzH037xz8U29xurwNmAHMeyXzFtlqGPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIjQ7djaafy0PD7j8vLxL1+4GcUyCtzJy21G6IEhsnaf2XJna1TE84W0Q5ZjkDb5H
         4GOq2Y2P9fEXHlIEuhYQNKmF8mL/zVUcoM3V/gUBkk1kEJ7e3X4HUaQzMjoDh4KDFX
         xvKqAA5vc/Ei/ZoIYFdTqKPA/GJLSB2H5A4OTauc=
Date:   Tue, 10 Oct 2023 13:28:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     wqu@suse.com, stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Message-ID: <2023101008-argue-impart-a6ad@gregkh>
References: <20231009130122.946357448@linuxfoundation.org>
 <20231010161046.7861.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010161046.7861.409509F4@e16-tech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 04:10:48PM +0800, Wang Yugui wrote:
> Hi,
> 
> > This is the start of the stable review cycle for the 6.1.57 release.
> > There are 162 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> > Anything received after that time might be too late.
> 
> 
> drop this patch from 6.5/6.1/5.15/... please, 
>   Qu Wenruo <wqu@suse.com>
>      btrfs: reject unknown mount options early
> 
> becuase of this report.
> https://lore.kernel.org/linux-btrfs/f3ac7b74-c011-4d1f-a510-677679fc9743@gmx.com/T/#t

Is there a revert somewhere for this already?

thanks,

greg k-h
