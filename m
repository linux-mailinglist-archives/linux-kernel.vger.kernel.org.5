Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C31080B409
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 12:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjLILoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLILog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:44:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5858010DA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 03:44:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E91C433C7;
        Sat,  9 Dec 2023 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702122283;
        bh=pw89+S3o+Y1kMK3hZRtx1AOUlilB1qIakTnGLVDhbLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j48TNs3YzTG6TGGcT4Y1ML+ejJzHeFfqETyIWx0F6mgK5FV86r1JAKYqbD55aF2by
         S4+nX6mjxt2Za6tSaL4tv3vJH1PqLQtGzzpGFKld781txtNuq1sfHoyeiVXytr2KDB
         gQCqBfqNLV2Duh0QDm3nZ6AYNginHs890odwAPzs=
Date:   Sat, 9 Dec 2023 12:44:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Message-ID: <2023120932-revolver-apple-d4c9@gregkh>
References: <20231205183249.651714114@linuxfoundation.org>
 <fa221062-03b4-46d7-8708-9d3ce49961dd@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa221062-03b4-46d7-8708-9d3ce49961dd@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:31:48AM -0700, Shuah Khan wrote:
> On 12/5/23 12:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.203 release.
> > There are 131 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled. Fails to boot up. Boot hangs during systemd init sequence.
> I am debugging this and will update you.

Anything come of this?

thanks,

greg k-h
